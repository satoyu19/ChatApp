//
//  ChatView.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/16.
//

import SwiftUI

struct ChatView: View {
    
    let roomId: String?
    
    @State var message = ""
    
    @ObservedObject var messageViewModel = MessageViewModel()
    
    var body: some View {
        List(messageViewModel.messages){ message in
            Text(message.message)
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
                            //roomIdもルーム選択された際に保持するようにする → ?670C5675-AAC2-4987-B112-6550583E2EF3
                            messageViewModel.sendMessage(userId: "000", userName: "仮", message: message, date: dateFormatter.string(from: currentDate), roomId: roomId!)
                        } label: {
                            Text("送信")
                        }
                    }
        .onAppear{
            if let roomId = roomId {
                messageViewModel.roomMessages(roomId: roomId)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(roomId: "")
    }
}
