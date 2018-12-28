//
//  SecondViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

class DirectoresViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    //Outlets
    @IBOutlet weak var table: UITableView!
    var directors:[Person] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "reuseDirectors") {
            cell.textLabel?.text = directors[indexPath.row].Name
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "directorDetailSegue") {
            let detailView = segue.destination as! PersonDetailViewConrtoller
            detailView.personType = 1
            if let rowIndex = self.table.indexPathForSelectedRow {
                detailView.p = directors[rowIndex.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "directorDetailSegue", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectors")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let d = Person(Name: "Cameron Diaz", Birthday: formatter.date(from: "10/10/1910")!, Photo: "Cameron_Diaz.jpg", MoviesAsDirector: [""], MoviesAsActor: [""])
        directors.append(d)
    }


}

