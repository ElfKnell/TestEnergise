//
//  IPInfoModel.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import Foundation

struct IPInfoModel: Codable {
    
    let status: String?
    let message: String?

    let query: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionName: String?
    let city: String?
    let zip: String?
    let lat: Double?
    let lon: Double?
    let timezone: String?
    let isp: String?
    let org: String?
    let `as`: String?
}
