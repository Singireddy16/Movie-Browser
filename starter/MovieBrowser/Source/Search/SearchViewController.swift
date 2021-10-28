//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var resultSearchController = UISearchController()
    var movieListViewModel: MovieListViewModel?
    
    var page = 1
    private var searchterm: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListViewModel = MovieListViewModel(apiService: MovieAPI())
        
        title = Constant.Titles.naviagtionTitle
        
        self.definesPresentationContext = true
        
        resultSearchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            //searchController.delegate = self
            searchController.searchBar.delegate = self
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = Constant.Titles.placeholdertext
            searchController.searchBar.tintColor = UIColor.systemBlue
            searchController.searchBar.becomeFirstResponder()
            tableView.tableHeaderView = searchController.searchBar
            searchController.searchBar.setValue("Go", forKey: "cancelButtonText")
            return searchController
        })()
        
        movieListViewModel?.movieSuccess = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        movieListViewModel?.movieError = { [weak self] (error) in
            guard error != nil else {
                return
            }
            self?.showAlertInViewController(titleStr: Constant.Alert.title, messageStr: (error?.localizedDescription)! , okButtonTitle: Constant.Alert.ok)
        }
        // Reload the table
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func  navigateToDetailsController(indexPath: IndexPath) {
        
        if let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController {
            controller.movie = movieListViewModel?.getCellViewModel(at: indexPath)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return movieListViewModel?.getTotalMovies() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchResultCell") as? MovieSearchResultCell
        cell?.movie  = movieListViewModel?.getCellViewModel(at: indexPath)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsController(indexPath: indexPath)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count != 0, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            movieListViewModel?.resetMovies()
            self.searchterm = text
            initiateSearch(for: text)
        }
    }    
    
    @objc private func initiateSearch(for searchTerm: String) {
        
        if let url = Constant.MOVIE_search_URL(searchTerm).path {
            movieListViewModel?.initFetch(url: url + "&page=\(page)")
        }
    }
    
}


