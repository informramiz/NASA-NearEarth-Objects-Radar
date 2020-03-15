//
//  ViewController.swift
//  NASA-NeoWs
//
//  Created by Apple on 15/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

