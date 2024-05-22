//
//  model 2.swift
//  medidonate
//
//  Created by fares kassis on 22/5/2024.
//

import Foundation
import SwiftUI

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
