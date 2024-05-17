import SwiftUI

struct requestmedicine: View {
    @State var showview: Bool = false
    @ObservedObject var viewModel = PostViewModel()
    
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
                        }
                        .offset(y: -480)
                        HStack(spacing: 20) {
                            Group {
                                NavigationLink(destination: editrequestmedicine().navigationBarBackButtonHidden(), label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.primarycolor, lineWidth: 1)
                                            .foregroundStyle(Color.white)
                                            .frame(width: 100, height: 40, alignment: .center)
                                        HStack {
                                            Text("Edit")
                                                .fontWeight(.medium)
                                                .foregroundColor(.primarycolor)
                                        }
                                    }
                                })
                                Button {
                                    showview.toggle()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundStyle(Color.primarycolor)
                                            .frame(width: 150, height: 40, alignment: .center)
                                        HStack {
                                            Text("Choose location")
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                        .offset(y: -260)
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
        if showview {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: 400, height: 450)
                    .foregroundColor(.primarycolor)
                    .cornerRadius(50)
                VStack {
                    HStack {
                        Button(action: {
                            showview.toggle()
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
                    NavigationLink(destination: chooserequestlocation2().navigationBarBackButtonHidden(), label: {
                        Image("map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 300, height: 200)
                    })
                    HStack {
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width: 100, height: 2)
                            .offset(y: -2)
                        Text("Or")
                            .foregroundColor(.white)
                            .padding(.leading)
                            .padding(.trailing)
                        Rectangle()
                            .fill(Color.gray3)
                            .frame(width: 100, height: 2)
                            .offset(y: -2)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    NavigationLink(destination: chooserequestlocation2().navigationBarBackButtonHidden(), label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(12)
                                .foregroundStyle(Color.white)
                                .frame(width: 250, height: 40, alignment: .center)
                            HStack {
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
            .offset(y: 35)
            .transition(.move(edge: .bottom))
            .animation(.easeInOut)
            .edgesIgnoringSafeArea(.all)
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
