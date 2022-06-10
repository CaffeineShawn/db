import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var address: String = ""
    @FocusState private var addressIsFocused: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("修改后台")) {
                    HStack {
                        TextField(address, text: $address)
                            .focused($addressIsFocused)
                        Spacer()
                        Button {
                            addressIsFocused = false
                        } label: {
                            Text("Dismiss")
                                .foregroundColor(.accentColor)
                        }
                    }
                   
                    Button {
                        UserDefaults.standard.set(address, forKey: "address")
                    } label: {
                        Text("Confirm")
                          
                    }
                    Button {
                        UserDefaults.standard.removeObject(forKey: "address")
                    } label: {
                        Text("Reset")
                            .foregroundColor(.red)
                       
                    }
                }
                
                Section(header: Text("获取后台")) {
                    HStack {
                        Text("当前URL")
                        Spacer()
                        Text(address)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        
                    }
                    Button { 
                        address = UserDefaults.standard.object(forKey: "address") as? String ?? "Not set yet"
                    } label: { 
                        Text("Get Current URL")
                    
                    }
                    
                }
                
                
                
            }
            
            .onAppear(perform: { 
                address = UserDefaults.standard.object(forKey: "address") as? String ?? "Not set yet"
            })
            .navigationTitle("Settings")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
