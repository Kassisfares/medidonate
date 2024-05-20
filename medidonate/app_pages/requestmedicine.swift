import SwiftUI

struct requestmedicine: View {
    @ObservedObject var viewModel = PostViewModel()
    @State private var showConfirmAlert = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                if let selectedPostID = viewModel.selectedPostID {
                    ScrollView {
                        ZStack {
                            Circle()
                                .fill(Color.primarycolor)
                                .frame(width: 1500, height: 575)
                                .offset(y: -500)
                            Text("Request medicines")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .offset(x: -60, y: -310)
                        }
                        ForEach(viewModel.posts.filter { $0.id == selectedPostID }, id: \.id) { post in
                            if let postMedicines = post.attributes.post_medicines?.data {
                                ForEach(postMedicines, id: \.id) { postMedicine in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray4)
                                            .cornerRadius(20)
                                            .foregroundColor(.white)
                                            .frame(width: 365, height: 150)
                                        HStack(spacing: 10) {
                                            Image(systemName: "pills")
                                                .resizable(resizingMode: .stretch)
                                                .frame(width: 90, height: 120)
                                                .foregroundColor(Color.primarycolor)
                                            VStack(alignment: .leading) {
                                                Text("\(postMedicine.attributes.medicines.data.attributes.name)")
                                                    .font(.headline)
                                                    .fontWeight(.regular)
                                                HStack{
                                                    if let fabDate = postMedicine.attributes.fabricationDate {
                                                        Text("Fabrication Date: \(fabDate, formatter: itemFormatter)")
                                                            .font(.callout)
                                                            .fontWeight(.light)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                    HStack{
                                                    if let expDate = postMedicine.attributes.expirationDate {
                                                        Text("Expiration Date: \(expDate, formatter: itemFormatter)")
                                                            .font(.callout)
                                                            .fontWeight(.light)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                Text("Quantity: \(postMedicine.attributes.quantity)")
                                                    .font(.callout)
                                                    .fontWeight(.light)
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(width: 200, height: 100, alignment: .topLeading)
                                        }
                                    }
                                    .padding(.bottom, 10) // Add padding between medicines
                                }
                            }
                            Button {
                                viewModel.sendPostInformation(post)
                                        } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 15)
                                                    .foregroundStyle(Color.primarycolor)
                                                    .frame(width: 150, height: 40, alignment: .center)
                                                HStack {
                                                    Text("Request Now")
                                                        .fontWeight(.medium)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                        }
                            .offset(y: 50)
                        }
                        .offset(y: -480)
                    }
                } else {
                    Text("Select a post to view its medicines.")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: NavigationLink(destination: home().navigationBarBackButtonHidden(), label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.white)
            }))
            .onAppear {
                if let selectedPostID = viewModel.selectedPostID {
                    viewModel.fetchMedicines(for: selectedPostID)
                }
            }
            
        }
        var itemFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            return formatter
        }
    }
}

#Preview {
    requestmedicine(viewModel: PostViewModel())
}
