//
//  AuthModel.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/12.
//

import SwiftUI
import Firebase
import FirebaseAuth
// environmentObject = アプリ内共通の設定
class AuthModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
    static let shared = AuthModel()
    
    init() {
        // 現在ログインしているユーザーを取得する
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    /// ログインする
    func login(withEmail email: String, password: String) {
        // Firebaseで決められた既存のユーザーをログインさせる方法
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    

    /// ユーザーを取得する
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        // Firebaseのコレクションからデータを取得
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
}

// Apple プラットフォームで Firebase Authentication を使ってみる
// https://firebase.google.com/docs/auth/ios/start?hl=ja

// Cloud Firestore にデータを追加する
// https://firebase.google.cn/docs/firestore/manage-data/add-data?hl=ja

// Cloud Firestore でデータを取得する
// https://firebase.google.cn/docs/firestore/query-data/get-data?hl=ja


