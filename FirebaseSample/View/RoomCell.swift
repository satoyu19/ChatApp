//
//  RoomCell.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/13.
//

import SwiftUI

struct RoomCell: View {
    let roomName: String
    var body: some View {
        HStack {
            Text(roomName)
                .foregroundColor(.customGreen)
            Spacer()
        }
        .padding()
    }
}

