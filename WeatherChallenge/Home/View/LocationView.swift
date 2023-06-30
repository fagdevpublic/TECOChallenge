//
//  LocationView.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation
import AndesUI

class LocationView: UIView {
    
    lazy var labelLocationName: UILabel = {
        let labelLocationName = UILabel()
        labelLocationName.textAlignment = .center
        labelLocationName.translatesAutoresizingMaskIntoConstraints = false
        return labelLocationName
    }()
    
    lazy var locationDetail: UIStackView = {
        let locationDetail = UIStackView()
        locationDetail.axis = .vertical
        locationDetail.translatesAutoresizingMaskIntoConstraints = false
        return locationDetail
    }()
    
    lazy var currentTempContainer: UIView = {
        let currentTempContainer = UIView()
        currentTempContainer.translatesAutoresizingMaskIntoConstraints = false
        return currentTempContainer
    }()
    
    lazy var currentTempBlock: PrimaryInfoBlock = {
        let locationDetail = PrimaryInfoBlock()
        locationDetail.translatesAutoresizingMaskIntoConstraints = false
        return locationDetail
    }()
    
    lazy var forecastTemp: UIStackView = {
        let locationDetail = UIStackView()
        locationDetail.axis = .horizontal
        locationDetail.distribution = .equalSpacing
        locationDetail.translatesAutoresizingMaskIntoConstraints = false
        return locationDetail
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .random()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(locationDetail)
        locationDetail.addArrangedSubview(labelLocationName)
        locationDetail.addArrangedSubview(currentTempContainer)
        currentTempContainer.addSubview(currentTempBlock)
        locationDetail.addArrangedSubview(forecastTemp)
        
        NSLayoutConstraint.activate([
            locationDetail.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationDetail.trailingAnchor.constraint(equalTo: trailingAnchor),
            locationDetail.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            locationDetail.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            currentTempBlock.centerXAnchor.constraint(equalTo: currentTempContainer.centerXAnchor),
            currentTempBlock.centerYAnchor.constraint(equalTo: currentTempContainer.centerYAnchor),
        ])
    }
    
    public func update(with model: InitModelList?){
        labelLocationName.text = (model?.cityName?.capitalized ?? "") + ", " + (model?.cityCountry ?? "")
        guard let forecast = model?.foreCast else { return }
        forecast.indices.forEach { index in
            if index == 0 {
                let first = model?.foreCast?[0]
                currentTempBlock.update(day: first?.dt,
                                        icon: first?.weather?.icon,
                                        temp: first?.temp,
                                        tmax: first?.tempMax,
                                        tmin: first?.tempMin)
            } else {
                let forecast = model?.foreCast?[index]
                let tempBlock = getTempBlock(with: forecast)
                forecastTemp.addArrangedSubview(tempBlock)
            }
        }
        
        layoutIfNeeded()
    }
    
    private func getTempBlock(with forecast: ForecastModel?) -> PrimaryInfoBlock {
        let tempBlock = PrimaryInfoBlock()
        tempBlock.translatesAutoresizingMaskIntoConstraints = false
        tempBlock.update(day: forecast?.dt,
                         icon: forecast?.weather?.icon,
                         temp: nil,
                         tmax: forecast?.tempMax,
                         tmin: forecast?.tempMin)
        return tempBlock
    }
}
