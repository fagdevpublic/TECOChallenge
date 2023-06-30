//
//  InitModel.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation

struct InitModel {
    let citiesList : [InitModelList]
}

struct InitModelList {
    let cityName: String?
    let cityCountry: String?
    let foreCast: [ForecastModel]?
}

struct ForecastModel {
    let dt: Int?
    let temp, feelsLike, tempMin, tempMax: Double
    let weather: Weather?
    let dtTxt: String
}
