//
//  FavoritesViewController.swift
//  NASA-NeoWs
//
//  Created by Apple on 25/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UITableViewController {
    private var dataSource: CommonListDataSource<CoreDataAsteriod, AsteriodTableViewCell>!
    private var fetchRequest: NSFetchRequest<CoreDataAsteriod>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequest = CoreDataAsteriod.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "saveDate", ascending: true)]
        dataSource = CommonListDataSource(tableView: tableView, viewContext: DataController.shared.viewContext, fetchRequest: fetchRequest, configureCell: { (cell, coreDataAsteriod) in
            cell.bindData(coreDataAsteriod)
        })
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.asteriod = (sender as! Asteriod).toCoreDataAsteriod()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: dataSource.object(at: indexPath))
    }
}
