import SwiftUI

struct UserView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @State private var searchText = ""
    var searchResults: [User] {
        if searchText.isEmpty {
            return userViewModel.users
        } else {
            print(searchText)
            return userViewModel.filter(keyWord: searchText)
        }
    }    
    var body: some View {
        NavigationView {
            VStack {
                List {
                   
                    ForEach(searchResults, id: \.id) { user in
                        NavigationLink {
                            UserDetailsview(user: user)
                                .environmentObject(userViewModel)
                        } label: {
                            Text(user.phone)
                        }

                    }
                }
                .searchable(text: $searchText)
            }
           
           
            .onAppear {
                Task {
                    try await userViewModel.fetchUsers()
                }
            }
            .refreshable {
                Task {
                    try await userViewModel.fetchUsers()
                }
            }
            
            .navigationTitle("Users")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
