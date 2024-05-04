//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct Medicine {
    var name: String
    var category: String
    var type: String
    var quantity: Int
    var fabDate: Date
    var expDate: Date
    var image: UIImage?
}

struct createpost: View {
    
    // State variable to hold the selected image
    @State private var showingImagePicker = false
    @State private var medicines: [Medicine] = []
    @State private var selectedMedicineImage: UIImage?

func uploadImage() {
        guard let image = selectedMedicineImage else {
            print("No image selected")
            sendPostRequest(with: "")
            return
        }
    
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }
        
        // Create URL
    guard let url = URL(string: "http://localhost:1337/api/upload") else {
        print("Invalid URL")
        return
    }
        let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")

        
        // Create boundary
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Add image data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        // Add closing boundary
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set request body
        request.httpBody = body
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                if let data = data {
                    if let responseBody = String(data: data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                        sendPostRequest(with: responseBody)

                    }
                }

            }
        }.resume()
    }
// Coordinator to handle image picker delegate methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // Function to send HTTP POST request with image
func sendPostRequest(with data: String) {
    
    let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
print("response getted from response body" ,    data)
    let imagedata: [[String: Any]]
    let newjsonData = data.data(using: .utf8)
        // Convert Data to Array of Dictionaries
    imagedata = try! JSONSerialization.jsonObject(with: newjsonData!, options: []) as! [[String : Any]]
        
        
    

    // you should format data to array
//    let imagedata: [[String: Any]] = [
//        // Insert your Photo objects here
//        [
//            "id": 7,
//            "name": "image.jpg",
//            "width": 4288,
//            "height": 2848
//        ]
//    ]

// on add each medecine we should get all informations of selected medecine
    // than append the id of selected medecine to the array that we will be sent with the post
    //let medecinesdata : [Int: Any] = [1,2,3]
    
    
        // Create a dictionary representing the JSON structure
        let jsonData: [String: Any] = [
            "data": [
                "description": description,
                "photos": imagedata,
            ]
        ]
        
        // Create the URL to which you want to send the request
        guard let url = URL(string: "http://localhost:1337/api/post/uploadpost") else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        
        var body = Data()
        

        
        // Add JSON data to the request body
        let json = try! JSONSerialization.data(withJSONObject: jsonData)
        body.append(json)
        body.append(Data("\r\n".utf8))
//
        // Add closing boundary to the request body
        
        request.httpBody = body
        
        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            // (You can update the UI or perform any other actions here)
            if let error = error {
                print("Error: \(error)")
            }else if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
                if let data = data {
                    if let responseBody = String(data: data, encoding: .utf8) {
                        print("Response body: \(responseBody)")

                    }
                }

            }
        }
        
        // Start the task
        task.resume()
    }
    
// Function to select an image
    func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self.makeCoordinator() // Change to self
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
    }
    
    @State var description: String = ""
    @State var category: String = ""
    @State private var fab_date = Date()
    @State private var exp_date = Date()
    @State private var quantity: Int = 0
    @State var choicemade = "Tap to select medicine's type"
    @State var medicinee = "tap to select medicine's name"
    @State var showview3: Bool = false
    @State var showview5: Bool = false
    @State private var request = false
    @State private var donate = false
    @State private var shownewpost = false
    @State private var activeButton: Int?
    @State private var showAlertEmptyDescription = false
    @State private var showAlertDonateRequest = false
    
    private func validateAndPost() {
        if description.isEmpty {
            showAlertEmptyDescription = true
            return
        }
        
        guard let activeButton = activeButton else {
            showAlertDonateRequest = true
            return
        }
        
        uploadImage() // Call uploadImage() only if conditions are met
        
        // Set shownewpost to true to activate the navigation link
            shownewpost = true
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading){
                    HStack{
                        Group{
                            NavigationLink (destination: home().navigationBarBackButtonHidden(), label: {
                                Image(systemName: "plus")
                                    .padding(.leading, 20)
                                    .font(.title)
                                    .rotationEffect(.degrees(45))
                                    .offset(x: 5, y: -5)
                                    .foregroundColor(.black)
                            })
                            Text("Create post")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .foregroundColor(.black)
                                .offset(x: -5)
                            NavigationLink(destination: sharepostinhome().navigationBarBackButtonHidden(), isActive: $shownewpost) {
                                Button {
                                    //this we write the function
                                    print("Button tapped")
                                    // Validate input before posting
                                    validateAndPost()
                                } label: {
                                    ZStack{
                                        Rectangle()
                                            .cornerRadius(12)
                                            .foregroundStyle(Color.primarycolor)
                                            .frame(width: 65, height: 40, alignment: .center)
                                        Text("Post")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .multilineTextAlignment(.center)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .alert("Alert", isPresented: $showAlertEmptyDescription) {
                                            Button("OK", role: .cancel) {}
                                        } message: {
                                            Text("Description cannot be empty.")
                                        }
                                        .alert("Alert", isPresented: $showAlertDonateRequest) {
                                            Button("OK", role: .cancel) {}
                                        } message: {
                                            Text("Please select Donate or Request.")
                                        }
                            }
                            .padding(.trailing, 50)
                        }
                        .frame(width: 170, height: 50)
                    }
                    HStack(spacing: -8){
                        Image(systemName: "person.circle.fill")
                            .resizable(resizingMode: .tile)
                            .frame(width: 50, height: 50)
                            .padding(.leading, 80)
                            .foregroundColor(.green)
                        VStack(alignment: .leading){
                            Text("Freas Kassis")
                                .font(.title3)
                                .fontWeight(.semibold)
                                //.padding(.leading, 9)
                            HStack {
                                Button(action: { self.activeButton = 1 }) {
                                Text("Donate")
                                    .padding(.all, 6)
                                    .background(self.activeButton == 1 ? Color.primarycolor : Color.clear)
                                    .foregroundColor(self.activeButton == 1 ? .white : .primarycolor)
                                    .cornerRadius(8)
                                }
                                .disabled(activeButton == 1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primarycolor, lineWidth: 2)
                                )
                                Button(action: { self.activeButton = 2 }) {
                                Text("Request")
                                    .padding(.all, 6)
                                    .background(self.activeButton == 2 ? Color.primarycolor : Color.clear)
                                    .foregroundColor(self.activeButton == 2 ? .white : .primarycolor)
                                    .cornerRadius(8)
                                }
                                .disabled(activeButton == 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.primarycolor, lineWidth: 2)
                                )
                            }
                        }
                        .frame(width: 180, height: 60)
                        .padding(.leading, 13)
                    }
                    .padding(.top)
                    TextField("Write your description here", text: $description, axis: .vertical)
                        .font(.title2)
                        .frame(width: 350, height: 100)
                        .background(Color.white)
                        .padding(.leading, 85)
                        .padding(.top)
                }
                Group{
                    Button(action: {
                        showview3.toggle()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.primarycolor, lineWidth: 1)
                                .foregroundStyle(Color.white)
                                .frame(width: 200, height: 40, alignment: .center)
                            HStack{
                                Image(systemName: "pills")
                                    .foregroundColor(.primarycolor)
                                Text("Add medicines")
                                    .foregroundColor(.primarycolor)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.primarycolor)
                            }
                        }
                    })
                    .offset(y: -30)
                    Button( action: {
                        showview5.toggle()
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.primarycolor, lineWidth: 1)
                                .foregroundStyle(Color.white)
                                .frame(width: 180, height: 40, alignment: .center)
                            HStack{
                                Image(systemName: "map.circle")
                                    .foregroundColor(.primarycolor)
                                Text("Add address")
                                    .foregroundColor(.primarycolor)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.primarycolor)
                            }
                        }
                    })
                    .offset(y: -30)
                }
                .offset(y: 420)
                ScrollView{
                    ForEach(medicines.indices, id: \.self) { index in
                        HStack {
                            if let image = medicines[index].image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .padding(.bottom, 8)
                                    }
                            VStack(alignment: .leading) {
                                Text("Medicine Name: \(medicines[index].name)")
                                Text("Category: \(medicines[index].category)")
                                Text("Type: \(medicines[index].type)")
                                Text("Quantity: \(medicines[index].quantity)")
                                Text("Fab Date: \(medicines[index].fabDate, formatter: dateFormatter)")
                                Text("Exp Date: \(medicines[index].expDate, formatter: dateFormatter)")
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.primarycolor, lineWidth: 2)
                                .padding(.all, 10)
                        )
                        .cornerRadius(15)
                    }
                }
                .border(Color.gray1)
                .frame(width: 390, height: 357)
                
                .offset(y: -95)
            }
        }
        if showview3{
            Group{
                ZStack{
                    VStack{
                        Text("Medicine Name")
                            .offset(x: -120)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            Menu("\(medicinee)"){
                                Button("panadole"){
                                    medicinee = "panadole"
                                }
                                Button("maxilase"){
                                    medicinee = "maxilase"
                                }
                                Button("vaccines"){
                                    medicinee = "vaccines"
                                }
                                Button("moov"){
                                    medicinee = "moov"
                                }
                            }
                            .foregroundColor(.gray)
                            .padding(.leading)
                            .frame(width: 250, alignment: .leading)
                        }
                        Text("Medicine Category")
                            .offset(x: -105)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            TextField("Medicine category(it will be auto fill)", text: $category)
                                .font(.headline)
                                .frame(width: 300, height: 50)
                                .padding(.leading)
                                .fontWeight(.regular)
                        }
                        Text("Medicine Type")
                            .offset(x: -120)
                            .frame(height: 25)
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 365, height: 50)
                                .cornerRadius(10)
                            Menu("\(choicemade)"){
                                Button("pills"){
                                    choicemade = "pills"
                                }
                                Button("sirop"){
                                    choicemade = "sirop"
                                }
                                Button("injections"){
                                    choicemade = "injections"
                                }
                                Button("spray"){
                                    choicemade = "spray"
                                }
                            }
                            .foregroundColor(.gray)
                            .padding(.leading)
                            .frame(width: 250, alignment: .leading)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .cornerRadius(10)
                                .padding(.top, 3)
                            Stepper(value: $quantity, in: 0...100,step: 1){
                                Text("Quantity: \(quantity)")
                            }
                            .frame(width: 220)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .cornerRadius(10)
                                .padding(.top, 3)
                                .padding(.bottom, 3)
                            DatePicker("Fab_Date", selection: $fab_date, in: ...Date(), displayedComponents:.date)
                                .frame(width: 220)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 2)
                                .foregroundColor(.white)
                                .frame(width: 300, height: 50)
                                .cornerRadius(10)
                            DatePicker("Exp_Date", selection: $exp_date, in: Date()..., displayedComponents:.date)
                                .frame(width: 220)
                        }
                        HStack(alignment: .center ,spacing: 30){
                            Group{
                                Button(action: {
                                    showview3.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.primarycolor, lineWidth: 1)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 100, height: 40, alignment: .center)
                                        HStack{
                                            Text("Cancel")
                                                .fontWeight(.medium)
                                                .foregroundColor(.primarycolor)
                                        }
                                    }
                                })
                                Button(action: {
                                    showingImagePicker = true
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .foregroundStyle(Color.primarycolor)
                                            .frame(width: 100, height: 40, alignment: .center)
                                        Image(systemName: "photo.badge.plus")
                                            .foregroundColor(.white)
                                    }
                                })
                                .padding(.leading, -30)
                                .padding(.trailing, -30)
                                .sheet(isPresented: $showingImagePicker) {
                                    ImagePicker(selectedMedicineImage: $selectedMedicineImage)
                                        .offset(y: 24)
                                }
                                Button(action: {
                                    let newMedicine = Medicine(name: medicinee, category: category, type: choicemade, quantity: quantity, fabDate: fab_date, expDate: exp_date, image: selectedMedicineImage)
                                    medicines.append(newMedicine)
                                    showview3.toggle()
                                }, label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundStyle(Color.primarycolor)
                                            .frame(width: 100, height: 40, alignment: .center)
                                        Text("Add")
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                    }
                                })
                            }
                            .offset(y: 20)
                        }
                    }
                }
            }
            .background()
            .transition(.move(edge: .bottom))
            .animation(.easeInOut(duration: 0.5))
            .edgesIgnoringSafeArea(.bottom)
        }
        if showview5 {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(width: 400, height: 430)
                    .foregroundColor(.primarycolor)
                    .cornerRadius(50)
                VStack{
                    HStack{
                        Button(action: {
                            showview5.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .padding(.leading, 20)
                                .font(.title)
                                .rotationEffect(.degrees(45))
                                .foregroundColor(.white)
                        })
                        .offset(x: -70, y: -7)
                        Text("Choose location")
                            .font(.title)
                            .foregroundColor(.white)
                            .offset(x: -25)
                    }
                    Text("Set location on map")
                        .font(.title3)
                        .foregroundColor(.white)
                        .offset(x: -90)
                        .padding(.bottom, 10)
                    NavigationLink (destination: addlocation2().navigationBarBackButtonHidden(), label:{
                        Image("map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 300, height: 200)
                    })
                    HStack{
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width:100, height: 2)
                            .offset(y: -2)
                        Text("Or")
                            .foregroundColor(.white)
                            .padding(.leading)
                            .padding(.trailing)
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width:100, height: 2)
                            .offset(y: -2)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    NavigationLink (destination: addlocation2().navigationBarBackButtonHidden(), label:{
                        ZStack{
                            Rectangle()
                                .cornerRadius(12)
                                .foregroundStyle(Color.white)
                                .frame(width: 250, height: 40, alignment: .center)
                            HStack{
                                Image(systemName: "plus")
                                    .foregroundColor(.primarycolor)
                                    .fontWeight(.medium)
                                Text("Add new location")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.primarycolor)
                            }
                        }
                    })
                }
                .offset(y: -20)
            }
            .offset(y: 34)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedMedicineImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedMedicineImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

        // Coordinator to handle image picker delegate methods
        extension createpost {
            class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
                let parent: createpost
                
                init(_ parent: createpost) {
                    self.parent = parent
                }
                
                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                    print("Image picker delegate method called")
                    
                    if let image = info[.originalImage] as? UIImage {
                        print("Image selected: \(image)")
                        // Assign the selected image to the state variable
                        parent.selectedMedicineImage = image
                    } else {
                        print("Failed to retrieve image")
                    }
                    
                    // Dismiss the image picker
                    picker.dismiss(animated: true)
                }
            }
        }

#Preview {
    createpost()
}
