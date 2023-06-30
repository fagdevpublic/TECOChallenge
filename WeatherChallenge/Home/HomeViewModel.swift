//
//  InitViewModel.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation
protocol viewModelProtocol {
    func updateView(with: InitModel)
}

class HomeViewModel {
    let service = ForecastService()
    var viewModelDelegate: viewModelProtocol?
    
    init() {
        service.serviceHandler = self
        Task {
            await getData()
        }
    }
    
    private func getData() async{
        await service.getForecast()
    }
    
    private func mapResponseToViewData(with response: [ForecastResponse]) {
        let model = InitModel(citiesList: response.map({ response in
            InitModelList(cityName: response.city.name,
                          cityCountry: response.city.country,
                          foreCast: mapListToForecastModel(with: unifyDates(with: response.list)))
        }))
        
        viewModelDelegate?.updateView(with: model)
    }
    
    private func mapListToForecastModel(with list: [List]) -> [ForecastModel]? {
        list.map { element in
            return ForecastModel(dt: element.dt,
                                 temp: element.main.temp,
                                 feelsLike: element.main.feelsLike,
                                 tempMin: element.main.tempMin,
                                 tempMax: element.main.tempMax,
                                 weather: element.weather.first,
                                 dtTxt: element.dtTxt)
        }
    }
    
    private func unifyDates(with list: [List]) -> [List] {
        var dayDistinct = Set<Int>()
        var unifyDatesList = [List]()
        
        for element in list {
            let date = Date(timeIntervalSince1970: TimeInterval(element.dt))
            let day = Calendar.current.component(.day, from: date)
            
            if !dayDistinct.contains(day),
               dayDistinct.count <= 3 {
                unifyDatesList.append(element)
                dayDistinct.insert(day)
            }
        }
        return unifyDatesList
    }
}

extension HomeViewModel: serviceHandlerProtocol {
    func resultTrigger(with responses: [ForecastResponse]) {
        mapResponseToViewData(with: responses)
    }
    
    func errorTrigger(with error: Error) {
        print(error)
    }
}
