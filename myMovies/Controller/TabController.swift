//
//  TabController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 30/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

class TabController: UITabBarController {
    
    var movies:[Movie] = []
    var actors:[Person] = []
    var directors:[Person] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let documentsFolderURL = documentsURL()
        let decoder = JSONDecoder()
        
        //Local files
        let moviesJsonURL = documentsFolderURL.appendingPathComponent("movies.json")
        let actorsJsonURL = documentsFolderURL.appendingPathComponent("actors.json")
        let directorsJsonURL = documentsFolderURL.appendingPathComponent("directors.json")
        
        
        //Parsing movies.json
        if let moviesJsonData = fm.contents(atPath: moviesJsonURL.path) {
            do {
                let moviesData = try decoder.decode([Movie].self, from: moviesJsonData)
                for m in moviesData {
                    movies.append(m)
                }
            }
            catch {
                print ("Error decoding JSON file " + moviesJsonURL.absoluteString)
                print (error)
            }
        }
        MoviesList.shared = movies
        
        //Parsing Actors.json
        if let actorsJsonData = fm.contents(atPath: actorsJsonURL.path) {
            do {
                let actorsData = try decoder.decode([Person].self, from: actorsJsonData)
                for p in actorsData {
                    actors.append(p)
                }
            }
            catch {
                print ("Error decoding JSON file " + actorsJsonURL.absoluteString)
                print (error)
            }
        }
        ActorsList.shared = actors
        
        //Parsing directors.json
        if let directorsJsonData = fm.contents(atPath: directorsJsonURL.path) {
            do {
                let diretorsData = try decoder.decode([Person].self, from: directorsJsonData)
                for p in diretorsData {
                    directors.append(p)
                }
            }
            catch {
                print ("Error decoding JSON file " + directorsJsonURL.absoluteString)
                print (error)
            }
        }
        DirectorsList.shared = directors
    }
}
