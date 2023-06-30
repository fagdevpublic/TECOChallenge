//
//  PrimaryInfoBlock.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation
import UIKit
import PINRemoteImage

class PrimaryInfoBlock: UIView {
    lazy var container: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    lazy var labelReference: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTemp: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconRef: UIImageView = {
        let iconRef = UIImageView()
        iconRef.contentMode = .scaleAspectFit
        iconRef.translatesAutoresizingMaskIntoConstraints = false
        return iconRef
    }()
    
    lazy var labelsContainer1: UIStackView = {
        let labelsContainer1 = UIStackView()
        labelsContainer1.axis = .horizontal
        labelsContainer1.translatesAutoresizingMaskIntoConstraints = false
        return labelsContainer1
    }()
    
    lazy var labelsContainer2: UIStackView = {
        let labelsContainer2 = UIStackView()
        labelsContainer2.axis = .horizontal
        labelsContainer2.translatesAutoresizingMaskIntoConstraints = false
        return labelsContainer2
    }()
    
    lazy var labelMin: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Min"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelMax: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Max"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelMinInfo: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelMaxInfo: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(day: Int?,
                       icon: String?,
                       temp: Double?,
                       tmax: Double?,
                       tmin: Double?) {
        
        if let day = day {
            container.addArrangedSubview(labelReference)
            labelReference.text = Date().dayOfWeek(with: day)?.capitalized
        }
        
        if let temp = temp {
            container.addArrangedSubview(labelTemp)
            labelTemp.text = String(Int(temp)) + "º"
        }
        
        if let icon = icon {
            container.addArrangedSubview(iconRef)
            iconRef.pin_setImage(from: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")!)
        }
        
        if let tmin = tmin {
            container.addArrangedSubview(labelsContainer1)
            labelsContainer1.addArrangedSubview(labelMin)
            labelsContainer1.addArrangedSubview(labelMinInfo)
            labelMinInfo.text = String(Int(tmin)) + "º"
        }
        
        if let tmax = tmax {
            container.addArrangedSubview(labelsContainer2)
            labelsContainer2.addArrangedSubview(labelMax)
            labelsContainer2.addArrangedSubview(labelMaxInfo)
            labelMaxInfo.text = String(Int(tmax)) + "º"
        }
        
        layoutIfNeeded()
    }
    
    private func setupLayout() {
        addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
