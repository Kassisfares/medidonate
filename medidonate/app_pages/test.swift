import SwiftUI

struct AddItemView: View {
    @Binding var shoppingItems: [ShoppingItem]
    @State private var itemName = ""
    @State private var itemQuantity = ""
    @State private var itemPrice = ""

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

            Button(action: {
                let newItem = ShoppingItem(name: itemName, quantity: itemQuantity, price: itemPrice)
                shoppingItems.append(newItem)
                itemName = ""
                itemQuantity = ""
                itemPrice = ""
            }) {
                Text("Add Item")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
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
                    Text(item.name)
                    Spacer()
                    Text("Quantity: \(item.quantity)")
                    Text("Price: \(item.price)")
                }
            }
        }
        .padding()
    }
}
