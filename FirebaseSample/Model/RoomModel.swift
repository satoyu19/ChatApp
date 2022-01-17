//
//  RoomModel.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/09.
//

import Foundation
import FirebaseFirestore

//roomsコレクションのドキュメントが保持するデータ
//idを利用してルームごとの特定を行う？
struct RoomModel: Identifiable {
    let roomName: String
    let id: String
    
    init(roomName: String, id: String) {
        self.roomName = roomName
        self.id = id
    }
}

//更新データがバックエンドに書き込まれる前にリスナーに通知する。（処理が実行される？）
class RoomViewModel: ObservableObject{
    
    @Published var rooms = [RoomModel]()
    
    let db = Firestore.firestore()

    init(){
        
        db.collection("rooms").addSnapshotListener { snapShot, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            if let snapShot = snapShot {
                //変更した内容のみを取得
                for snap in snapShot.documentChanges{
                    //変更内容が追加であれば
                    if snap.type == .added{
                        let roomName = snap.document.get("roomName") as! String
                        let id = snap.document.get("roomID") as! String
                        //ルーム作成時に生成されたidを保持
                        self.rooms.append(RoomModel.init(roomName: roomName, id: id))
                    }
                }
            }
        }
    }
    
    //ルームの作成
    func makeRoom(roomName: String){
        
        let id = UUID().uuidString
        print(id)
        
        let roomData = RoomModel(roomName: roomName, id: id)
        
        let data = [
            "roomID": roomData.id,
            "roomName": roomData.roomName
        ]
        
        //roomsコレクションにドキュメントを作成、ルーム名と一意のIDを保持
        db.collection("rooms").document(roomData.id).setData(data)
    }
}
