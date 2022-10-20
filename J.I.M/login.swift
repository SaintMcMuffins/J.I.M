//
//  login.swift
//  J.I.M
//
//  Created by Julian Manaois on 10/18/22.
//

import SwiftUI

struct login : View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            TextField("Username", text: $username)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
            Button(action: {print("Button tapped")}) {
                
            }
        }
    }
}
struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
