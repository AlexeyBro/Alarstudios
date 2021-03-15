//
//  MapViewController.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {
    func setCoordinate(with latitude: Double, longitude: Double)
    func setDescription(with model: DescriptionMapViewModel)
}

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    private lazy var mapView = MKMapView()
    private lazy var descriptionView = DescriptionMapView()
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Карта"
        configureView()
        viewModel.setData()
    }
    
//MARK: - Private methods
    private func configureView() {
        [mapView, descriptionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupMapView()
        setupDescriptionView()
    }
    
    private func setupMapView() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDescriptionView() {
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margins.double),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Margins.double * 2)
        ])
    }
}

//MARK: - MapViewProtocol
extension MapViewController: MapViewProtocol {
    
    func setCoordinate(with latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate,
                                        latitudinalMeters: 10000,
                                        longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func setDescription(with model: DescriptionMapViewModel) {
        descriptionView.setData(with: model)
    }
}
