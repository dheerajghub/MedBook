//
//  Formatter+Extension.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import Foundation

extension Formatter {
    static let custom: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}

extension FloatingPoint {
    var isWholeNumber: Bool { isNormal ? self == rounded() : isZero }
    var custom: String {
        Formatter.custom.minimumFractionDigits = isWholeNumber ? 0 : 1
        return Formatter.custom.string(for: self) ?? ""
    }
}
