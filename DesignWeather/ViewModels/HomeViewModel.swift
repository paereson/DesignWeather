//
//  HomeViewModel.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 23/12/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var weather: WeatherModel?
    
    init() {
        RestService.getWeatherForLocation(lat: 51.1000, lon: 17.0333) { [weak self] responseWeather in
            self?.weather = responseWeather
        }
    }
    
}
