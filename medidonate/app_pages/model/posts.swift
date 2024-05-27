////
////  model1.swift
////  medidonate
////
////  Created by fares kassis on 22/5/2024.
////
import Foundation

struct ApiResponse: Decodable {
    let data: [PostData]
}

struct PostData: Decodable, Identifiable {
    let id: Int
    let attributes: PostAttributes
}

struct PostAttributes: Decodable {
    let description: String
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let message: String?
    let users_permissions_user: PostUserPermissionsWrapper
    let post_medicines: PostMedicineWrapper?
    let photos: PhotoWrapper?
}


struct PostUserPermissionsWrapper: Decodable {
    let data: PostUserPermissionsData
}

struct PostUserPermissionsData: Decodable {
    let id: Int
    let attributes: PostUserPermissionsAttributes
}

struct PostUserPermissionsAttributes: Decodable {
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool?
    let blocked: Bool?
    let createdAt: Date
    let updatedAt: Date
    let phone: String?
}

struct PostMedicineWrapper: Decodable {
    let data: [PostMedicineData]
}

struct PostMedicineData: Decodable {
    let id: Int
    let attributes: PostMedicineAttributes
}

struct PostMedicineAttributes: Decodable {
    let fabricationDate: Date?
    let expirationDate: Date?
    let quantity: Int
    let createdAt: Date
    let updatedAt: Date
    let medicines: MedicineWrapper
}

struct MedicineWrapper: Decodable {
    let data: MedicineData1
}

struct MedicineData1: Decodable {
    let id: Int
    let attributes: MedicineAttributes1
}

struct MedicineAttributes1: Decodable {
    let name: String
    let createdAt: Date
    let updatedAt: Date
    let publishedAt: Date
    let category: String
    let type: String
}

struct PhotoWrapper: Decodable {
    let data: [PhotoData]?
}

struct PhotoData: Decodable, Identifiable {
    let id: Int
    let attributes: PhotoAttributes
}

struct PhotoAttributes: Decodable {
    let name: String
    let alternativeText: String?
    let caption: String?
    let width: Int
    let height: Int
    let formats: PhotoFormats
    let hash: String
    let ext: String
    let mime: String
    let size: Double
    let url: String
    let previewUrl: String?
    let provider: String
    let provider_metadata: String?
    let createdAt: Date
    let updatedAt: Date
}

struct PhotoFormats: Decodable {
    let large: PhotoFormat?
    let small: PhotoFormat?
    let medium: PhotoFormat?
    let thumbnail: PhotoFormat?
}

struct PhotoFormat: Decodable {
    let ext: String
    let url: String
    let hash: String
    let mime: String
    let name: String
    let path: String?
    let size: Double
    let width: Int
    let height: Int
    let sizeInBytes: Int
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let iso8601WithoutMilliseconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    static let iso8601DateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static var flexibleISO8601: JSONDecoder.DateDecodingStrategy {
        .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            if container.decodeNil() {
                // Return a default date in case of nil because we can't return nil from a non-optional return type function in this context.
                // This default date can be used to identify unset dates later in your application logic.
                return Date.distantPast
            }
            let dateStr = try container.decode(String.self)
            
            let formatters = [
                DateFormatter.iso8601Full,
                DateFormatter.iso8601WithoutMilliseconds,
                DateFormatter.iso8601DateOnly
            ]
            
            for formatter in formatters {
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            }
            
            // Throw decoding error if no formats match
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr)")
        }
    }
}
