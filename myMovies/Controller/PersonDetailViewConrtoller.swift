//
//  PersonDetailViewConrtoller.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 28/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailViewConrtoller : UIViewController, UITableViewDataSource {
    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bdayLabel: UILabel!
    @IBOutlet weak var photoUIImageView: UIImageView!
    @IBOutlet weak var table: UITableView!
    
    var p:Person = Person()
    var formatter = DateFormatter()
    var personType:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd/MM/yyyy"
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectorDetail")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = p.Name
        bdayLabel.text = formatter.string(from: p.Birthday)
        photoUIImageView.image = UIImage(named: p.Photo)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch personType {
        case 1:
            if let count = p.MoviesAsDirector?.count{
                return count
            }
            else {
                return 0
            }
        case 2:
            if let count = p.MoviesAsActor?.count{
                return count
            }
            else {
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch personType {
        case 1:
            if let cell = table.dequeueReusableCell(withIdentifier: "reuseDirectorDetail") {
                cell.textLabel?.text = p.MoviesAsDirector?[indexPath.row]
                return cell
            }
            else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Nothing to show"
                return cell
            }
        case 2:
            if let cell = table.dequeueReusableCell(withIdentifier: "reuseDirectorDetail") {
                cell.textLabel?.text = p.MoviesAsActor?[indexPath.row]
                return cell
            }
            else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Nothing to show"
                return cell
            }
        default:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
}
