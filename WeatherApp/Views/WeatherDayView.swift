//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import SwiftUI

struct WeatherDayView: View {
//    var dayOfWeek: Int
//    var imageName: String
//    var temperature: Double
    var forecast : List
    
    var body: some View {
        VStack {
            Text(getDayofWeek(dt:  forecast.dt ))
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.blue)
            CustomImageView(imageString: "https://openweathermap.org/img/w/\(forecast.weather[0].icon).png", width: 50)
            Text("\(forecast.temp.day.roundDouble() )°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.blue)
        }
    }
    
    func getDayofWeek(dt:Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return dateFormatter.string(from: date)
    }
}
