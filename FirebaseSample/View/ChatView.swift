//
//  ChatView.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/16.
//

import SwiftUI

struct ChatView: View {
    
    let roomId: String?
    let roomName: String
    
    @State var message = ""
    
    @ObservedObject var messageViewModel = MessageViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(messageViewModel.messages, id:\.self){ message in
                    CommentCell(commentData: message)
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
            VStack {
                TextEditor(text: $message)
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                HStack {
                    Spacer()
                    Button{
                        
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()
                        
                        // DateFormatter を使用して書式とロケールを指定する
                        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))
                        //Authに保存された送信者のデータを渡す(userId,name)、テスト中は仮の値を渡す
                        //roomIdもルーム選択された際に保持するようにする → ?670C5675-AAC2-4987-B112-6550583E2EF3
                        messageViewModel.sendMessage(userId: "000", userName: "仮", message: message, date: dateFormatter.string(from: currentDate), roomId: roomId!)
                    } label: {
                        Text("送信")
                            .frame(width: 90, height: 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )                }
                    .padding()
                }
                
            }
            .padding()
            
            
        }
        .navigationTitle(roomName)
        .onAppear{
            if let roomId = roomId {
                messageViewModel.roomMessages(roomId: roomId)
            }
        }
    }
}
//
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView(roomId: "")
//    }
//}
