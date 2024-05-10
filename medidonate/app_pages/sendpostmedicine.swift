//
//  sendpostmedicine.swift
//  medidonate
//
//  Created by fares kassis on 9/5/2024.
//

import Foundation

class ViewModel: ObservableObject {
    
    func postMedicines() {
        let headers = [
            "Content-Type": "application/json",
            "User-Agent": "insomnia/9.1.1",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzE0NDMxNDE2LCJleHAiOjE3MTcwMjM0MTZ9.q1HEC10oBZQ3OpmeH8GSDeySREBYiKbtFo9cTGbxGdY"
        ]
        let parameters: [String: Any] = ["data": [
            "fabricationDate": "2024-02-20",
            "expirationDate": "2024-03-20",
            "quantity": "100",
            "medicines": ["connect": [14]]
        ]]
        print("JSON data structured for sending: \(parameters)")

        guard let url = URL(string: "http://localhost:1337/api/post-medecines") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Failed to serialize data: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }else if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status: \(httpResponse.statusCode)")
                if let data1 = data {
                    if let responseBody = String(data: data1, encoding: .utf8) {
                        print("Response body: \(responseBody)")
                    }
                }
            }
        }

        task.resume()
    }
}
