//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import Foundation
import CoreLocation


class WeatherViewModel : ObservableObject {
    
    @Published var weatherData: ResponseBody?
    @Published var forecastData: Forecast?

    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    var error: NetworkError?
    
    func getWeatherOfCity(city:String){
        if city.isEmpty { return }
        self.isLoading = true
        let weatherGroup = DispatchGroup()
        weatherGroup.enter()
        getWeatherData(city: city) {
            weatherGroup.leave()
        }
        weatherGroup.enter()
        getForecastData(city: city) {
            weatherGroup.leave()
        }
        weatherGroup.notify(queue: .main){[weak self] in
            self?.isLoading = false
        }
    }
    
    func getWeatherData(city:String,completion:@escaping ()->()){
        ApiClient.shared.getCurrentWeather(city: city) {[weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.weatherData = weather
                    self?.showAlert = false
                }
                completion()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                    self?.showAlert = true
                }
                completion()
            }
        }
    }
    
    func getForecastData(city:String,completion:@escaping ()->()){
        ApiClient.shared.getForecastForThreeDays(city: city) {[weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.forecastData = weather
                    self?.showAlert = false
                }
                completion()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                    self?.showAlert = true
                }
                completion()
            }
        }
    }
}

