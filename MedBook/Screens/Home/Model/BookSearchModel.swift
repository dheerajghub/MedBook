//
//  BookSearchModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import Foundation

struct BookSearchModel: Codable {
    let numFound: Int?
    let docs: [BookDocModel]?
}

struct BookDocModel: Codable {
    
    let title: String?
    let ratingsAverage: Double?
    let ratingsCount: Int?
    let authorName: [String]?
    let coverId: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case ratingsAverage = "ratings_average"
        case ratingsCount = "ratings_count"
        case authorName = "author_name"
        case coverId = "cover_i"
    }
    
}
