//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI
struct createpost: View {
    
    // State variable to hold the selected image
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false

func uploadImage() {
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("No image selected")
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

    let data: [[String: Any]] = [
        // Insert your Photo objects here
        [
            "id": 7,
            "name": "image.jpg",
            "width": 4288,
            "height": 2848
        ]
    ]
    
    
        // Create a dictionary representing the JSON structure
        let jsonData: [String: Any] = [
            "data": [
                "description": description,
                "photos": data
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
    @State private var request = false
    @State private var donate = false
    @State private var shownewpost = false
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
                                    uploadImage()
                                    //her we activate the navigationlink
                                    self.shownewpost = true
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
                            HStack(spacing: 9){
                                Toggle("Request", isOn: $request)
                                    .toggleStyle(.button)
                                    .tint(Color.primarycolor)
                                    .font(.headline)
                                    .border(Color.primarycolor)
                                Toggle("Donate", isOn: $donate)
                                    .toggleStyle(.button)
                                    .tint(Color.primarycolor)
                                    .font(.headline)
                                    .border(Color.primarycolor)
                            }
                        }
                        .frame(width: 180, height: 60)
                        .padding(.leading, 25)
                    }
                    .padding(.top)
                    TextField("What's on your mind ?", text: $description, axis: .vertical)
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
                                    HStack(spacing: 30){
                                        Group{
                                            Button {
                                                showview3.toggle()
                                            } label: {
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
                                            }
                                            
                                            NavigationLink (destination: addmedicine().navigationBarBackButtonHidden(), label:{
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .foregroundStyle(Color.primarycolor)
                                                        .frame(width: 100, height: 40, alignment: .center)
                                                    HStack{
                                                        Text("Add")
                                                            .fontWeight(.medium)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                            })
                                        }
                                        .offset(y: 20)
                                    }
                                }
                            }
                        }
                        .background()
                        .offset(y: -450)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                        .edgesIgnoringSafeArea(.bottom)
                    }
                }
                .offset(y: 370)
                if let image = selectedImage {
                               Image(uiImage: image)
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 200, height: 200)
                           }
                Button(action: {
                    showingImagePicker = true
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.primarycolor, lineWidth: 1)
                            .foregroundStyle(Color.white)
                            .frame(width: 200, height: 40, alignment: .center)
                        HStack{
                            Image(systemName: "camera")
                                .foregroundColor(.primarycolor)
                            Text("Add photos")
                                .foregroundColor(.primarycolor)
                        }
                    }
                })
                .offset(y: 370)
                .sheet(isPresented: $showingImagePicker){ImagePicker(selectedImage: $selectedImage)}
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
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
                parent.selectedImage = image
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
                        parent.selectedImage = image
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
