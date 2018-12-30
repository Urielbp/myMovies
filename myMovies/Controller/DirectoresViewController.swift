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
            let detailView = segue.destination as! PersonDetailViewController
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
//        print("DirectoresViewController loaded")
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectors")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        directors = DirectorsList.shared
//        let fm = FileManager.default
        
        //String(contentsOf: URL)
        //para descargar el contenido de la URL
        
//        let documentsFolderURL = documentsURL()
//        //var filesList = listOfSandboxFilesIn(directory: documentsURL, withExtension: "json")
//        //TODO: Check if files are in local Documents.
//        //TODO: Move to Main controller
//        let jsonURL = documentsFolderURL.appendingPathComponent("directors.json")
//        let decoder = JSONDecoder()
//        if let jsonData = fm.contents(atPath: jsonURL.path) {
//            do {
//                let directorsData = try decoder.decode([Person].self, from: jsonData)
//                for d in directorsData {
//                    directors.append(d)
//                }
//            }
//            catch {
//                print ("Error decoding JSON file " + jsonURL.absoluteString)
//                print (error)
//            }
//        }
//        DirectorsList.shared = directors
    }


}

