//
//  FriendList.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 22/07/24.
//

import SwiftUI
import UIKit
import Foundation
import CoreLocation
import Combine


struct Work: Codable, Hashable,Identifiable {
    var id=UUID()
    var user_id: String?
    var work_code: String?
    var work_name: String?
    var work_category: Int?
    var work_status: String?
}

struct DataList {
    static let works: [Work] = [
        Work(user_id: "52119174", work_code: "W9943", work_name: "Project Alpha", work_category: 1, work_status: "Completed"),
                Work(user_id: "52119174", work_code: "W9944", work_name: "Project Beta", work_category: 1, work_status: "In Progress"),
                Work(user_id: "52119174", work_code: "W9945", work_name: "Project Gamma", work_category: 2, work_status: "Pending"),
                Work(user_id: "52119175", work_code: "W9946", work_name: "Project Delta", work_category: 2, work_status: "Completed"),
                Work(user_id: "52119175", work_code: "W9947", work_name: "Project Epsilon", work_category: 3, work_status: "In Progress"),
                Work(user_id: "52119176", work_code: "W9948", work_name: "Project Zeta", work_category: 1, work_status: "Pending"),
                Work(user_id: "52119176", work_code: "W9949", work_name: "Project Eta", work_category: 3, work_status: "Completed"),
                Work(user_id: "52119177", work_code: "W9950", work_name: "Project Theta", work_category: 2, work_status: "In Progress"),
                Work(user_id: "52119177", work_code: "W9951", work_name: "Project Iota", work_category: 1, work_status: "Completed"),
                Work(user_id: "52119178", work_code: "W9952", work_name: "Project Kappa", work_category: 3, work_status: "Pending"),
                Work(user_id: "52119178", work_code: "W9953", work_name: "Project Lambda", work_category: 2, work_status: "In Progress"),
                Work(user_id: "52119179", work_code: "W9954", work_name: "Project Mu", work_category: 1, work_status: "Completed"),
                Work(user_id: "52119179", work_code: "W9955", work_name: "Project Nu", work_category: 3, work_status: "Pending")]
}

/*struct WorkList: View {
    @StateObject private var viewModel = UserViewModel()
    var searchQuery: String
    @State var workList: [Work]  = DataList.works
    var body: some View {
        NavigationView{
            let filteredWorks = searchQuery.isEmpty ? workList : workList.filter { work in
                            work.work_code?.contains(searchQuery) ?? false
                        }
            List(filteredWorks) {
                work in NavigationLink(destination: WorkDetailView(work:work)){
                    WorkRow(work: work)
                }
            }
            .onAppear{
                viewModel.fetchUserData()
            }
        }
    }
}*/

struct WorkList: View {
    @StateObject private var viewModel = UserViewModel()
    var searchQuery: String
    @State var workList: [Work] = DataList.works

    var body: some View {
        let filteredWorks = searchQuery.isEmpty ? workList : workList.filter { work in
            work.work_code?.contains(searchQuery) ?? false
        }

        List(filteredWorks) { work in
            NavigationLink(destination: WorkDetailView(work: work)) {
                WorkRow(work: work)
            }
        }
        .onAppear {
            viewModel.fetchUserData()
        }
    }
}

struct WorkRow: View{
    var work: Work
    var body:some View{
        HStack{
            VStack(alignment:.leading){
                HStack{
                    Text("Work ID:")
                        .fontWeight(.bold)
                    Text(work.work_code ?? "Unkown Work Code")
                        .fontWeight(.bold)
                }
                
                HStack{
                    Text("Work Name:")
                        .fontWeight(.bold)
                    Text(work.work_name ?? "Unkown Work Name")
                        .fontWeight(.bold)
                }
            }
           
            Spacer()
        }
    }
}
                         
/*struct WorkDetailView: View {
    var work: Work
    @State private var showingPopover = false

    var body: some View {
        VStack() {
            Text("Work ID: \(work.user_id ?? "Unknown Work ID")")
            Text("Work Name: \(work.work_name ?? "Unknown Name")")
            Text("Work Category: \(work.work_category != nil ? String(work.work_category!) : "Unknown Category")")
            Text("Work Status: \(work.work_status ?? "Unknown Status")")
                .frame(alignment: .leading)
                .frame(width: 200, height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray)
                        .opacity(0.5)
                )
            Spacer()
            Button(action: { showingPopover.toggle() }) {
                Label("Add Entry", systemImage: "mappin.and.ellipse")
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .popover(isPresented: $showingPopover) {
                CameraLocation(showingPopover: $showingPopover)
            }
            Spacer()
        }
        .position(x:200,y: 400)
    }
}*/

struct WorkDetailView: View {
    var work: Work
    @State private var showingPopover = false

    var body: some View {
        VStack {
            Text("Work ID: \(work.user_id ?? "Unknown Work ID")")
            Text("Work Name: \(work.work_name ?? "Unknown Name")")
            Text("Work Category: \(work.work_category != nil ? String(work.work_category!) : "Unknown Category")")
            Text("Work Status: \(work.work_status ?? "Unknown Status")")
                .frame(alignment: .leading)
                .frame(width: 200, height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.gray)
                        .opacity(0.5)
                )
            Spacer()
            Button(action: { showingPopover.toggle() }) {
                Label("Add Entry", systemImage: "mappin.and.ellipse")
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .popover(isPresented: $showingPopover) {
                CameraLocation(showingPopover: $showingPopover)
            }
            Spacer()
        }
        .position(x: 200, y: 400)
    }
}


/*struct Listrow: View{
    var user: User
    var body:some View{
        HStack{
            VStack(alignment:.leading){
                HStack{
                    AsyncImage(url: URL(string: user.avatar)) { image in
                        image.resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } placeholder: {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                      .aspectRatio(contentMode: .fit)
                      .frame(width: 100, height: 100)
                    Text("Work ID:")
                        .fontWeight(.bold)
                        .padding(.top,35)
                    Text("\(user.id)")
                        .padding(.top,35)
                }
                Text("\(user.first_name)")
                    .padding(.leading,20)
                    .fontWeight(.bold)
            }
           
            Spacer()
        }
    }
}
*/
/*struct friendDetailView: View {
    var user:User
    @State private var showingPopover=false

    var body: some View {
            VStack{
                VStack{
                    Text("Work ID: \(user.id)")
                    Text("Work Name: \(user.first_name)"+" \(user.last_name)")
                }
                .frame(alignment: .leading)
                .frame(width: 200,height: 100)
                .background(
                    RoundedRectangle(cornerRadius: 15).fill(.gray).opacity(0.5)
                )
                    Button(action: {showingPopover.toggle()}, label: {
                        Text("Add Entry")
                        Image(systemName: "mappin.and.ellipse")
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .popover(isPresented: $showingPopover) {
                      CameraLocation(showingPopover: $showingPopover)
                    }
        }
    }
}*/

struct CameraLocation: View {
    @State private var showScreen:Bool=false
    @Binding var showingPopover:Bool
    @State private var showcameraAccess=false
    @State private var showCameraAccess = false
    @State private var inputText=""
    @State private var selectedImage:UIImage?
    @StateObject private var locationManager = LocationManager()
    @State private var currentLocation: CLLocationCoordinate2D?
    @State private var imageSourceType: UIImagePickerController.SourceType = .photoLibrary
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Location.latitude, ascending: true)],
            animation: .default
        ) private var locations: FetchedResults<Location>
        
    var body: some View {
        VStack(){
            VStack(alignment:.leading){
                HStack(alignment:.top){
                    Button {
                        showingPopover=false
                    } label: {
                        Text("Cancel")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding()
                        Spacer()
                    }
                    
                }
                .padding(.bottom,200)
                
                
            }
            VStack(){
                HStack{
                    Text("Remark")
                        .padding()
                    Spacer()
                    
                }
                TextField("Enter Remark",text:$inputText)
                    .padding(.leading,20)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius:10) .stroke(Color.gray,lineWidth:1))
                    .padding()
            }
            .padding()
            HStack{
                Button {
                    showcameraAccess.toggle()
                    if let location = locationManager.location {
                        currentLocation = location.coordinate
                    }
                } label: {
                    Image(systemName: "camera")
                    Text("Capture Image")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    imageSourceType = .photoLibrary
                    showCameraAccess.toggle()
                    if let location = locationManager.location {
                        currentLocation = location.coordinate
                    }
                } label: {
                    Image(systemName: "photo")
                    Text("Select from Photos")
                }
                .buttonStyle(.borderedProminent)
            }
            .fullScreenCover(isPresented:$showcameraAccess){
                accessCameraView(selectedImage: $selectedImage,sourceType: imageSourceType)
            }
            VStack{
                Text("Current Location:")
                if let location = currentLocation {
                    Text("Latitude: \(location.latitude)")
                    Text("Longitude: \(location.longitude)")
                } else {
                    Text("Location not available")
                }
                
                if let selectedImage{
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                }
            }
            Button(action: {saveLocationData()}, label: {
                Text("Save Data")
            })
            .buttonStyle(.borderedProminent)
            List {
                ForEach(locations) { location in
                    VStack(alignment: .leading) {
                        Text("Remark: \(location.text ?? "No Remark")")
                        Text("Latitude: \(location.latitude)")
                        Text("Longitude: \(location.longitude)")
                    }
                }
                .onDelete(perform: deleteLocation)
            }
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
                
    }
    
    private func saveLocationData() {
            guard let location = currentLocation else {
                print("Location not available")
                return
            }
            
            let newLocationData = Location(context: viewContext)
            newLocationData.text = inputText
            newLocationData.latitude = location.latitude
            newLocationData.longitude = location.longitude
            
            do {
                try viewContext.save()
                print("Data saved successfully!")
            } catch {
                print("Failed to save data: \(error.localizedDescription)")
            }
        }
    private func deleteLocation(at offsets: IndexSet) {
            for index in offsets {
                let location = locations[index]
                viewContext.delete(location)
            }
            
            do {
                try viewContext.save()
            } catch {
                print("Failed to delete location: \(error.localizedDescription)")
            }
        }
    
    
}
class UserViewModel: ObservableObject {
    /*@Published var properties:[Properties]=[]
     @Published var users: [User] = []
     func fetchUserData() {
     guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     if let error = error {
     print("Error fetching data: \(error)")
     return
     }
     
     guard let data = data else {
     print("No data received")
     return
     }
     
     do {
     let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
     DispatchQueue.main.async {
     self.users = apiResponse.data // Update users on the main thread
     }
     } catch {
     print("Error decoding data: \(error)")
     }
     }.resume()
     }*/
    
    
    @Published var users: [[String: Any]] = []
    func fetchUserData() {
        guard let url = URL(string: "https://pwddrishti.cgstate.gov.in/api/properties_list") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "api_key"), forHTTPHeaderField: "x-api-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = ["user_id": UserDefaults.standard.string(forKey: "user_id") ?? ""] // Replace with the actual user ID
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print("Error encoding parameters: \(error)")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                            print("HTTP Status Code: \(httpResponse.statusCode)")
                        }
                        
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response string: \(responseString)") // Print the raw response string
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let usersData = jsonResponse["data"] as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.users = usersData
                        print("listview output\(self.users)") // Print the fetched data
                    }
                } else {
                    print("Invalid response format")
                }
            }
            catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}




struct accessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        location = newLocation
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }
}


struct Table_Previews: PreviewProvider {
    @State private var inputtext: String=""
    
    static var previews: some View {
        WorkList(searchQuery: "")
    }
}


struct CameraLocation_Previews: PreviewProvider {
    static var previews: some View {
        CameraLocation(showingPopover: .constant(false))
            
    }
}
