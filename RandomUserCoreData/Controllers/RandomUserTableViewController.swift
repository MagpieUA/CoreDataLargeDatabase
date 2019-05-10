//
//  RandomUserTableViewController.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/12/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import UIKit
import CoreData

class RandomUserTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var spinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        self.navigationController?.view.addSubview(indicator)
        indicator.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        return indicator
    }()
    
    let numberOfUsers = 5000        // maximum 5000 due to randomuser.me limitations

    var users: [CDLDUserViewModel] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        tableView.tableFooterView = UIView()
    }

    // MARK: - Networking
    
    func refreshUsers() {
        guard let randomUserUrl = URL(string: "https://randomuser.me/api/?results=\(numberOfUsers)") else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        spinner.startAnimating()
        
        URLSession.shared.dataTask(with: randomUserUrl) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self?.spinner.stopAnimating()
            }
            
            guard let data = data else { return }
            self?.clearStorage()
            self?.cacheData(data: data)
        }.resume()
    }
    
    // MARK: - Cache
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CDLD")
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error \(error), \(error.userInfo)")
        })

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.userInfo)")
        }
        return fetchedResultsController
    }()
    
    func cacheData(data: Data) {
        persistentContainer.performBackgroundTask { (context) in
            guard let userInfoKey = CodingUserInfoKey(rawValue: "context") else { return }
            let decoder = JSONDecoder()
            decoder.userInfo[userInfoKey] = context
            context.perform {
                do {
                    _ = try decoder.decode(CDLDResults.self, from: data)
                    try context.save()
                } catch let error {
                    print (error.localizedDescription)
                }
            }
        }
    }
    
    func clearStorage() {
        let mainContext = persistentContainer.viewContext
        persistentContainer.performBackgroundTask { (context) in
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            do {
                let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
                guard let objectIDs = result?.result as? [NSManagedObjectID] else { return }
                let changes = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [mainContext])
            } catch {
                fatalError("Failed to execute request: \(error)")
            }
        }
    }

    // MARK: - UITableViewDatasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as RandomUserTableViewCell
        let user = fetchedResultsController.object(at: indexPath)
        let userViewModel = CDLDUserViewModel(user: user)
        cell.configureWithUserViewModel(user: userViewModel)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? RandomUserTableViewCell else { return }
        let indexPath = tableView.indexPath(for: cell)
        if let destinationController = segue.destination as? CDLDUserDetailsViewController, let indexPath = indexPath {
            let userViewModel = CDLDUserViewModel(user: fetchedResultsController.object(at: indexPath))
            destinationController.user = userViewModel
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        default:
            return
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Actions
    
    @IBAction func refresh(_ sender: Any) {
        refreshUsers()
    }
}
