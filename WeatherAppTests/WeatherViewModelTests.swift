//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    
    override func setUp() {
        viewModel = WeatherViewModel()
    }
    
    override  func tearDown() {
        viewModel = nil
    }
   
    func testGetWeatherOfCity_Success() {
        
        let expectation = XCTestExpectation(description: "Weather and forecast data fetched successfully")
        
        // Act
        viewModel.getWeatherOfCity(city: "London")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Allow async tasks to complete
            // Assert
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be false")
            XCTAssertNotNil(self.viewModel.weatherData, "Weather data should not be nil")
            XCTAssertNotNil(self.viewModel.forecastData, "Forecast data should not be nil")
            XCTAssertNotNil(self.viewModel.weatherData?.main.temp, "Temperature should not be nil")
            XCTAssertFalse(self.viewModel.showAlert, "Alert should not be shown")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetWeatherOfCity_WeatherFailure() {
        
        let expectation = XCTestExpectation(description: "Weather fetch failed")
        
        // Act
        viewModel.getWeatherOfCity(city: "Lonon")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Allow async tasks to complete
            // Assert
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be false")
            XCTAssertNil(self.viewModel.weatherData, "Weather data should be nil")
            XCTAssertTrue(self.viewModel.showAlert, "Alert should be shown")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testWeather_ForecastSuccess() {
       
        let expectation = XCTestExpectation(description: "Forecast fetch failed")
        
        viewModel.getWeatherOfCity(city: "London")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Allow async tasks to complete
            // Assert
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be true")
            XCTAssertNotNil(self.viewModel.forecastData, "Forecast data should not be nil")
            XCTAssertFalse(self.viewModel.showAlert, "Alert should be shown")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testWeather_ForecastFailure() {
       
        let expectation = XCTestExpectation(description: "Forecast fetch failed")
        
        viewModel.getWeatherOfCity(city: "Lonon")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // Allow async tasks to complete
            // Assert
            XCTAssertFalse(self.viewModel.isLoading, "Loading state should be true")
            XCTAssertNil(self.viewModel.forecastData, "Forecast data should not be nil")
            XCTAssertTrue(self.viewModel.showAlert, "Alert should be shown")
            expectation.fulfill()
        }bad
        
        wait(for: [expectation], timeout: 2)
    }
}
