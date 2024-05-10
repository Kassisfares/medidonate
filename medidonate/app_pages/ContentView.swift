//import SwiftUI
//import SwiftUIX
//
//struct Medicine1: Identifiable {
//    let id: Int
//    let name: String
//    let category: String
//    let type: String
//}
//
//class MedicineViewModel: ObservableObject {
//    @Published var medicines = [Medicine1]()
//    
//    init() {
//        fetchMedicines()
//    }
//    
//    func fetchMedicines() {
//        guard let url = URL(string: "http://localhost:1337/api/medicines") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY", forHTTPHeaderField: "Authorization")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            
//            let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601 // Assuming dates are in ISO 8601 format
//                
//                do {
//                    let decodedResponse = try decoder.decode(MedicineResponse.self, from: data)
//                    
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//                    
//                    DispatchQueue.main.async {
//                        self.medicines = decodedResponse.data.map { medicineData in
//                            Medicine1(
//                                id: medicineData.id,
//                                name: medicineData.attributes.name,
//                                category: medicineData.attributes.category,
//                                type: medicineData.attributes.type
//                            )
//                        }
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//        }.resume()
//    }
//}
//
//struct MedicineResponse: Decodable {
//    struct MedicineData: Decodable {
//        let id: Int
//        let attributes: MedicineAttributes
//    }
//    
//    struct MedicineAttributes: Decodable {
//        let name: String
//        let category: String
//        let type: String
//    }
//    
//    let data: [MedicineData]
//}
//
//struct ContentView: View {
//    @ObservedObject var viewModel = MedicineViewModel()
//    @State private var searchText = ""
//    
//    var body: some View {
//        NavigationView {
//            List {
//                SearchBar("Medicine name", text: $searchText)
//                    .showsCancelButton(true)
//                    .onCancel {
//                        self.searchText = ""
//                    }
//                if !searchText.isEmpty {
//                    ForEach(viewModel.medicines.filter {
//                        self.searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(self.searchText)
//                    }) { medicine in
//                        VStack(alignment: .leading) {
//                            Text(medicine.name)
//                                .font(.headline)
//                            Text("Category: \(medicine.category)")
//                            Text("Type: \(medicine.type)")
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
