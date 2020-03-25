//
//  SearchViewController.swift
//  NASA-NeoWs
//
//  Created by Apple on 25/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsFoundLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    var results: [Asteriod] = []
    var searchTask: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableview.dataSource = self
        tableview.delegate = self
        searchBar.delegate = self
    }
    
//    private func search() {
//        NASAAPIClient.search(neoReferenceId: "3542519", successHandler: { asteriods in
//            self.results = asteriods
//            self.tableview.reloadData()
//        }) { error in
//            print(error.localizedDescription)
//        }
//    }
    
    func setSearching(searching: Bool) {
        if searching {
            tableview.isHidden = true
            noResultsFoundLabel.isHidden = true
            results = []
            tableview.reloadData()
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            tableview.isHidden = results.isEmpty
            noResultsFoundLabel.isHidden = !results.isEmpty
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! AsteriodTableViewCell
        tableViewCell.bindData(results[0])
        return tableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.asteriod = (sender as! Asteriod).toCoreDataAsteriod()
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setSearching(searching: true)
        searchTask?.cancel()
        let id = Int64(searchText) ?? 123
        searchTask = NASAAPIClient.search(neoReferenceId: id, successHandler: { results in
            self.results = results
            self.tableview.reloadData()
            self.setSearching(searching: false)
        }) { error in
            self.setSearching(searching: false)
            print(error.localizedDescription)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: results[indexPath.row])
    }
}
