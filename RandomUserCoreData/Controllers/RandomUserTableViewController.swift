//
//  RandomUserTableViewController.swift
//  RandomUserCoreData
//
//  Created by Mykhailo Sorokin on 4/12/19.
//  Copyright © 2019 Mykhailo Sorokin. All rights reserved.
//

import UIKit
import CoreData

class RandomUserTableViewController: UITableViewController {
    
    var users: [CDLDUser] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        guard let randomUserUrl = URL(string: "https://randomuser.me/api/?results=100") else { return }
        URLSession.shared.dataTask(with: randomUserUrl) { [weak self] (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let parsedData = try decoder.decode(CDLDResults.self, from: data)
                self?.users = parsedData.results ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print (error.localizedDescription)
            }
        }.resume()
        registerXibs()
    }
    
    func registerXibs() {
        tableView.registerNib(RandomUserTableViewCell.self)
    }
    
    // MARK: UITableViewDatasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(indexPath: indexPath) as RandomUserTableViewCell
        cell.configureWithUser(user: users[indexPath.row])
        return cell
    }
    
}
