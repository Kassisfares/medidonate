//import Foundation
//
//let headers = [
//  "Content-Type": "application/json",
//  "User-Agent": "insomnia/9.0.0",
//  "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
//]
//let parameters = ["data": [
//    "description": "insomnia test",
//    "medicineFabDate": "2024-05-04",
//    "medicineExpDate": "2025-07-04",
//    "quantity": 15,
//    "medicines": ["connect": [1]]
//  ]] as [String : Any]
//
//let postData = JSONSerialization.data(withJSONObject: parameters, options: [])
//
//let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:1337/api/post/uploadpost")! as URL,
//                                        cachePolicy: .useProtocolCachePolicy,
//                                    timeoutInterval: 10.0)
//request.httpMethod = "POST"
//request.allHTTPHeaderFields = headers
//request.httpBody = postData as Data
//
//let session = URLSession.shared
//let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//  if (error != nil) {
//    print(error)
//  } else {
//    let httpResponse = response as? HTTPURLResponse
//    print(httpResponse)
//  }
//})
//
//dataTask.resume()
