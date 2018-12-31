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
        
        //If local files are not available
        let localFiles = listOfSandboxFilesIn(directory: documentsFolderURL, withExtension: "json")
        if (localFiles.filter {$0.lastPathComponent == "movies.json"}.count != 0) {
            //We have local movies.json, load the local files
            print("We have local movies.json")
            let localMoviesJsonURL = documentsFolderURL.appendingPathComponent("movies.json")
            //Parsing movies.json
            if let moviesJsonData = fm.contents(atPath: localMoviesJsonURL.path) {
                do {
                    let moviesData = try decoder.decode([Movie].self, from: moviesJsonData)
                    for m in moviesData {
                        movies.append(m)
                    }
                }
                catch {
                    //TODO: NotifyUser all over
                    print ("Error decoding JSON file " + localMoviesJsonURL.absoluteString)
                    print (error)
                }
            }
            MoviesList.shared = movies
        } else {
            //We don't have local movie.json, load from the remote URL
            let remoteMoviesURL = URL(string: "http://192.168.0.23:3000/movies")
            print("We don't have movies.json")
            do {
                let moviesRemoteData = try Data(contentsOf: remoteMoviesURL!)
                do {
                    let moviesData = try decoder.decode([Movie].self, from: moviesRemoteData)
                    for m in moviesData {
                        movies.append(m)
                    }
                }
                catch {
                    print ("Error decoding JSON file " + (remoteMoviesURL?.absoluteString)!)
                    print (error)
                }
            }
            catch {
                print("Errors parsing remote movies JSON file")
                print(error)
            }
            MoviesList.shared = movies
        }
        

        
        
        
        
        
        let actorsJsonURL = documentsFolderURL.appendingPathComponent("actors.json")
        let directorsJsonURL = documentsFolderURL.appendingPathComponent("directors.json")
        
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
