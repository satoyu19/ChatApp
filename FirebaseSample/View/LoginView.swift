//
//  LoginView.swift
//  FirebaseSample
//
//  Created by cmStudent on 2022/03/12.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthModel
    
    var body: some View {
        NavigationView {
                VStack {

                    
                    VStack {
                        TextField("メールアドレス", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                        SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())

                        Button(action: {
                            viewModel.login(withEmail: email, password: password)
                                

                        }) {
                            Text("ログイン")
                        }
                    }//VS
                    
                
                    
                    
                    NavigationLink(
                        destination: RegisterView().navigationBarHidden(true),
                        label: {
                            HStack {
                                Text("アカウント持ってない?→")
                                    .font(.system(size: 14))
                                
                                Text("ユーザー登録")
                                    .font(.system(size: 14, weight: .semibold))
                        }
                    }).padding(.bottom,16)
                    
                }//VS1
            
                .padding(.top, -44)
            
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
