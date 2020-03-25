//
//  DetailViewController.swift
//  NASA-NeoWs
//
//  Created by Ramiz on 19/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var asteriod: CoreDataAsteriod!
    @IBOutlet weak var primaryDataText: UITextView!
    @IBOutlet weak var secondaryDataTextView: UITextView!
    @IBOutlet weak var favoriteButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = asteriod.name
        // Do any additional setup after loading the view.
        primaryDataText.attributedText = asteriod.primaryDataAttributedString
        primaryDataText.isEditable = false
      
        secondaryDataTextView.attributedText = asteriod.secondaryDataAttributedString
        secondaryDataTextView.isEditable = false
        toggleBarButton(favoriteButtonItem, isColored: asteriod.isAlreadySaved)
    }
    
    @IBAction func onFavoriteButtonClick(_ sender: Any) {
        saveOrDeleteAsteriodLocally()
    }
    
    private func saveOrDeleteAsteriodLocally() {
        toggleBarButton(favoriteButtonItem, isColored: !asteriod.isAlreadySaved)
        if asteriod.isAlreadySaved {
            DataController.shared.viewContext.delete(asteriod)
        } else {
            do {
                try DataController.shared.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func toggleBarButton(_ button: UIBarButtonItem, isColored: Bool) {
        if isColored {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
}
