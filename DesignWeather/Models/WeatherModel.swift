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

struct WeatherModel: Codable {
    var list: [List]
    var city: City
}

struct List: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp, temp_min, temp_max: Double
}

struct Weather: Codable {
    var id: Int
    var main, description: String
}

struct City: Codable {
    var name: String
}
