//
//  EditDataView.swift
//  Umow.sie
//
//  Created by Bartosz Strzecha on 06/12/2024.
//

import SwiftUI

struct EditDataView: View {
    
    var viewTitle: String
    var inputTitle: String
    
    @State var text: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var onSave: (String) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {
                Text(viewTitle)
                    .font(.title)
                    .fontWeight(.bold)
                
                InputView(text: $text, title: inputTitle, placeholder: "")
                    .autocapitalization(.none)
                   
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        onSave(text)
                        dismiss()
                    } label: {
                        Text("Zmień")
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EditDataView(viewTitle: "Zmiana adresu email",
                 inputTitle: "Nowy adres email",
                 onSave: { newEmail in
                     print("Zapisano nowy email: \(newEmail)")
                 })
}
