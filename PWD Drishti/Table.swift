//
//  Table.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 22/07/24.
//
import SwiftUI

/*struct Table: View {
    @State private var inputtext: String = ""
    @State private var showingPopover: Bool = false
    @State private var logout: Bool = false

    var body: some View {
        NavigationView {
            if logout {
                ContentView()
            } else {
                VStack {
                    HStack {
                        Button(action: { showingPopover = true }, label: {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        })
                        .popover(isPresented: $showingPopover) {
                            ProfilePopOverContent(showingPopover: $showingPopover)
                        }
                        .frame(maxWidth: .infinity)

                        if let userId = UserDefaults.standard.string(forKey: "user_id") {
                            Text("USER ID: \(userId)")
                        } else {
                            Text("USER ID: Not available")
                        }

                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: "user_id")
                            UserDefaults.standard.removeObject(forKey: "mobile")
                            UserDefaults.standard.removeObject(forKey: "api_key")
                            UserDefaults.standard.removeObject(forKey: "user_password")
                            UserDefaults.standard.removeObject(forKey: "role_id")
                            UserDefaults.standard.removeObject(forKey: "user_name")
                            logout = true
                        }, label: {
                            Text("Logout")
                            Image(systemName: "arrow.right.circle.fill")
                        })
                        .frame(maxWidth: .infinity)
                    }

                    TextField("Search by Work ID", text: $inputtext)
                        .padding(.leading, 100)
                        .background(Color(.systemGray5))
                        .cornerRadius(50)
                        .padding()

                    WorkList(searchQuery: inputtext)
                }
            }
        }
    }
}*/

struct Table: View {
    @State private var inputtext: String = ""
    @State private var showingPopover: Bool = false
    @State private var logout: Bool = false
    
    var body: some View {
        NavigationView {
            if logout {
                ContentView()
            } else {
                VStack {
                    HStack {
                        Button(action: { showingPopover = true }, label: {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        })
                        .popover(isPresented: $showingPopover) {
                            ProfilePopOverContent(showingPopover: $showingPopover)
                        }
                        .frame(maxWidth: .infinity)
                        
                        if let userId = UserDefaults.standard.string(forKey: "user_id") {
                            Text("USER ID: \(userId)")
                        } else {
                            Text("USER ID: Not available")
                        }
                        
                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: "user_id")
                            UserDefaults.standard.removeObject(forKey: "mobile")
                            UserDefaults.standard.removeObject(forKey: "api_key")
                            UserDefaults.standard.removeObject(forKey: "user_password")
                            UserDefaults.standard.removeObject(forKey: "role_id")
                            UserDefaults.standard.removeObject(forKey: "user_name")
                            logout = true
                        }, label: {
                            Text("Logout")
                            Image(systemName: "arrow.right.circle.fill")
                        })
                        .frame(maxWidth: .infinity)
                    }
                    
                    TextField("Search by Work ID", text: $inputtext)
                        .padding(.leading, 100)
                        .background(Color(.systemGray5))
                        .cornerRadius(50)
                        .padding()
                    
                    WorkList(searchQuery: inputtext)
                }
            }
        }
    }
}


struct ProfilePopOverContent:View{
    @Binding var showingPopover: Bool
    var body: some View{
        VStack{
            HStack(alignment:.top){
                Button(action: {showingPopover=false}, label: {
                    Text("Cancel")
                })
                .padding(.top,10)
                .padding(.leading,10)
                Spacer()
            }
            Spacer()
            VStack{
                if let userId = UserDefaults.standard.string(forKey: "user_id") {
                    Text("USER ID: \(userId)")
                }else {
                    Text("USER ID: Not available")
                }
                if let userName = UserDefaults.standard.string(forKey: "user_name") {
                    Text("USER Name: \(userName)")
                }else {
                    Text("USER Name: Not available")
                }
                if let userNumber = UserDefaults.standard.string(forKey: "number") {
                    Text("USER Number: \(userNumber)")
                }else {
                    Text("USER Number: Not available")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(20)
            Spacer()
        }
    }
}
/*#Preview{
    Table(isLoggedIn: $isLoggedIn)
}*/
