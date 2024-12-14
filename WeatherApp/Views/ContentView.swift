//
//  ContentView.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 13/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var weatherModel = WeatherViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
        
            GeometryReader {reader in
                ZStack {
                    LinearGradient(colors: [.blue,.white], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading ){

                        if locationViewModel.isLoading {
                            LoaderView()
                        }
                        else {
                            WeatherView(weather: weatherModel.weatherData, forecast: weatherModel.forecastData,isLoading: weatherModel.isLoading)
                                .task {
                                    getWeatherData(city: locationViewModel.city ?? searchText)
                                }
                            
                        }
                        
                    }
                    .navigationTitle("Weather")
                    .searchable(text: $searchText, prompt: "Enter city")
                    .onSubmit(of: .search, {
                        getWeatherData(city: searchText)
                    })
                    .alert("Error", isPresented: $weatherModel.showAlert, actions: {
                                Button("OK", role: .cancel) { }
                            }, message: {
                                Text(weatherModel.error?.errorDescription ?? "")
                            })
                }
            }
        }
        
       
       
    }
    
    func getWeatherData(city: String) {
        weatherModel.getWeatherOfCity(city: city)
    }
    
}

                               
 struct CustomTextField: View {
   
    @Binding var text: String
    var body: some View {
        
        TextField("Enter City", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            
    }
}
