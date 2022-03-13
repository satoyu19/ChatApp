//
//  FirebaseSampleApp.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/01/07.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct FirebaseSampleApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(AuthModel())
        }
    }
}
