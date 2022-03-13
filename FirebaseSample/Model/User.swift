//
//  User.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/12.
//

import FirebaseFirestoreSwift
import SwiftUI
import FirebaseAuth
import Firebase


struct  User: Identifiable, Decodable {
//    let username: String            // ユーザーネーム
    let email: String               // ユーザーのメールアドレス
    let password: String
    
    
    
    
    let profileImageUrl: String     // ユーザーのアイコン画像URL
    let fullname: String            // ユーザーのフルネーム
    let uid: String                 // ユーザーのID
    @DocumentID var id: String?     // ユーザーのID
    var stats: UserStats?
    var isFollowed: Bool? = false
    
    var isCurrentUser: Bool { return AuthModel.shared.userSession?.uid == id}
}

struct UserStats: Decodable {
    var following: Int
    var posts: Int
    var followers: Int
}


