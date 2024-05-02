import SwiftUI
import UIKit

struct ImagePicker1: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker1

        init(_ parent: ImagePicker1) {
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


struct ShoppingItem {
    var name: String
    var quantity: String
    var price: String
    var photo: UIImage?
}

struct AddItemView: View {
    @Binding var shoppingItems: [ShoppingItem]
    @State private var itemName = ""
    @State private var itemQuantity = ""
    @State private var itemPrice = ""
    @State private var itemImage: UIImage? = nil // New state for the image
    @State private var showImagePicker = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            TextField("Item Name", text: $itemName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Quantity", text: $itemQuantity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Price", text: $itemPrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let image = itemImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
            }
            
            Button(action: {
                self.showImagePicker = true
            }) {
                Text("Pick Image")
            }
            .padding()
            .sheet(isPresented: $showImagePicker) {
                ImagePicker1(selectedImage: self.$itemImage, sourceType: .photoLibrary)
            }
            
            Button(action: {
                            if itemName.isEmpty || itemQuantity.isEmpty || itemPrice.isEmpty {
                                showAlert = true
                            } else {
                                shoppingItems.append(ShoppingItem(name: itemName, quantity: itemQuantity, price: itemPrice, photo: itemImage))
                                itemName = ""
                                itemQuantity = ""
                                itemPrice = ""
                                itemImage = nil
                            }
                        }) {
                            Text("Add Item")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("Please fill in all fields"), dismissButton: .default(Text("OK")))
                        }
                    }
                    .navigationTitle("Add Item")
                }
            }


struct ShoppingListView: View {
    @Binding var shoppingItems: [ShoppingItem]

    var body: some View {
        List {
            ForEach(shoppingItems, id: \.name) { item in
                HStack {
                    if let photo = item.photo {
                                            Image(uiImage: photo)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 80)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                                .font(.headline)
                                            Text("Quantity: \(item.quantity)")
                                            Text("Price: \(item.price)")
                                        }
                }
            }
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var shoppingItems = [ShoppingItem]()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AddItemView(shoppingItems: $shoppingItems)) {
                    Text("Add Item")
                }
                .padding()
                
                Divider()
                
                ShoppingListView(shoppingItems: $shoppingItems)
                
                Spacer()
            }
            .navigationTitle("Shopping List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


