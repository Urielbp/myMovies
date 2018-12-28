//
//  PeliculaDetailViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

class PeliculaDetailViewControl: UIViewController, UITableViewDataSource {
    //Model
    var m:Movie = Movie()
    
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var directorsTable: UITableView!
    @IBOutlet weak var castTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directorsTable.dataSource = self
        castTable.dataSource = self
        
        directorsTable.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovieDetail1")
        castTable.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovieDetail2")
        //actorsTable name changed, may get errors
        //TODO: set delegate for both tables
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = m.Title
        yearLabel.text = "Año: " + String(m.Year)
        runtimeLabel.text = "Duración: " + String(m.Runtime) + " minutos"
        for c in m.Countries {
            countriesLabel.text?.append(contentsOf: c)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView.isEqual(self.directorsTable)){
            return self.m.Directors.count
        }
        else if (tableView.isEqual(self.castTable)){
            return self.m.Cast.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView.isEqual(self.directorsTable)){
            if let cell = directorsTable.dequeueReusableCell(withIdentifier: "reuseMovieDetail1") {
                cell.textLabel?.text = m.Directors[indexPath.row]
                return cell
            }
            else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Nothing to show"
                return cell
            }
            
        }
        else if (tableView.isEqual(self.castTable)){
            if let cell = castTable.dequeueReusableCell(withIdentifier: "reuseMovieDetail2") {
                cell.textLabel?.text = m.Cast[indexPath.row]
                return cell
            }
            else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Nothing to show"
                return cell
            }
            
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
}
