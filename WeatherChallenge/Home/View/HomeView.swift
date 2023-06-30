//
//  InitView.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 29/06/2023.
//

import Foundation
import AndesUI

class HomeView: UIView {
    
    lazy var foreCastCarousel: AndesCarousel = {
        let carousel = AndesCarousel()
        carousel.margin = .none
        carousel.usePaginator = true
        carousel.mode = .snapped
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    
    var citiesDataSource: InitModel?
    
    init() {
        super.init(frame: .zero)
        setupLayout()
        self.foreCastCarousel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        addSubview(foreCastCarousel)
        
        NSLayoutConstraint.activate([
            foreCastCarousel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            foreCastCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            foreCastCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            foreCastCarousel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
    }
    
    public func update(with model: InitModel){
        DispatchQueue.main.async {
            self.citiesDataSource = model
            self.foreCastCarousel.dataSource = self
        }
    }
}

extension HomeView: AndesCarouselDelegate {
    func andesCarousel(_ carouselView: AndesUI.AndesCarousel, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension HomeView: AndesCarouselDataSource {
    func andesCarousel(_ carouselView: AndesUI.AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        let locationView = LocationView()
        locationView.update(with: citiesDataSource?.citiesList[indexPath.row])
        return locationView
    }
    
    func getDataSetSize(_ carouselView: AndesUI.AndesCarousel) -> Int {
        return citiesDataSource?.citiesList.count ?? 0
    }
}
