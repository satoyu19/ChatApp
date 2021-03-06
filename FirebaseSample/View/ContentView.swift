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
    
    
    let db = Firestore.firestore()
    
    @State var roomName = ""
    
    var body: some View {
        
        NavigationView{
            VStack{
                //ルームリスト
                List(roomViewModel.rooms) { i in
                    let roomId = i.id
                    //                let roomId = "670C5675-AAC2-4987-B112-6550583E2EF3"
                    //                Button{
                    NavigationLink(destination: ChatView(roomId: roomId, roomName:i.roomName)){
                        RoomCell(roomName:i.roomName)
                    }
                    //                }label : {
                    //                    Text(i.roomName)
                    //                }
                }
                
                HStack {
                    TextField("スレッドを作成", text: $roomName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button{
                        roomViewModel.makeRoom(roomName: roomName)
                    } label: {
                        Text("作成")
                    }
                    .frame(width: 90, height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .padding()
                
                //            HStack{
                //                TextField("送信メッセージ", text: $message)
                //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //
                //                Button{
                //
                //                    let currentDate = Date()
                //                    let dateFormatter = DateFormatter()
                //
                //                    // DateFormatter を使用して書式とロケールを指定する
                //                    dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
                //                    //Authに保存された送信者のデータを渡す(userId,name)、テスト中は仮の値を渡す
                //                    //roomIdもルーム選択された際に保持するようにする → ?
                //                    messageViewModel.sendMessage(userId: "000", userName: "仮", message: message, date: dateFormatter.string(from: currentDate), roomId: "670C5675-AAC2-4987-B112-6550583E2EF3")
                //                } label: {
                //                    Text("送信")
                //                }
                //            }
            }
            .navigationTitle("3ch")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
