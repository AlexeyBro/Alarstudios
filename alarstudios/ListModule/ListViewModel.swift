//
//  ListViewModel.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

protocol ListViewModel {
    func numberOfRows() -> Int
    func willDisplayCell(_ cell: ListTableViewCell, index: Int)
    func loadData()
    func showMapView(index: Int)
}

class ListViewModelImpl: ListViewModel {

    weak var view: ListViewProtocol?
    private let networkManager: ListNetworkManager
    private let router: Router
    private let imageDownloader: ImageDownloader
    private lazy var listModel: [List] = []
    private lazy var currentPage = 0
    
    init(networkManager: ListNetworkManager, router: Router, imageDownloader: ImageDownloader) {
        self.networkManager = networkManager
        self.router = router
        self.imageDownloader = imageDownloader
    }
    
    func numberOfRows() -> Int {
        listModel.count
    }
    
    func willDisplayCell(_ cell: ListTableViewCell, index: Int) {
        let query = listModel[index].name
        let tableCellViewModel = ListTableCellViewModel(id: listModel[index].id,
                                                        name: listModel[index].name,
                                                        country: listModel[index].country)
        cell.setData(with: tableCellViewModel)
        
        fetchImage(query, completion: { image in
            if cell.nameLabel.text == query {
                cell.setImage(image)
            }
        })
    }
    
    func loadData() {
        currentPage += 1
        guard let code = UserDefaults.standard.value(forKey: "code") as? String else { return }
        networkManager.fetchData(with: code, currentPage: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                response.data.forEach { self?.listModel.append($0) }
                DispatchQueue.main.async { self?.view?.refreshView() }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchImage(_ query: String, completion: @escaping (UIImage?) -> Void) {
        networkManager.fetchImage(with: query) { [weak self] result in
            switch result {
            case .success(let response):
                guard let URLStrig = response.results.first?.urls.small else { return }
                self?.downloadImage(URLStrig, completion: { completion($0) })
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
    private func downloadImage(_ URLString: String, completion: @escaping (UIImage?) -> Void) {
        imageDownloader.downloadImage(with: URLString) { [weak self] result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
    func showMapView(index: Int) {
        let listModel = self.listModel[index]
        router.toMapViewController(with: listModel)
    }
}
