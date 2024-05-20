////
////  getrequestmedicine.swift
////  medidonate
////
////  Created by fares kassis on 20/5/2024.
////
//
//import Foundation
//
//struct ApiResponse1: Decodable {
//    let data: [RequestData]
//}
//
//struct RequestData: Decodable, Identifiable {
//    let id: Int
//    let attributes: RequestAttributes
//}
//
//struct RequestAttributes: Decodable {
//    let createdAt: String
//    let updatedAt: String
//    let publishedAt: String
//    let post: PostWrapper1
//    let users_permissions_users: UsersPermissionsWrapper
//}
//
//struct PostWrapper1: Decodable {
//    let data: PostData1
//}
//
//struct PostData1: Decodable, Identifiable {
//    let id: Int
//    let attributes: PostAttributes1
//}
//
//struct PostAttributes1: Decodable {
//    let description: String
//    let createdAt: String
//    let updatedAt: String
//    let publishedAt: String
//    let message: String?
//}
//
//struct UsersPermissionsWrapper: Decodable {
//    let data: [UserData]
//}
//
//struct UserData: Decodable, Identifiable {
//    let id: Int
//    let attributes: UserAttributes
//}
//
//struct UserAttributes: Decodable {
//    let username: String
//    let email: String
//    let provider: String
//    let confirmed: Bool
//    let blocked: Bool
//    let createdAt: String
//    let updatedAt: String
//    let phone: String?
//}
