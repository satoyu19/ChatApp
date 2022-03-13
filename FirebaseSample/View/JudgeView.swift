//
//  JudgeView.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: Model
    @State var selectedIndex = 0
    
    var body: some View {
        // アカウントの所持・未所持で遷移先を分ける
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                if viewModel.currentUser != nil {
                    ContentView()
                }
            }
        }
    }
}

struct JudgeView_Previews: PreviewProvider {
    static var previews: some View {
        JudgeView()
    }
}
