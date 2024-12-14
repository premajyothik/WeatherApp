//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import SwiftUI

struct WeatherView: View {
    
    var weather: ResponseBody?
    var forecast :Forecast?
    var isLoading :Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    if let name = weather?.name {
                        Text(name )
                            .bold()
                            .font(.title)
                    }
                    
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                if isLoading {
                    LoaderView()
                }
                VStack() {
                        VStack(alignment: .center,spacing: 0) {
                            if let temp = forecast?.list[0].temp.day , let imageString = weather?.weather[0].icon ,let condition = weather?.weather[0].main {
                                
                                Text("\(temp.roundDouble())" + "°")
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                    .padding()
                                    .overlay(
                                        CustomImageView(imageString: "https://openweathermap.org/img/w/\(imageString).png", width: 50)
                                            .offset(x:-10,y: -5)
                                        ,alignment: .bottomTrailing)
                                Text("\(condition)")
                                    .fontWeight(.medium)
                            }
                        }
                        .frame(width: 200, alignment: .leading)
                                                            
                    Spacer()
                        CustomImageView(imageString: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png", width: 350)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack{
                Spacer()
                HStack( spacing: 20) {
                    if let list = forecast?.list {
                        WeatherDayView(forecast: list[1])
                        WeatherDayView(forecast: list[2])
                        WeatherDayView(forecast: list[3])
                    }
                }
                .frame(maxWidth: .infinity, alignment:.center)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .preferredColorScheme(.dark)
        }
       
    }
}

    struct CustomImageView : View {
        var imageString : String
        var width : CGFloat
        var body: some View {
            AsyncImage(url: URL(string: imageString)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width)
            } placeholder: {
                ProgressView()
            }
        }
    }

