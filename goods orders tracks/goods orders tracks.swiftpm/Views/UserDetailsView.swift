//
//  UserDetailsview.swift
//  
//
//  Created by Shaw Young on 2021/12/25.
//

import SwiftUI

struct UserDetailsview: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State var showingEditUser = false
    @Environment(\.colorScheme) var colorScheme
    var user: User
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text("用户名称")
                        Spacer()
                        Text(user.name)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                    }
                    HStack {
                        Text("用户电话")
                        Spacer()
                        Text(user.phone)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                    }
                    HStack {
                        Text("用户性别")
                        Spacer()
                        Text(user.gender)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                    }
                
                }
            }
            .sheet(isPresented: $showingEditUser) {
                EditUserView(userId: self.user.id, userName: self.user.name, userPhone: self.user.phone, userGender: self.user.gender)
                    .environmentObject(userViewModel)
            }
            

        }
        .navigationTitle("用户信息")
        .toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                Button {
                    showingEditUser.toggle()
                } label: {
                    Text("Edit")
                }

            }
        }
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsview(user: User(gender: "male", id: 1, name: "sb", password: "114514", phone: "11231241242"))
    }
}
