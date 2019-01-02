//
//  TabController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 30/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class TabController: UITabBarController {
    
    var movies:[Movie] = []
    var actors:[Person] = []
    var directors:[Person] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let documentsFolderURL = documentsURL()
        let decoder = JSONDecoder()
        
        //Getting list of local json files
        let localFiles = listOfSandboxFilesIn(directory: documentsFolderURL, withExtension: "*")
        
        //Movies
        if (localFiles.filter {$0.lastPathComponent == "movies.json"}.count != 0) {
            //We have local json, load the local files
            //print("DEBUG>>We have local movie.json")
            let localMoviesJsonURL = documentsFolderURL.appendingPathComponent("movies.json")
            if let moviesJsonData = fm.contents(atPath: localMoviesJsonURL.path) {
                do {
                    let moviesData = try decoder.decode([Movie].self, from: moviesJsonData)
                    for m in moviesData {
                        movies.append(m)
                    }
                }
                catch {
                    print ("Error decoding JSON file " + localMoviesJsonURL.absoluteString)
                    print (error)
                }
            }
            MoviesList.shared = movies
        } else {
            //We don't have local json, load from the remote URL
            //print("DEBUG>>We don't have local movie.json")
            let remoteMoviesURL = URL(string: "http://192.168.0.23:3000/movies")
            do {
                let moviesRemoteData = try Data(contentsOf: remoteMoviesURL!)
                do {
                    let moviesData = try decoder.decode([Movie].self, from: moviesRemoteData)
                    for m in moviesData {
                        movies.append(m)
                        let thumbnailIsLocal =  localFiles.filter {m.Title + "__trailer" == $0.lastPathComponent.components(separatedBy: ".")[0]}
                        if (thumbnailIsLocal.count == 0) {
                            //Download thumbanail
                            DispatchQueue.global().async {
                                let localURL = documentsFolderURL.appendingPathComponent(m.Title + "__trailer.png")
                                if let videoURL = URL(string: m.Trailer) {
                                    let asset = AVURLAsset(url: videoURL)
                                    let imageGenerator = AVAssetImageGenerator(asset: asset)
                                    do {
                                        let thumbnail = try imageGenerator.copyCGImage(at: CMTimeMakeWithSeconds(10, preferredTimescale: 24), actualTime: nil)
                                        let thumbUIImage = UIImage(cgImage: thumbnail)
                                        if let imageData = thumbUIImage.jpegData(compressionQuality: 1.0){
                                            try imageData.write(to: localURL)
                                        }
                                    }
                                    catch {
                                        print("Error getting thumbnail")
                                        print(error)
                                    }
                                }
                            }
                        }
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
        
        //Actors
        if (localFiles.filter {$0.lastPathComponent == "actors.json"}.count != 0){
            //We have local json, load the local files
            //print("DEBUG>>We have local actors.json")
            let actorsJsonURL = documentsFolderURL.appendingPathComponent("actors.json")
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
        } else {
            //We don't have local json, load from the remote URL
            //print("DEBUG>>We don't have local actors.json")
            let remoteActorsURL = URL(string: "http://192.168.0.23:3000/actors")
            do {
                let actorsRemoteData = try Data(contentsOf: remoteActorsURL!)
                do {
                    let actorsData = try decoder.decode([Person].self, from: actorsRemoteData)
                    for p in actorsData {
                        actors.append(p)
                        let photoIsLocal =  localFiles.filter {p.Name == $0.lastPathComponent.components(separatedBy: ".")[0]}
                        if (photoIsLocal.count == 0) {
                            //Download image file
                            DispatchQueue.global().async {
                                let localURL = documentsFolderURL.appendingPathComponent(p.Name + ".jpg")
                                do {
                                    let imageData = try Data(contentsOf: URL(string: p.Photo)!)
                                    try imageData.write(to: localURL)
                                }
                                catch {
                                    print("Could not download \(p.Photo) photo")
                                    print(error)
                                }
                                
                            }
                        }
                    }
                }
                catch {
                    print ("Error decoding JSON file " + (remoteActorsURL?.absoluteString)!)
                    print (error)
                }
            }
            catch {
                print("Errors parsing remote movies JSON file")
                print(error)
            }
            ActorsList.shared = actors
        }
        
        
        //Directors
        if (localFiles.filter {$0.lastPathComponent == "directors.json"}.count != 0){
            //We have local json, load the local files
            //print("DEBUG>>We have local directors.json")
            let directorsJsonURL = documentsFolderURL.appendingPathComponent("directors.json")
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
        } else {
            //We don't have local json, load from the remote URL
            //print("DEBUG>>We don't have local directors.json")
            let remoteDirectorsURL = URL(string: "http://192.168.0.23:3000/directors")
            do {
                let directorsRemoteData = try Data(contentsOf: remoteDirectorsURL!)
                do {
                    let directorsData = try decoder.decode([Person].self, from: directorsRemoteData)
                    for p in directorsData {
                        directors.append(p)
                        let photoIsLocal =  localFiles.filter {p.Name == $0.lastPathComponent.components(separatedBy: ".")[0]}
                        if (photoIsLocal.count == 0) {
                            //Download image file
                            DispatchQueue.global().async {
                                let localURL = documentsFolderURL.appendingPathComponent(p.Name + ".jpg")
                                do {
                                    let imageData = try Data(contentsOf: URL(string: p.Photo)!)
                                    try imageData.write(to: localURL)
                                }
                                catch {
                                    print("Could not download \(p.Name) photo")
                                    print(error)
                                }
                                
                            }
                        }
                    }
                }
                catch {
                    print ("Error decoding JSON file " + (remoteDirectorsURL?.absoluteString)!)
                    print (error)
                }
            }
            catch {
                print("Errors parsing remote movies JSON file")
                print(error)
            }
            DirectorsList.shared = directors
        }
    }
}
