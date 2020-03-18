//
//  ViewController.swift
//  NASA-NeoWs
//
//  Created by Ramiz on 15/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var asteriods: Asteriods? = nil
    var sectionIndexToDateMapping: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadFeed()
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func loadFeed() {
        activityIndicator.startAnimating()
        NASAAPIClient.getAsteriodFeed(successHandler: { asteriods in
            self.asteriods = asteriods
            self.mapSections()
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }) { error in
            self.showErrorAlert(message: error.localizedDescription)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func mapSections() {
        guard let asteriodsList = self.asteriods?.nearEarthObjects else {
            sectionIndexToDateMapping = []
            return
        }
        
        sectionIndexToDateMapping = []
        for asteriod in asteriodsList {
            sectionIndexToDateMapping.append(asteriod.key)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let asteriodsList = self.asteriods?.nearEarthObjects else {
            return 0
        }
        
        return asteriodsList[sectionIndexToDateMapping[section]]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return asteriods?.nearEarthObjects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        let row = rowAt(indexPath)
        tableViewCell.title.text = "\(row.name), \(row.neoReferenceId)"
        tableViewCell.subtitle.text = "Absolute Magnitude: \(row.absoluteMagnitude), Orbiting Body: \(row.closeApproachData[0].orbitingBody)"
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionIndexToDateMapping[section]
    }
    
    private func rowAt(_ indexPath: IndexPath) -> Asteriod {
        let sectionKey = sectionIndexToDateMapping[indexPath.section]
        return asteriods!.nearEarthObjects[sectionKey]![indexPath.row]
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
