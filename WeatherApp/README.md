
# Weather App

A Swift-based weather application that fetches and displays current weather and 3-day forecast data for a given city. The app implements asynchronous networking, a caching mechanism, and error handling for offline usage.

---

## Features

- Fetch current weather data and 3-day forecast for a city from current location using core location
- By entering a city name in the search bar, we can see the weather. 
- Display weather details including temperature and description.
- Show loading indicators while fetching data.
- Handle errors with appropriate alerts when network requests fail.
- Cache the last fetched weather data for offline usage.

---

## Technologies Used

- **Swift**: Core programming language.
- **SwiftUI**: For building the user interface.
- **XCTest**: For unit testing.

---

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture:

- **Model**: Represents weather and forecast data.
- **View**: Displays the data fetched from the view model.
- **ViewModel**: Handles the business logic and communicates with the API client to fetch data.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/weather-app.git
   ```

2. Open the project in Xcode:
   ```bash
   cd weather-app
   open WeatherApp.xcodeproj
   ```

3. Build and run the app on the simulator or a physical device.

## Usage

1. Launch the app.
2. Enter the name of a city in the search bar.
3. View the current weather and 3-day forecast.
4. Handle offline usage with the last cached data.





## Unit Testing

Unit tests are written using **XCTest** to validate core functionalities:

- Verify `getWeatherData` and `getForecastData` methods for success and failure scenarios.
- Test caching mechanism to ensure proper saving and loading of data.


## Folder Structure

```
WeatherApp
|
├── Models
|   └── WeatherData.swift
|   └── Forecast.swift
|
├── ViewModels
|   └── WeatherViewModel.swift
|
├── Views
|   └── WeatherView.swift
|
├── Networking
|   └── ApiClient.swift
|
└── Tests
    └── WeatherViewModelTests.swift
```

---
