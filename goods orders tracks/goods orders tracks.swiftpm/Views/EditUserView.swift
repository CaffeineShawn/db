//
//  EditUserView.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//

import SwiftUI

struct EditUserView: View {
    @Environment(\.dismiss) var dismiss
    @State var userId: Int
    @State var userName: String
    @State var userPhone: String
    @State var userGender: String
    @State var selectedGender: Int
    @EnvironmentObject var userViewModel: UserViewModel
    private let numberFormatter: NumberFormatter
    let genders: [String]
    init(userId: Int, userName: String, userPhone: String, userGender: String) {
        numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = false
        numberFormatter.maximumIntegerDigits = 14
        self.genders = ["男","女"]
//        print("init!")
        _userId = State(initialValue: userId)
        _userName = State(initialValue: userName)
        _userPhone = State(initialValue: userPhone)
        _userGender = State(initialValue: userGender)
        
        if _userGender.wrappedValue.description == Genders.male.rawValue {
            _selectedGender = State(initialValue: 0)
        } else {
            _selectedGender = State(initialValue: 1)
        }
        
        
       
    }
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("用户名称")) {
                    TextField(userName, text: $userName)}
                Section(header: Text("用户电话")) {
                    TextField(userPhone, text: $userPhone)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("用户性别")) {
                    Picker("用户性别", selection: $selectedGender) {
                        ForEach(genders.indices) {
                            Text(genders[$0])
                        }
                    }

                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button {
                        Task {
                            try await userViewModel.updateUser(id: userId, name: userName, gender: genders[selectedGender], phone: userPhone)
                            try await userViewModel.fetchUsers()
                        }
                        dismiss()
                    } label: {
                        Text("Submit")
                            .foregroundColor(.accentColor)
                    }

                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(userId: 1, userName: "sb", userPhone: "114514", userGender: Genders.male.rawValue)
    }
}
