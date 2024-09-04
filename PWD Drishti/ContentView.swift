//
//  ContentView.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 19/07/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var isLoggedIn: Bool = false
    var body: some View {
        if(userLogin()){
            LoginView()
        }
        else{
                Table()
        }
    }
    
    func userLogin() -> Bool {
            let userId = (UserDefaults.standard.string(forKey: "api_key") ?? "") as String
        if(userId.isEmpty){
            return true
        }
        else{
            return false
        }
    }//end userLogin

}

struct LoginView: View {
    @State private var username:String=""
    @State private var password:String=""
    @State private var error:String=""
    @State var isLoggedIn:Bool = false
    @State private var inputText: String=""
    @State private var navigateToTable = false
    var body: some View {
        if(isLoggedIn){
            Table()
        }else{
            ZStack(alignment:.center){
                Image("Image")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity)
                VStack{
                    Image("image2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                    
                    Text("PWD Drishti")
                        .foregroundStyle(.pink)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                    
                    Text("Login")
                        .foregroundStyle(.pink)
                        .bold()
                        .padding(EdgeInsets(top: 50, leading: 0, bottom:0, trailing: 10))
                    TextField("Enter You Mobile Number",text: $username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal,30)
                    TextField("Enter You Password",text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal,30)
                    
                    Button(action: {
                        API().userLogin(mobile: self.username, pass: self.password, completion: { (resp) in
                            print("resp\(resp)")
                            let data = resp
                            let resStatus = data["success"] as! Bool
                            if resStatus {
                                let userData = data["data"] as! NSArray
                                let userFirstData = userData[0] as! NSDictionary
                                
                                let useridVal = userFirstData["user_id"] as! Int64
                                let mobileVal = userFirstData["mobile"] as! String
                                let apiKeyVal = userFirstData["api_key"] as! String
                                let userPassVal = userFirstData["user_password"] as! String
                                let roleIdVal = userFirstData["role_id"] as! Int
                                let userNameVal = userFirstData["user_name"] as! String
                                
                                UserDefaults.standard.set(useridVal, forKey: "user_id")
                                UserDefaults.standard.set(mobileVal, forKey: "mobile")
                                UserDefaults.standard.set(apiKeyVal, forKey: "api_key")
                                UserDefaults.standard.set(userPassVal, forKey: "user_password")
                                UserDefaults.standard.set(roleIdVal, forKey: "role_id")
                                UserDefaults.standard.set(userNameVal, forKey: "user_name")
                                self.isLoggedIn=true
                            }
                        }, failed: { (error) in
                            print(error)
                        })
                        //viewModel.login()
                        /*
                         if viewModel.isLoggedIn {
                         let data = viewModel.loginData
                         let resStatus = data["success"] as! Bool
                         if resStatus {
                         let userData = data["data"] as! NSArray
                         let userFirstData = userData[0] as! NSDictionary
                         
                         let useridVal = userFirstData["user_id"] as! Int64
                         let mobileVal = userFirstData["mobile"] as! String
                         let apiKeyVal = userFirstData["api_key"] as! String
                         let userPassVal = userFirstData["user_password"] as! String
                         let roleIdVal = userFirstData["role_id"] as! Int
                         let userNameVal = userFirstData["user_name"] as! String
                         
                         UserDefaults.standard.set(useridVal, forKey: "user_id")
                         UserDefaults.standard.set(mobileVal, forKey: "mobile")
                         UserDefaults.standard.set(apiKeyVal, forKey: "api_key")
                         UserDefaults.standard.set(userPassVal, forKey: "user_password")
                         UserDefaults.standard.set(roleIdVal, forKey: "role_id")
                         UserDefaults.standard.set(userNameVal, forKey: "user_name")
                         self.isLoggedIn = true
                         }
                         }*/
                    }, label: {
                        Image(systemName: "arrow.right.circle")
                        Text("Login")
                        
                    })
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)
                    .tint(.pink)
                    .padding(.top, 50)
                    
                    /* if !viewModel.loginError.isEmpty {
                     Text(viewModel.loginError)
                     .foregroundColor(.red)
                     }
                     
                     if viewModel.isLoggedIn {
                     let uid = UserDefaults.standard.string(forKey: "api_key") ?? ""
                     Text("Logged in successfully! \(uid)")
                     .foregroundColor(.green)
                     }*/
                }
                .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                .padding()
            }
        }
    }
}

class API {
    func userLogin(mobile: String, pass: String, completion: @escaping(NSDictionary) -> (), failed: @escaping(String) -> ()){
        
        let loginRequest = LoginRequest(user_id: mobile, user_password: pass)
        
        guard let url = URL(string: "https://pwddrishti.cgstate.gov.in/api/login") else {
            failed("The URL is invalid.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(loginRequest)
        } catch {
            failed("There was an error encoding the data.")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                failed("Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                failed("The response from the server was invalid.")
                return
            }
            
            guard let data = data else {
                failed("The response from the server was invalid.")
                return
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data,options: .mutableContainers) as? NSDictionary
                print("dictionary \(dictionary ?? [:])")
                completion(dictionary ?? [:])
            } catch {
                failed("There was an error during login")
            }
        }.resume()
        
    }
    static func login(loginRequest: LoginRequest, completion: @escaping (Result<NSDictionary, Error>) -> Void) {
        guard let url = URL(string: "https://pwddrishti.cgstate.gov.in/api/login") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(loginRequest)
        } catch {
            completion(.failure(APIError.encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data,options: .mutableContainers) as? NSDictionary
                print("dictionary \(dictionary ?? [:])")
                completion(.success(dictionary ?? [:]))
            } catch {
                completion(.failure(APIError.loginError))
            }
        }.resume()
    }
}

/*class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var loginError: String = ""
    @Published var loginData: NSDictionary=[:]

    /*func login() {
        let loginRequest = LoginRequest(user_id: username, user_password: password)
        print("Login Request: \(loginRequest)") // Log request details

        API.login(loginRequest: loginRequest) { result in
            DispatchQueue.main.async{
                switch result {
                case .success(let data):
                    print("API Response: \(data)") // Log response details
                        self.isLoggedIn=true
                        self.loginError=""
                        self.loginData=data
                    print(self.loginData)
                case .failure(let error):
                    self.isLoggedIn = false
                    self.loginError = error.localizedDescription
                    print("Error: \(error)") // Log error details
                    
                }
            }
        }
    }*/
    
    func login() {
        let loginRequest = LoginRequest(user_id: username, user_password: password)
        print("Login Request: \(loginRequest)") // Log request details

        API.login(loginRequest: loginRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("API Response: \(data)") // Log response details
                    self.loginData = data
                    
                    if let success = data["success"] as? Int, success == 1 {
                        self.isLoggedIn = true
                        self.loginError = ""
                        
                        if let userDataArray = data["data"] as? [[String: Any]], let userData = userDataArray.first {
                            print("Login Successful")
                            print("User Data: \(userData)")
                        } else {
                            print("Invalid user data format")
                        }
                    } else {
                        self.isLoggedIn = false
                        self.loginError = "Login failed"
                        if let message = data["message"] as? String {
                            print("Login failed: \(message)")
                        }
                    }
                    
                case .failure(let error):
                    self.isLoggedIn = false
                    self.loginError = error.localizedDescription
                    print("Error: \(error)") // Log error details
                }
            }
        }
    }
    
}*/

enum APIError: Error, LocalizedError {
    case invalidURL
    case encodingError
    case invalidResponse
    case loginError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .encodingError:
            return "There was an error encoding the data."
        case .invalidResponse:
            return "The response from the server was invalid."
        case .loginError:
            return "There was an error during login"
        }
    }
    
}



#Preview {
    ContentView()
}
