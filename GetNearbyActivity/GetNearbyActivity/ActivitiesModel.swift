//
//  ActivitiesModel.swift
//  GetNearbyActivity
//
//  Created by manvendu pathak  on 24/08/24.
//

import Foundation

struct ToiletData: Codable {
    let type: String
    let features: [Feature]
}

// MARK: - Feature Structure
struct Feature: Codable, Identifiable {
    let id = UUID()
    let type: String
    let properties: Properties
    let geometry: Geometry
}

// MARK: - Geometry Structure
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties Structure
struct Properties: Codable {
    let name: String?
    let country: String
    let countryCode: String
    let state: String
    let stateDistrict: String
    let county: String
    let city: String
    let postcode: String
    let district: String
    let suburb: String
    let street: String
    let lon: Double
    let lat: Double
    let stateCode: String
    let formatted: String
    let addressLine1: String
    let addressLine2: String
    let categories: [String]
    let details: [String]?
    let datasource: Datasource
    let operatorName: String?
    let facilities: Facilities?
    let restrictions: Restrictions?
    let targetedFor: TargetedFor?
    let placeID: String

    enum CodingKeys: String, CodingKey {
        case name, country, state, county, city, postcode, district, suburb, street, lon, lat, formatted, categories, details, datasource, facilities, restrictions, targetedFor
        case countryCode = "country_code"
        case stateDistrict = "state_district"
        case stateCode = "state_code"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case operatorName = "operator"
        case placeID = "place_id"
    }
}

// MARK: - Datasource Structure
struct Datasource: Codable {
    let sourcename: String
    let attribution: String
    let license: String
    let url: String
    let raw: Raw
}

// MARK: - Raw Structure
struct Raw: Codable {
    let name: String?
    let osmID: Int
    let amenity: String
    let building: String
    let osmType: String

    enum CodingKeys: String, CodingKey {
        case name, amenity, building
        case osmID = "osm_id"
        case osmType = "osm_type"
    }
}

// MARK: - Facilities Structure
struct Facilities: Codable {
    let wheelchair: Bool?
}

// MARK: - Restrictions Structure
struct Restrictions: Codable {
    let accessDetails: AccessDetails?

    enum CodingKeys: String, CodingKey {
        case accessDetails = "access_details"
    }
}

// MARK: - AccessDetails Structure
struct AccessDetails: Codable {
    let maleOnly: Bool?
    let femaleOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case maleOnly = "male_only"
        case femaleOnly = "female_only"
    }
}

// MARK: - TargetedFor Structure
struct TargetedFor: Codable {
    let man: Bool?
    let woman: Bool?
}
