//
//  ActoresViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

class ActoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlet
    @IBOutlet weak var table: UITableView!
    var actors:[Person] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "reuseActors") {
            cell.textLabel?.text = actors[indexPath.row].Name
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "actorsDetailSegue") {
            let detailView = segue.destination as! PersonDetailViewController
            detailView.personType = 2
            if let rowIndex = self.table.indexPathForSelectedRow {
                detailView.p = actors[rowIndex.row]
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "actorsDetailSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseActors")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let fm = FileManager.default
        let documentsFolderURL = documentsURL()
        //var filesList = listOfSandboxFilesIn(directory: documentsURL, withExtension: "json")
        //TODO: Check if files are in local Documents.
        //TODO: Move to Main controller
        let jsonURL = documentsFolderURL.appendingPathComponent("actors.json")
        let decoder = JSONDecoder()
        if let jsonData = fm.contents(atPath: jsonURL.path) {
            do {
                let actorsData = try decoder.decode([Person].self, from: jsonData)
                for a in actorsData {
                    actors.append(a)
                }
            }
            catch {
                print ("Error decoding JSON file " + jsonURL.absoluteString)
                print (error)
            }
        }
        ActorsList.shared = actors
    }
    
    
}
