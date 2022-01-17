//
//  MessageModel.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/09.
//

import Foundation
import FirebaseFirestore

//コレクション内のドキュメントに持たせるデータ
struct MessageModel {
    let userId : String  //Authでユーザー登録する際に決めたれた一意のIDをここで保持する?それを利用し自身の送信データと他の送信データかを分ける
    let userName: String
    let message: String
    let date: String
}

class MessageViewModel: ObservableObject {
    
    @Published var messages = [MessageModel]()
    
    let db = Firestore.firestore()
    
    //ルームが開かれた際にそのルームに対してリスナー設定する(roomId = Listから選択されたルームのId)
    func roomMessages(roomId: String){
        
        messages = []
        
        db.collection("rooms").document(roomId).collection("messages").addSnapshotListener { snapShot, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let snapShot = snapShot {
                for snap in snapShot.documentChanges{
                    let userId = snap.document.get("userId") as! String
                    let userName = snap.document.get("userName") as! String
                    let message = snap.document.get("message") as! String
                    let date = snap.document.get("date") as! String
                    
                    self.messages.append(MessageModel(userId: userId, userName: userName, message: message, date: date))
                }
            }
        }
    }
    
    //ルームに入った後のメッセージ送信で利用
    func sendMessage(userId: String, userName: String, message: String, date: String, roomId: String){
        
        let messageData = MessageModel(userId: userId, userName: userName, message: message, date: date)
        
        let data = [
            "userId": messageData.userId,
            "name": messageData.userName,
            "message": messageData.message,
            "data": "\(messageData.date)"
        ]
        db.collection("rooms").document(roomId).collection("messages").addDocument(data: data) { error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
