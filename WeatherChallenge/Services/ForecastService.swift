//
//  ForecastService.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation
import Alamofire

protocol serviceHandlerProtocol {
    func resultTrigger(with: [ForecastResponse])
    func errorTrigger(with: Error)
}

class ForecastService {
    var serviceHandler: serviceHandlerProtocol?
    
    let locations = [CityLocation(lat: "34.36", long: "58.26"),
                     CityLocation(lat: "40.41", long: "3.70"),
                     CityLocation(lat: "40.73", long: "-73.93"),
                     CityLocation(lat: "35.68", long: "139.69"),
                     CityLocation(lat: "52.52", long: "13.40")]
    
    func getForecast() async {
        var responses = [ForecastResponse]()
        
        for location in locations {
            do {
                guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.lat)&lon=\(location.long)&appid=9dfb931eb59b6449c304e112a2b02c25&exclude=current,minutely,hourly,alerts&lang=sp&units=metric") else { return }
                
                let decoder = JSONDecoder()
                let data = try await self.afRequest(url:url)
                
                do {
                    let forecastParsed = try decoder.decode(ForecastResponse.self, from: data)
                    responses.append(forecastParsed)
                } catch {
                    print(error.localizedDescription)
                }
                
            } catch {
                print(error)
            }
        }
        
        serviceHandler?.resultTrigger(with: responses)
    }
    
    func afRequest(url:URL) async throws -> Data {
        try await withUnsafeThrowingContinuation { continuation in
            AF.request(url, method: .get).validate().responseData { response in
                if let data = response.data {
                    continuation.resume(returning: data)
                    return
                }
                if let err = response.error {
                    continuation.resume(throwing: err)
                    return
                }
                fatalError("")
            }
        }
    }
}




