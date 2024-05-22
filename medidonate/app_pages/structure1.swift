import Foundation

// MARK: - Main Data Structure
struct MainData: Decodable {
    let data: [Datum1]?
}

// MARK: - Datum
struct Datum1: Decodable {
    let id: Int?
    let attributes: Attributes2?
}

// MARK: - Attributes
struct Attributes2: Decodable {
    let createdAt, updatedAt, publishedAt: String?
    let post: PostContainer2?
}

// MARK: - PostContainer
struct PostContainer2: Decodable {
    let data: PostData2?
}

// MARK: - PostData
struct PostData2: Decodable {
    let id: Int?
    let attributes: PostAttributes2?
}

// MARK: - PostAttributes
struct PostAttributes2: Decodable {
    let description, createdAt, updatedAt, publishedAt: String?
    let message: String?
    let users_permissions_user: UsersPermissionsUserContainer?
    let photos: PhotosContainer?
    let post_medicines: PostMedicinesContainer?
    let request: RequestContainer2?
}

// MARK: - UsersPermissionsUserContainer
struct UsersPermissionsUserContainer: Decodable {
    let data: UsersPermissionsUserData?
}

// MARK: - UsersPermissionsUserData
struct UsersPermissionsUserData: Decodable {
    let id: Int?
    let attributes: UsersPermissionsUserAttributes?
}

// MARK: - UsersPermissionsUserAttributes
struct UsersPermissionsUserAttributes: Decodable {
    let username, email, provider: String?
    let confirmed, blocked: Bool?
    let createdAt, updatedAt: String?
    let phone: String?
    let role: RoleContainer?
    let posts: PostsContainer?
    let requests: RequestsContainer?
}

// MARK: - RoleContainer
struct RoleContainer: Decodable {
    let data: RoleData?
}

// MARK: - RoleData
struct RoleData: Decodable {
    let id: Int?
    let attributes: RoleAttributes?
}

// MARK: - RoleAttributes
struct RoleAttributes: Decodable {
    let name, description, type: String?
    let createdAt, updatedAt: String?
}

// MARK: - PostsContainer
struct PostsContainer: Decodable {
    let data: [PostData2]?
}

// MARK: - RequestsContainer
struct RequestsContainer: Decodable {
    let data: [RequestData2]?
}

// MARK: - RequestContainer
struct RequestContainer2: Decodable {
    let data: [RequestData2]?
}

// MARK: - RequestData
struct RequestData2: Decodable {
    let id: Int?
    let attributes: RequestAttributes?
}

// MARK: - RequestAttributes
struct RequestAttributes: Decodable {
    let createdAt, updatedAt, publishedAt: String?
}

// MARK: - PhotosContainer
struct PhotosContainer: Decodable {
    let data: [PhotoData2]?
}

// MARK: - PhotoData
struct PhotoData2: Decodable {
    let id: Int?
    let attributes: PhotoAttributes2?
}

// MARK: - PhotoAttributes
struct PhotoAttributes2: Decodable {
    let name: String?
    let alternativeText, caption: String?
    let width, height: Int?
    let formats: Formats?
    let hash, ext, mime: String?
    let size: Double?
    let url: String?
    let previewUrl: String?
    let provider: String?
    let providerMetadata: String?
    let createdAt, updatedAt: String?
}

// MARK: - Formats
struct Formats: Decodable {
    let thumbnail: Thumbnail?
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let ext, url, hash, mime: String?
    let name: String?
    let path: String?
    let size: Double?
    let width, height: Int?
    let sizeInBytes: Int?
}

// MARK: - PostMedicinesContainer
struct PostMedicinesContainer: Decodable {
    let data: [PostMedicineData2]?
}

// MARK: - PostMedicineData
struct PostMedicineData2: Decodable {
    let id: Int?
    let attributes: PostMedicineAttributes2?
}

// MARK: - PostMedicineAttributes
struct PostMedicineAttributes2: Decodable {
    let fabricationDate, expirationDate: String?
    let quantity: Int?
    let createdAt, updatedAt: String?
}
