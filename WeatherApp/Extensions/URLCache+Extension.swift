//
//  URLCache+Extension.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation
extension URLCache {
    
    static let cache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
