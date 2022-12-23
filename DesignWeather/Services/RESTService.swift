//
//  RESTService.swift
//  DesignWeather
//
//  Created by Michal Gruszkiewicz on 22/12/2022.
//

import Foundation
import CoreLocation
import Alamofire

class RestService {
    static let apiToken = "509dc0f3dc1b993966b7673329097e2b"
    
    static func getWeatherForLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (WeatherModel?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiToken)&units=metric"
        
        let request = AF.request(url)
        request.responseDecodable(of: WeatherModel.self) { response in
            guard let weatherData = response.value else {
                completion(nil)
                return
            }
            completion(weatherData)
        }
    }
}
