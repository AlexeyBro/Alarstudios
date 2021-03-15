//
//  MapView.swift
//  alarstudios
//
//  Created by Alex Bro on 15.03.2021.
//

import UIKit

class DescriptionMapView: UIView {
    
    lazy var idLabel = UILabel()
    lazy var nameLabel = UILabel(isWrap: true)
    lazy var countryLabel = UILabel(isWrap: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(with model: DescriptionMapViewModel) {
        idLabel.text = model.id
        nameLabel.text = model.name
        countryLabel.text = model.country
    }
    
//MARK: - Private methods
    private func configureView() {
        let subviews = [idLabel, nameLabel, countryLabel]
        let stackView = UIStackView(arrangedSubviews: subviews, axis: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.double),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Margins.double),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margins.double),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margins.double)
        ])
    }
}
