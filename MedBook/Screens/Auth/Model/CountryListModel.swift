//
//  CountryListModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import Foundation

struct CountryListModel: Codable {
    let data: [String: CountryData]?
}

struct CountryData: Codable {
    let country: String?
    let region: String?
}
