//
//  ApiClient.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation

let API_KEY = "dc17160beaabf8656a3ed8845639e284"

enum NetworkError: Error {
    case invalidURL
    case cityNotfound
    case httpError(code: Int)
    case unknownError(message: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .cityNotfound:
            return "City not found."
        case  .httpError(let code):
            return "HTTP error \(code)"
        case .unknownError(let message):
            return "An unknown error occurred: \(message)."
        }
    }
}

class ApiClient {
    static let shared = ApiClient()
    private init() {
      
        URLCache.shared = .cache
    }
    
    // HTTP request to get the current city weather
    func getCurrentWeather(city:String,completion: @escaping (Result<ResponseBody, NetworkError>) -> Void) {
         guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(API_KEY)") else {
           return completion(.failure(NetworkError.invalidURL))
         }
         if let cachedData = getCachedData(for: url) {
                print("Returning cached data")
                 do {
                     let decodedData = try JSONDecoder().decode(ResponseBody.self, from: cachedData)
                     completion(.success(decodedData))
                 }
                 catch {
                     completion(.failure(NetworkError.unknownError(message: "Decoding error")))
                 }
            } else {
                fetchCityWeather(url: url, completion: completion)
            }
        
        
    }
    
    func fetchCityWeather(url:URL,completion: @escaping (Result<ResponseBody, NetworkError>) -> Void) {
       
        let urlRequest = URLRequest(url: url,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 60.0)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let error = error {
                completion(.failure(NetworkError.unknownError(message: error.localizedDescription)))
            }
            else if let data = data ,httpResponse?.statusCode == 200 {
                // Save the response in cache
                let cachedResponse = CachedURLResponse(response: httpResponse!, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
                
                do {
                    let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(NetworkError.unknownError(message: "Decoding error")))
                }
            }
            else {
                completion(.failure(NetworkError.cityNotfound))
            }
            
        }.resume()
    }
    
    // HTTP request to get the current city weather for 3 days forecast
    func getForecastForThreeDays(city:String,completion: @escaping (Result<Forecast, NetworkError>) -> Void) {

        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&appid=\(API_KEY)&units=metric&cnt=4") else { return completion(.failure(NetworkError.invalidURL)) }
        
        if let cachedData = getCachedData(for: url) {
               print("Returning cached data")
                do {
                    let decodedData = try JSONDecoder().decode(Forecast.self, from: cachedData)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(NetworkError.unknownError(message: "Decoding error")))
                }
           } else {
               getForecastForThreeDays(url: url, completion: completion)
           }
        
       
        
    }
    
    func getForecastForThreeDays(url:URL,completion: @escaping (Result<Forecast, NetworkError>) -> Void) {
        
        let urlRequest = URLRequest(url: url,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 60.0)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let httpResponse = response as? HTTPURLResponse

            if let error = error {
                completion(.failure(NetworkError.unknownError(message: error.localizedDescription)))
            }
            else if let data = data ,httpResponse?.statusCode == 200{
                do {
                    let decodedData = try JSONDecoder().decode(Forecast.self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(NetworkError.unknownError(message: "Decoding error")))
                }
            }
            else{
                completion(.failure(NetworkError.cityNotfound))
            }
            
        }.resume()
        
    }
    
    func getCachedData(for url: URL) -> Data? {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return cachedResponse.data
        }
        return nil
    }
}
