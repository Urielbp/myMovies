//
//  FirstViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

class PeliculasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    var movies:[Movie] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "reuseMovie") {
            cell.textLabel?.text = movies[indexPath.row].Title
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "peliculaDetailSegue") {
            let detailView = segue.destination as! PeliculaDetailViewController
            if let rowIndex = self.table.indexPathForSelectedRow {
                detailView.m = movies[rowIndex.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "peliculaDetailSegue", sender: self)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("PeliculasViewController loaded")
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovie")
        movies = MoviesList.shared
//        var m = Movie()
//        m.Title = "Shrek"
//        movies.append(m)
//        let fm = FileManager.default
//
//        //String(contentsOf: URL)
//        //para descargar el contenido de la URL
//
//        let documentsFolderURL = documentsURL()
//        //var filesList = listOfSandboxFilesIn(directory: documentsURL, withExtension: "json")
//        //TODO: Check if files are in local Documents.
//        //TODO: Move to Main controller
//
//        //local
//        let jsonURL = documentsFolderURL.appendingPathComponent("movies.json")
//
//        //remote
////        let jsonURL = URL(string: "localhost:3000/movies.json")
//
////        do {
////            let jsonString = try String(contentsOf: jsonURL)
////            print (jsonString)
////        }
////        catch {
////            print ("Error decoding remote JSON file " + jsonURL.absoluteString)
////            print (error)
////        }
//        let decoder = JSONDecoder()
//        if let jsonData = fm.contents(atPath: jsonURL.path) {
//            do {
//                let moviesData = try decoder.decode([Movie].self, from: jsonData)
//                for m in moviesData {
//                    movies.append(m)
//                }
//            }
//            catch {
//                print ("Error decoding JSON file " + jsonURL.absoluteString)
//                print (error)
//            }
//        }
//        MoviesList.shared = movies
    }


}

