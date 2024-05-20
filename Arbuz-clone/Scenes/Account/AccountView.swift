//
//  AccountView.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 18.05.2024.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var apiService: ApiService
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if apiService.isLoggedIn() {
                    userView
                } else {
                    loginSignUpView
                }
            }
            .padding()
            .navigationTitle(Text("Аккаунт"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
        }
    }
    
    private var loginSignUpView: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            HStack {
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    viewModel.signup()
                }) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 20)
        }
    }

    private var userView: some View {
        VStack {
            if let user = viewModel.user {
                Text("Welcome, \(user.username)!")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                Text("Email: \(user.email)")
                    .padding(.bottom, 20)
            }
            
            Button(action: {
                viewModel.logout()
            }) {
                Text("Logout")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    AccountView()
        .environmentObject(ApiService.shared)

}
