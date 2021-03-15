//
//  ListTableViewCell.swift
//  alarstudios
//
//  Created by Alex Bro on 14.03.2021.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    lazy var cellImage = UIImageView()
    lazy var nameLabel = UILabel(isWrap: true)
    lazy var activity = UIActivityIndicatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
        nameLabel.text = nil
    }
    
    func setData(with model: ListTableCellViewModel) {
        activity.startAnimating()
        nameLabel.text = model.name
    }
    
    func setImage(_ image: UIImage?) {
        cellImage.image = image
        activity.stopAnimating()
    }
    
//MARK: - Private methods
    private func configureView() {
        setupImageView()
        setupStackView()
        setupActivityIndicator()
    }
    
    private func setupImageView() {
        cellImage.backgroundColor = .systemGray5
        cellImage.contentMode = .scaleAspectFill
        cellImage.clipsToBounds = true
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellImage)
        
        NSLayoutConstraint.activate([
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.double),
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.double),
            cellImage.heightAnchor.constraint(equalToConstant: 150.0),
            cellImage.widthAnchor.constraint(equalToConstant: 200.0)
        ])
    }
    
    private func setupStackView() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.double),
            nameLabel.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: Margins.single),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Margins.double),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Margins.single)
        ])
    }
    
    private func setupActivityIndicator() {
        cellImage.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            activity.topAnchor.constraint(equalTo: cellImage.topAnchor),
            activity.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            activity.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor)
        ])
    }
}
