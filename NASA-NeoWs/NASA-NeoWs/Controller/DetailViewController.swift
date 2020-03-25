//
//  DetailViewController.swift
//  NASA-NeoWs
//
//  Created by Apple on 19/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var asteriod: CoreDataAsteriod!
    @IBOutlet weak var primaryDataText: UITextView!
    @IBOutlet weak var secondaryDataTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = asteriod.name
        // Do any additional setup after loading the view.
        primaryDataText.attributedText = asteriod.primaryDataAttributedString
        primaryDataText.isEditable = false
      
        secondaryDataTextView.attributedText = asteriod.secondaryDataAttributedString
        secondaryDataTextView.isEditable = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
