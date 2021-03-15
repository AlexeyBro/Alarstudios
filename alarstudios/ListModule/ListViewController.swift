//
//  ListViewController.swift
//  alarstudios
//
//  Created by Alex Bro on 13.03.2021.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func refreshView()
    func showError(errorString: String)
}

class ListViewController: UIViewController {
    
    private var viewModel: ListViewModel
    private lazy var tableView = UITableView()
    private lazy var activity = UIActivityIndicatorView(style: .large)
    private lazy var footerActivity = UIActivityIndicatorView()
    private lazy var isLoading = false
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Список"
        navigationSettings()
        setupTableView()
        setupActivityIndicator()
        viewModel.loadData()
    }
    
    //MARK: - Private methods
    private func navigationSettings() {
        guard let navigationController = navigationController else { return }
        navigationController.viewControllers.removeAll(where: { $0 is AuthViewController })
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.registerReusableCell(ListTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        ///add activity in tableView footer
        footerActivity.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40)
        tableView.tableFooterView = footerActivity
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.backgroundColor = .white
        activity.startAnimating()
        
        NSLayoutConstraint.activate([
            activity.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activity.topAnchor.constraint(equalTo: view.topAnchor),
            activity.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activity.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadMore() {
        if !isLoading {
            isLoading = true
            viewModel.loadData()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ListTableViewCell.self, at: indexPath) else {
            return UITableViewCell()
        }
        viewModel.willDisplayCell(cell, index: indexPath.row)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height {
            if !isLoading {
                footerActivity.startAnimating()
                loadMore()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showMapView(index: indexPath.row)
    }
}

//MARK: - ListViewProtocol
extension ListViewController: ListViewProtocol {
    
    func refreshView() {
        tableView.reloadData()
        activity.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.footerActivity.stopAnimating()
            self.isLoading = false
        }
    }
    
    func showError(errorString: String) {
        self.showBaseInfoAlert(description: errorString)
    }
}
