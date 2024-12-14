//
//  ResponseBody.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation

// MARK: - WeatherData
struct ResponseBody: Codable {
    let weather: [Weather]
    let main: Main
    let dt: Int
    let name : String
}



// MARK: - Main
struct Main: Codable {
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case temp
    }
}


// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}


