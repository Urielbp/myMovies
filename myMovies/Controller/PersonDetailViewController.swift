//
//  PersonDetailViewConrtoller.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 28/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailViewController : UIViewController, UITableViewDataSource , UITableViewDelegate{
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
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectorDetail")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = p.Name
        bdayLabel.text = p.Birthday
        photoUIImageView.image = UIImage(named: p.Name + ".jpg")
        //TODO: Download the file in the p.Photo URL if the local file doesn't exist
        photoUIImageView.contentMode = .scaleAspectFit
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "personDetailToMovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "personDetailToMovieDetail") {
            let detailView = segue.destination as! PeliculaDetailViewController
            if let rowIndex = table.indexPathForSelectedRow?.row {
                detailView.prepareForOutsideDetailView(forMovie: self.p.Movies[rowIndex])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return p.Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "reuseDirectorDetail") {
            cell.textLabel?.text = p.Movies[indexPath.row]
            return cell
        }
        else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Nothing to show"
            return cell
        }
    }
    
    public func prepareForOutsideDetailView(forPerson person: String, whichIs type: Int) {
        switch type {
        case 1:
            //Actor
            p = ActorsList.shared.filter {$0.Name == person}[0]
            break
        case 2:
            //Director
            p = DirectorsList.shared.filter {$0.Name == person}[0]
            break
        default:
            print("Unidentified type for Person")
            print("This shouldn't happen")
            break
        }
        
    }
}
