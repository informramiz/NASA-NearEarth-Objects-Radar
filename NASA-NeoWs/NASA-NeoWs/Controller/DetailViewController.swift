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
        toggleFavoriteButton(isColored: asteriod.isAlreadySaved)
    }
    
    @IBAction func onFavoriteButtonClick(_ sender: Any) {
        if favoriteButtonItem.tintColor == UIColor.primaryDark {
            toggleFavoriteButton(isColored: false)
            deleteAsteriod()
        } else {
            toggleFavoriteButton(isColored: true)
            saveAsteriodLocally()
        }
    }
    
    private func deleteAsteriod() {
        do {
            DataController.shared.viewContext.delete(asteriod)
            try DataController.shared.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func saveAsteriodLocally() {
        do {
            try DataController.shared.viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func toggleFavoriteButton(isColored: Bool) {
        if isColored {
            favoriteButtonItem.tintColor = UIColor.primaryDark
        } else {
            favoriteButtonItem.tintColor = UIColor.gray
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        asteriod = nil
        DataController.shared.viewContext.reset()
    }
}
