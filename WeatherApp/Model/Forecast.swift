//
//  Forecast.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation


// MARK: - Forecast
struct Forecast: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp
        case  weather
    }
}


// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
//
//// MARK: - Weather
//struct Weather: Codable {
//    let id: Int
//    let main, description, icon: String
//}
