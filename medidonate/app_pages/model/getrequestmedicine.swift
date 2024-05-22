import Foundation

struct RequestResponse: Codable {
    let data: [RequestData]
}

struct RequestData: Codable {
    let id: Int
    let attributes: Attributes
}

struct Attributes: Codable {
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let post: Post1
    let users_permissions_users: UsersPermissionsUsers?
}

struct Post1: Codable {
    let data: PostData1?
}

struct PostData1: Codable {
    let id: Int
    let attributes: PostAttributes1
}

struct PostAttributes1: Codable {
    let description: String
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    let message: String?
}

struct UsersPermissionsUsers: Codable {
    let data: [UserData]
}

struct UserData: Codable {
    let id: Int
    let attributes: UserAttributes
}

struct UserAttributes: Codable {
    let username: String
    let email: String
    let provider: String
    let confirmed: Bool
    let blocked: Bool
    let createdAt: String
    let updatedAt: String
    let phone: String?
}
