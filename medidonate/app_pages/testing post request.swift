////
////  testing post request.swift
////  medidonate
////
////  Created by fares kassis on 29/4/2024.
////
//
//import SwiftUI
//import UIKit
//    
//    
//    struct testing_post_request: View {
//        
//            // State variable to hold the selected image
//            @State private var selectedImage: UIImage?
//            @State private var showingImagePicker = false
//
//        func uploadImage() {
//                guard let image = selectedImage,
//                      let imageData = image.jpegData(compressionQuality: 0.8) else {
//                    print("No image selected")
//                    return
//                }
//                
//                // Create URL
//                guard let url = URL(string: "http://localhost:1337/api/upload") else {
//                    print("Invalid URL")
//                    return
//                }
//                let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
//                // Create request
//                var request = URLRequest(url: url)
//                request.httpMethod = "POST"
//                request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
//
//                
//                // Create boundary
//                let boundary = UUID().uuidString
//                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//                
//                var body = Data()
//                
//                // Add image data
//                body.append("--\(boundary)\r\n".data(using: .utf8)!)
//                body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
//                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//                body.append(imageData)
//                body.append("\r\n".data(using: .utf8)!)
//                
//                // Add closing boundary
//                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
//                
//                // Set request body
//                request.httpBody = body
//                
//                // Perform the request
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let error = error {
//                        print("Error: \(error)")
//                    } else if let response = response as? HTTPURLResponse {
//                        print("Status code: \(response.statusCode)")
//                        if let data = data {
//                            if let responseBody = String(data: data, encoding: .utf8) {
//                                print("Response body: \(responseBody)")
//                                sendPostRequest(with: responseBody)
//
//                            }
//                        }
//
//                    }
//                }.resume()
//            }
//        // Coordinator to handle image picker delegate methods
//            func makeCoordinator() -> Coordinator {
//                return Coordinator(self)
//            }
//            
//            // Function to send HTTP POST request with image
//        func sendPostRequest(with data: String) {
//            
//            let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
//
//            let data: [[String: Any]] = [
//                // Insert your Photo objects here
//                [
//                    "id": 7,
//                    "name": "image.jpg",
//                    "width": 4288,
//                    "height": 2848
//                ]
//            ]
//            
//            
//                // Create a dictionary representing the JSON structure
//                let jsonData: [String: Any] = [
//                    "data": [
//                        "description": "new directly published description + photo",
//                        "photos": data
//                    ]
//                ]
//                
//                // Create the URL to which you want to send the request
//                guard let url = URL(string: "http://localhost:1337/api/post/uploadpost") else {
//                    print("Invalid URL")
//                    return
//                }
//                
//                // Create the request
//                var request = URLRequest(url: url)
//                request.httpMethod = "POST"
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//                request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
//                
//                
//                var body = Data()
//                
//
//                
//                // Add JSON data to the request body
//                let json = try! JSONSerialization.data(withJSONObject: jsonData)
//                body.append(json)
//                body.append(Data("\r\n".utf8))
////                
//                // Add closing boundary to the request body
//                
//                request.httpBody = body
//                
//                // Perform the request
//                let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                    // Handle response
//                    // (You can update the UI or perform any other actions here)
//                    if let error = error {
//                        print("Error: \(error)")
//                    }else if let response = response as? HTTPURLResponse {
//                        print("Status code: \(response.statusCode)")
//                        if let data = data {
//                            if let responseBody = String(data: data, encoding: .utf8) {
//                                print("Response body: \(responseBody)")
//
//                            }
//                        }
//
//                    }
//                }
//                
//                // Start the task
//                task.resume()
//            }
//            
//        // Function to select an image
//            func selectImage() {
//                let picker = UIImagePickerController()
//                picker.sourceType = .photoLibrary
//                picker.delegate = self.makeCoordinator() // Change to self
//                UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
//            }
//
//
//            var body: some View {
//                VStack {
//                    if let image = selectedImage {
//                                   Image(uiImage: image)
//                                       .resizable()
//                                       .aspectRatio(contentMode: .fit)
//                                       .frame(width: 200, height: 200)
//                               } else {
//                                   Text("No image selected")
//                               }
//                    // Image picker button
//                    Button("Select Photo") {
//                        showingImagePicker = true
//                    }
//                    .padding()
//                    .sheet(isPresented: $showingImagePicker, onDismiss: uploadImage) {
//                                    ImagePicker(selectedImage: $selectedImage)
//                                }
//                    
//                    // Button to send the POST request
////                    Button("Send POST Request") {
////                        sendPostRequest()
////                    }
//                    .padding()
//                }
//                .padding()
//                
//            }
//        }
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: UIImage?
//    @Environment(\.presentationMode) var presentationMode
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        let parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}
//
//        // Coordinator to handle image picker delegate methods
//        extension testing_post_request {
//            class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//                let parent: testing_post_request
//                
//                init(_ parent: testing_post_request) {
//                    self.parent = parent
//                }
//                
//                func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//                    print("Image picker delegate method called")
//                    
//                    if let image = info[.originalImage] as? UIImage {
//                        print("Image selected: \(image)")
//                        // Assign the selected image to the state variable
//                        parent.selectedImage = image
//                    } else {
//                        print("Failed to retrieve image")
//                    }
//                    
//                    // Dismiss the image picker
//                    picker.dismiss(animated: true)
//                }
//            }
//        }
//    
//    #Preview {
//        testing_post_request()
//    }
//
