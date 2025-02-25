//
//  ContentView.swift
//  weather-app
//
//  Created by Ivar Schreutelkamp on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State var weatherData: WeatherData?
    var urlString = "https://api.openweathermap.org/data/2.5/weather?q=s-Hertogenbosch&appid=3b7c0bb2df5778f696d6dfc53b6189c9&units=metric"

    var body: some View {
        ZStack {
            Image("Lenticular_Cloud")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Text(getNameString())
                Text(getTemperatureString())
            }
            .font(.custom("HelveticaNeueUltraLight", size: 40))
        }
        .onAppear(perform: loadData)
    }
    
    func getNameString() -> String {
        if let name = weatherData?.name {
            return name
        } else {
            return "?"
        }
    }

    func getTemperatureString() -> String {
        if let temp = weatherData?.main.temp {
            return String(format: "%.1f °C", temp)
        } else {
            return "? °C"
        }
    }

    func loadData() {
        guard let url = URL(string: urlString) else {
            print("ERROR: failed to construct a URL from string!")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("ERROR: No data received!")
                return
            }
            
            var newWeatherData: WeatherData?
            do {
                newWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weatherData = newWeatherData
                }
            } catch {
                print("ERROR: Failed to decode JSON data: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
}

#Preview {
    ContentView()
}
