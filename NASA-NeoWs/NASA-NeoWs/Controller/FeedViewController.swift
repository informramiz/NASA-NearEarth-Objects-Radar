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
    var asteriods: Asteriods? = nil
    var sectionIndexToDateMapping: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadFeed()
        tableView.dataSource = self
    }

    private func loadFeed() {
        NASAAPIClient.getAsteriodFeed(successHandler: { asteriods in
            self.asteriods = asteriods
            self.mapSections()
            self.tableView.reloadData()
        }) { error in
            self.showErrorAlert(message: error.localizedDescription)
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
        
        return tableViewCell
    }
}

