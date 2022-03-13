//
//  CommentCell.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/13.
//

import SwiftUI

struct CommentCell: View {
    let commentData: MessageModel
    var body: some View {
        VStack {
            ZStack {
                
                HStack{
                    Text(commentData.userName)
                        .foregroundColor(.customGreen)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(commentData.date)
                        .foregroundColor(.customGreen)
                }
            }
            
            VStack {
                Text(commentData.message)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(20)
    }
}

//struct CommentCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentCell()
//    }
//}
