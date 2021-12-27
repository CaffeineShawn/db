import SwiftUI

struct SettingView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var address: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(address, text: $address)
                }
                Button { 
                    UserDefaults.standard.set(address, forKey: "address")
                } label: { 
                    Text("confirm")
                }
                Button { 
                    UserDefaults.standard.removeObject(forKey: "address")
                } label: { 
                    Text("reset")
                        .foregroundColor(.red)
                }
                Section {
                    HStack {
                        Text("当前URL")
                        Spacer()
                        Text(address)
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        
                    }
                    Button { 
                        address = UserDefaults.standard.object(forKey: "address") as? String ?? "Not set yet"
                    } label: { 
                        Text("Get current url")
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
