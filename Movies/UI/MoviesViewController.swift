//
//  MoviesViewController.swift
//  Movies
//
//  Created by Tatiana Ampilogova on 6/4/22.
//

import UIKit

/// MoviesViewController -> MovieService -> NetworkSerivce
class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView = UITableView()
    private var items = [Movie]()
    private let movieService: MovieService
    private let identifier = "MovieCell"
    private var page = 1
    
    init(movieService: MovieService) {
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadMovies()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(MovieCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func loadMovies() {
        movieService.loadMovie(page: page, locale: localeLanguage()) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.items += movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func localeLanguage() -> String {
        return Locale.preferredLanguages[0]
    }

    //MARK: - UITableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieCell
        let item = items[indexPath.row]
        cell.configure(model: item)
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - scrollView.frame.height
        let spinner = UIActivityIndicatorView(style: .medium)
        
        if contentHeight - currentOffset <= 10.0  {
            self.page += 1
            
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            DispatchQueue.global().async {
                self.loadMovies()
                DispatchQueue.main.async {
                    spinner.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
            }
        }
    }
}

