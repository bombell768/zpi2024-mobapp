//
//  ProfileView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 05/12/2024.
//

import SwiftUI

struct ProfileView: View {
    

    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                        UserDefaults.standard.set(nil, forKey: "authToken")
                        print(UserDefaults.standard.bool(forKey: "isLoggedIn"))
                    } label: {
                        HStack {
                            Text("Wyloguj")
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.black)
                        .frame(width: 110, height: 38)
                        
                    }
                    .background(Color.ui.vanilla)
                    .cornerRadius(10)
                    
                }


                Text("Aleksandra Matuszowiecka")
                    .font(.title)
                    .fontWeight(.bold)
                
                

                
                VStack(alignment:.leading, spacing: 20) {
                    Text("Konto")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text("Email: aleksandra.matuszowiecka@gmail.pl")
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                    }
                    
                    HStack {
                        Text("Numer telefonu: 513 234 983")
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                    }
                    
                    HStack {
                        Text("Preferowane usługi: Dla Kobiet")
                            .font(.system(size: 18))
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.system(size: 22))
                    }
                    
                    HStack {
                        Spacer()
                        Text("Zmień hasło")
                            .foregroundStyle(Color.ui.vanilla)
                            .fontWeight(.semibold)
                            .font(.system(size: 18))
                    }
                    .padding(.top)
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color.ui.vanilla)
                    
                VStack(alignment: .leading, spacing: 36) {
                    Text("Twoje pieczątki")
                        .font(.title2)
                        .fontWeight(.bold)
                
                    StampView(earnedStamps: 4)
                }
                

                Spacer()
            }
            .padding()

        }
    }
}

#Preview {
    ProfileView()
}
