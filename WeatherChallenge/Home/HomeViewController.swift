//
//  InitViewController.swift
//  WeatherChallenge
//
//  Created by Flavio Andres Gomez on 27/06/2023.
//

import UIKit
import AndesUI

class HomeViewController: UIViewController, viewModelProtocol {
    lazy var initView: HomeView = {
        let view = HomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        setupLayout()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.viewModel = HomeViewModel()
        viewModel?.viewModelDelegate = self
    }
    
    private func setupLayout(){
        view.addSubview(initView)
        
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            initView.topAnchor.constraint(equalTo: guide.topAnchor),
            initView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            initView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            initView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    public func updateView(with data: InitModel){
        initView.update(with: data)
    }
}
