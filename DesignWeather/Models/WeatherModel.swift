//
//  WeatherModel.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/12/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherModel = try? newJSONDecoder().decode(WeatherModel.self, from: jsonData)

import Foundation
import SwiftUI

struct WeatherModel: Codable {
    var list: [List]
    var city: City
}

struct List: Codable, Identifiable {
    var id: UUID { UUID() }
    var dt: Int
    var main: Main
    var weather: [Weather]
    let pop: Double
    
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(dt))
    }
}

struct Main: Codable {
    var temp, temp_min, temp_max: Double
}

struct Weather: Codable {
    var id: Int
    var main, description: String
    
    var getImage: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}

struct City: Codable {
    var name: String
}
