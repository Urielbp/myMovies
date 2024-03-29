//
//  PeliculaDetailViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class PeliculaDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //Model
    var m:Movie = Movie()
    var documentsFolderURL = documentsURL()
    
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var countriesLabel: UILabel!
    @IBOutlet weak var directorsTable: UITableView!
    @IBOutlet weak var castTable: UITableView!
    @IBOutlet weak var trailerImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directorsTable.dataSource = self
        castTable.dataSource = self
        directorsTable.delegate = self
        castTable.delegate = self
        directorsTable.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovieDetail1")
        castTable.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovieDetail2")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = m.Title
        yearLabel.text = "Año: " + String(m.Year)
        runtimeLabel.text = "Duración: " + String(m.Runtime) + " minutos"
        countriesLabel.text = "Países: "
        for c in m.Countries {
            countriesLabel.text?.append(contentsOf: c)
        }
        
        let imagePath = documentsFolderURL.appendingPathComponent(m.Title + "__trailer.png").path
        trailerImage.image = UIImage(contentsOfFile: imagePath)
        trailerImage.contentMode = .scaleAspectFit        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.castTable:
            performSegue(withIdentifier: "actorDetailToPersonDetail", sender: self)
            break
        case self.directorsTable:
            performSegue(withIdentifier: "directorDetailToPersonDetail", sender: self)
            break
        default:
            print("Wrong table selected")
            print("This shouldn't happen")
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView = segue.destination as! PersonDetailViewController
        
        switch segue.identifier {
        case "directorDetailToPersonDetail":
            if let rowIndex = directorsTable.indexPathForSelectedRow?.row {
                detailView.prepareForOutsideDetailView(forPerson: self.m.Directors[rowIndex], whichIs: 1)
            }
            break
        case "actorDetailToPersonDetail":
            if let rowIndex = castTable.indexPathForSelectedRow?.row {
                detailView.prepareForOutsideDetailView(forPerson: self.m.Cast[rowIndex], whichIs: 2)
            }
            break
        default:
            print("Wrong segue identifier")
            print("This shouldn't happen")
            break
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
    
    public func prepareForOutsideDetailView(forMovie movie:String) {
        m = MoviesList.shared.filter {$0.Title == movie}[0]
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch :UITouch? = touches.first
        if (touch?.view == trailerImage){
            if let videoURL = URL(string: m.Trailer){
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                present(playerViewController, animated: true, completion: {playerViewController.player?.play()})
            }
        }
        super.touchesEnded(touches, with: event)
    }
    
}
