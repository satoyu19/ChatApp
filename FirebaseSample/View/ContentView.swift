//
//  ContentView.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/07.
//

import SwiftUI
import FirebaseFirestore
import Firebase

struct ContentView: View {
    
    @ObservedObject var roomViewModel = RoomViewModel()
    
    @ObservedObject var messageViewModel = MessageViewModel()
    
    @State var message = ""
    
    let db = Firestore.firestore()
    
    @State var roomName = ""
    
    var body: some View {
        VStack{
            //ルームリスト
            List(roomViewModel.rooms){ i in
                Text(i.roomName)
            }
            HStack{
                TextField("送信メッセージ", text: $roomName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button{
                    roomViewModel.makeRoom(roomName: roomName)
                }label: {
                    Text("作成")
                        .font(.largeTitle)
                }
            }
            
            HStack{
                TextField("送信メッセージ", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button{
                    
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    
                    // DateFormatter を使用して書式とロケールを指定する
                    dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
                    //Authに保存された送信者のデータを渡す(userId,name)、テスト中は仮の値を渡す
                    //roomIdもルーム選択された際に保持するようにする → ?
                    messageViewModel.sendMessage(userId: "000", userName: "仮", message: message, date: dateFormatter.string(from: currentDate), roomId: "juutXCdzRQNrTAywcfyC")
                } label: {
                    Text("送信")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
