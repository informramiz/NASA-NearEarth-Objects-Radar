//
//  ViewController.swift
//  NASA-NeoWs
//
//  Created by Ramiz on 15/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadFeed()
    }

    private func loadFeed() {
        NASAAPIClient.getAsteriodFeed(successHandler: { asteriods in
            print(asteriods)
        }) { error in
            print(error)
        }
    }
}

