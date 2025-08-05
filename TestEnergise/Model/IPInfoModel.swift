//
//  IPInfoModel.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import Foundation

struct IPInfoModel: Codable {
    
    let success: Bool?
    let message: String?

    let ip: String?
    let continent: String?
    let continentCode: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionCode: String?
    let city: String?
    let postal: String?
    let latitude: Double?
    let longitude: Double?
//    let timezone: String?
//    let isp: String?
//    let org: String?
//    let `as`: String?
}


    
