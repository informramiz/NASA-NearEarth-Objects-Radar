//
//  CommonListDataSource.swift
//  NASA-NeoWs
//
//  Created by Ramiz on 07/12/2019.
//
import Foundation
import CoreData
import UIKit

class CommonListDataSource<EntityType: NSManagedObject, CellType: UITableViewCell>: NSObject, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    private let tableView: UITableView
    private let viewContext: NSManagedObjectContext
    private let configureCell: (CellType, EntityType) -> Void
    private let fetchedResultsController: NSFetchedResultsController<EntityType>
    private let cellIdentifier = String(describing: CellType.self)
    var onContentUpdated: (() -> Void)? = nil
    
    var numberOfSections: Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    var isEditingPossible: Bool {
        return numberOfRowsIn(section: 0) > 0
    }
    
    init(tableView: UITableView, viewContext: NSManagedObjectContext, fetchRequest: NSFetchRequest<EntityType>,
         configureCell: @escaping (CellType, EntityType) -> Void) {
        self.tableView = tableView
        self.viewContext = viewContext
        self.configureCell = configureCell
        fetchedResultsController = NSFetchedResultsController<EntityType>(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
    }
    
    func loadData() {
        tableView.dataSource = self
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsIn(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CellType
        let model = fetchedResultsController.object(at: indexPath)
        configureCell(cell, model)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       switch editingStyle {
       case .delete: deleteItem(at: indexPath)
       default: () // Unsupported
       }
   }
    
    /// Deletes the item at the specified index path
    func deleteItem(at indexPath: IndexPath) {
        //delete from core data first
        let itemToDelete = object(at: indexPath)
        viewContext.delete(itemToDelete)
        try? viewContext.save()
        
        if !isEditingPossible {
            tableView.setEditing(isEditingPossible, animated: true)
        }
    }
    
    // MARK: - NSFetchedResultsController delegate methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        onContentUpdated?()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case.move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .fade)
        case .delete:
            tableView.deleteSections(indexSet, with: .fade)
        case .update:
            tableView.reloadSections(indexSet, with: .fade)
        default:
            tableView.reloadData()
        }
    }
    
    // MARK: Utility methods
    func numberOfRowsIn(section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func object(at indexPath: IndexPath) -> EntityType {
        return fetchedResultsController.object(at: indexPath)
    }
}

