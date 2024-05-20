//
//  home.swift
//  medidonate
//
//  Created by fares kassis on 21/3/2024.
//

import SwiftUI


class MedicineViewModel: ObservableObject {
    @Published var medicines = [Medicine1]()

    init() {
        fetchMedicines()
    }

    func fetchMedicines(start: Int = 0) {
        let limit = 6072
        guard let url = URL(string: "http://localhost:1337/api/medicines?pagination[start]=\(start)&pagination[limit]=\(limit)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let token = AuthService.token ?? RegisterService.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
                print("Authorization token is not available.")
                // Optionally handle the scenario when there is no token (e.g., show login screen)
                return
            }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }


            let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO 8601 format

                do {
                    let decodedResponse = try decoder.decode(MedicineResponse.self, from: data)

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

                    DispatchQueue.main.async {
                        self.medicines = decodedResponse.data.map { medicineData in
                            Medicine1(
                                id: medicineData.id,
                                name: medicineData.attributes.name,
                                category: medicineData.attributes.category,
                                type: medicineData.attributes.type
                            )
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
        }.resume()
    }
}

struct Medicine1: Identifiable {
    let id: Int
    let name: String
    let category: String
    let type: String
}


struct MedicineResponse: Decodable {
    struct MedicineData: Decodable {
        let id: Int
        let attributes: MedicineAttributes
    }

    struct MedicineAttributes: Decodable {
        let name: String
        let category: String
        let type: String
    }

    let data: [MedicineData]
}





struct Medicine: Encodable {
    var attributes: MedicineAttributes
    var quantity: Int
    var fabDate: Date
    var expDate: Date
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case attributes, quantity, fabDate, expDate, image
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(attributes, forKey: .attributes)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(fabDate, forKey: .fabDate)
        try container.encode(expDate, forKey: .expDate)
        
//        if let image = image {
//            let imageData = image.pngData() // or use jpegData(compressionQuality:) if you prefer JPEG
//            let imageBase64String = imageData?.base64EncodedString()
//            try container.encode(imageBase64String, forKey: .image)
//        } else {
//            try container.encodeNil(forKey: .image)
//        }
    }
}

struct MedicineAttributes: Encodable {
    let id: Int
    let name: String
    let category: String
    let type: String
}



let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct createpost1: View {

    // State variable to hold the selected image
    @State private var showingImagePicker = false
    @State private var medicines: [Medicine] = []
    @State private var medicinesattributes: [MedicineAttributes] = []
    @State private var selectedMedicineImage: UIImage?
    @State private var showingSearchResults = false
    

    func encodedata(allData: [Medicine]) -> [[String: Any]] {
        let encoder = JSONEncoder()
        var jsonString = ""
        do {
            let jsonData = try encoder.encode(allData)
            jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            print(jsonString)
        } catch {
            print("Error encoding array: \(error)")
        }
        
        let newjsonData = jsonString.data(using: .utf8)
        var newalldata: [[String: Any]] = []
        do {
            if let jsonData = newjsonData {
                if let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                    newalldata = parsedData
                    return newalldata
                } else {
                    print("Data was not in the expected array of dictionaries format")
                }
            } else {
                print("Failed to create Data from String")
            }
        } catch {
            print("Failed to parse JSON: \(error)")
        }
        
        return []
    }


    func uploadImage(selectedImage: UIImage?) {
        guard let image = selectedImage else {
            print("No image selected")
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
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
    if let token = AuthService.token ?? RegisterService.token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    } else {
            print("Authorization token is not available.")
            // Optionally handle the scenario when there is no token (e.g., show login screen)
            return
        }

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
                        //sendPostRequest(with: responseBody, with: description)
                        let newjsonData = responseBody.data(using: .utf8)
                        var imagedata: [[String: Any]] = []
                        // Attempt to convert Data to an Array of Dictionaries
                        do {
                            if let jsonData = newjsonData {
                                if let parsedData = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
                                    if let firstObject = parsedData.first, let id = firstObject["id"] as? Int {
                                                print("Extracted id: \(id)")
                                                uploadedImages.append(id)
                                            } else {
                                                print("Could not find id in the first JSON object")
                                            }
                                } else {
                                    print("Data was not in the expected array of dictionaries format")
                                }
                            } else {
                                print("Failed to create Data from String")
                            }
                        } catch {
                            print("Failed to parse JSON: \(error)")
                        }
                        

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
    func sendPostRequest(with description: String) {
        Task {
            // Create a dictionary representing the JSON structure
            let jsonData: [String: Any] = [
                "data": [
                    "description": description,
                    "photos": uploadedImages,
                    "post_medicines": encodedata(allData: medicines)
                ]
            ]
            print("JSON data structured for sending: \(jsonData)")

            // Create the URL to which you want to send the request
            guard let url = URL(string: "http://localhost:1337/api/post/uploadpost") else {
                print("Invalid URL")
                return
            }

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if let token = AuthService.token ?? RegisterService.token {
                request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            } else {
                print("Authorization token is not available.")
                // Optionally handle the scenario when there is no token (e.g., show login screen)
                return
            }

            do {
                // Add JSON data to the request body
                let json = try JSONSerialization.data(withJSONObject: jsonData)
                request.httpBody = json
            } catch {
                print("Failed to serialize JSON: \(error)")
                return
            }

            do {
                // Perform the request
                let (data, response) = try await URLSession.shared.data(for: request)
                if let response = response as? HTTPURLResponse {
                    print("Status code: \(response.statusCode)")
                    if let responseBody = String(data: data, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }
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
    @State var id : Int = 0
    @State var choicemade = ""
    @State var medicinee = ""
    @State var showview3: Bool = false
    @State var showview5: Bool = false
    @State private var request = false
    @State private var donate = false
    @State private var shownewpost = false
    @State private var activeButton: Int?
    @State private var showAlertEmptyDescription = false
    @State private var showAlertDonateRequest = false
    @State private var showAlertForZeroQuantity = false


    @ObservedObject var viewModel1 = MedicineViewModel()
    @State private var searchText = ""
    @State private var selectedMedicines: [String] = []
    @State var uploadedImages: [Int] = []


    private func validateAndPost() {
        if description.isEmpty {
            showAlertEmptyDescription = true
            return
        }

        guard let activeButton = activeButton else {
            showAlertDonateRequest = true
            return
        }
        sendPostRequest(with: description)


       //uploadImage() // Call uploadImage() only if conditions are met

        // Set shownewpost to true to activate the navigation link
            shownewpost = true
    }

    func resetFields() {
        // Reset all related fields to their default values
        quantity = 0
        fab_date = Date()
        exp_date = Date()
        selectedMedicineImage = nil
        searchText = ""
    }


    private func dismissKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    @ObservedObject var viewModel = PostViewModel()

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
                            NavigationLink(destination: home().navigationBarBackButtonHidden(), isActive: $shownewpost) {
                                Button {
//                                    viewModel.fetchPosts()
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
                            if let userInfo = AuthService.userInfo ?? RegisterService.userInfo {
                                Text("\(userInfo.username)")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
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
                                Text("Medicine Id: \(medicines[index].attributes.id)")
                                Text("Medicine Name: \(medicines[index].attributes.name)")
                                Text("Category: \(medicines[index].attributes.category)")
                                Text("Type: \(medicines[index].attributes.type)")
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
                .frame(width: 390, height: 380)
                .offset(y: -75)
            }
        }
        if showview3{
            Group{
                ZStack{
                    VStack{
                        // Custom search bar that shows the list on tap
                                    TextField("Medicine name", text: $searchText)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .onChange(of: searchText) { newValue in
                                                            // This checks if the text field is not empty and then shows the search results
                                                            if !newValue.isEmpty {
                                                                showingSearchResults = true
                                                            }
                                                        }
                                        .onTapGesture {
                                            // This will toggle the display of the search results
                                            if !searchText.isEmpty {
                                                                    showingSearchResults = true

                                                                }
                                        }
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                        .padding(.horizontal)

                        if showingSearchResults && !searchText.isEmpty {
                            List {
                                ForEach(viewModel1.medicines.filter {
                                    self.searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(self.searchText)
                                }) { medicine in
                                    VStack(alignment: .leading) {
                                        Text(medicine.name)
                                            .font(.headline)
                                        Text("Category: \(medicine.category)")
                                            .font(.headline)
                                        Text("Type: \(medicine.type)")
                                            .font(.headline)
                                    }
                                    .foregroundColor(.black)
                                    .padding()
                                    .onTapGesture {
                                        self.searchText = medicine.name // This updates the TextField text
                                        self.showingSearchResults = false // Optionally close the search results list
                                        self.id = medicine.id
                                        self.medicinee = medicine.name
                                        self.category = medicine.category
                                        self.choicemade = medicine.type
                                        dismissKeyboard()
                                    }
                                }
                            }
                            .frame(width: 380, height: 350, alignment: .center)
                            // Include any additional UI components as necessary
                            .background(Color.white) // Adjust background styling as needed
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.5))
                            .edgesIgnoringSafeArea(.bottom)
                            .alert("Quantity Required", isPresented: $showAlertForZeroQuantity, actions: {
                                Button("OK", role: .cancel) {}
                            }, message: {
                                Text("You must enter a quantity more than zero.")
                            })
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
                                    resetFields()
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
                                    ImagePicker(selectedImage: $selectedMedicineImage)
                                        .offset(y: 24)
                                }
                                Button(action: {
                                    if quantity == 0 {
                                        showAlertForZeroQuantity = true
                                    } else {
                                        let newMedicine = Medicine(attributes: MedicineAttributes(id : id , name: medicinee, category: category, type: choicemade), quantity: quantity, fabDate: fab_date, expDate: exp_date, image: selectedMedicineImage)
                                        medicines.append(newMedicine)
                                        uploadImage(selectedImage: selectedMedicineImage)
                                        showview3.toggle()
                                        resetFields()
                                    }
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
                                .alert(isPresented: $showAlertForZeroQuantity) {
                                    Alert(
                                        title: Text("Alert"),
                                        message: Text("You must enter a quantity greater than zero."),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
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
            .offset(y: -8)
        }

    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

        // Coordinator to handle image picker delegate methods
        extension createpost1 {
            class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
                let parent: createpost1

                init(_ parent: createpost1) {
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

//#Preview {
//    createpost1()
//}
