//
//  ContentView.swift
//  weather-app
//
//  Created by Ivar Schreutelkamp on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State var weatherData: WeatherData?
    
    var body: some View {
        ZStack {
            Image("Lenticular_Cloud")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Text("A")
                Text(getTemperatureString())
            }
            .font(.custom("HelveticaNeueUltraLight",size:120))
        }
        .onAppear(perform: loadData)
    }
    
    func getTemperatureString() -> String {
        return "? °C"
    }
    
    func loadData() {
        
    }
}

#Preview {
    ContentView()
}
