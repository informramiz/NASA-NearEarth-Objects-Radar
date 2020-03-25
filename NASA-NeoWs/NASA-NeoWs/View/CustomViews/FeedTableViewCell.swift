//
//  FeedTableViewCell.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func bindData(_ asteriod: Asteriod) {
        title.text = "\(asteriod.name), \(asteriod.neoReferenceId)"
        subtitle.text = "Absolute Magnitude: \(asteriod.absoluteMagnitude), Diameter: \(asteriod.estimatedDiameter.toString())"
    }
}
