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
    @IBOutlet weak var roleLabel: UILabel!
    
    var p:Person = Person()
    var formatter = DateFormatter()
    var personType:Int = -1
    var documentsFolderURL = documentsURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd/MM/yyyy"
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectorDetail")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let imagePath = documentsFolderURL.appendingPathComponent(p.Name + ".jpg").path
        photoUIImageView.image = UIImage(contentsOfFile: imagePath)
        photoUIImageView.contentMode = .scaleAspectFit
        nameLabel.text = p.Name
        bdayLabel.text = p.Birthday
        switch personType {
        case 1:
            roleLabel.text = "Filmografía como director:"
        case 2:
            roleLabel.text = "Filmografía como actor:"
        default:
            print("This shouldn't happen")
        }
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
            //Director
            p = DirectorsList.shared.filter {$0.Name == person}[0]
            personType = 1
            break
        case 2:
            //Actor
            p = ActorsList.shared.filter {$0.Name == person}[0]
            personType = 2
            break
        default:
            print("Unidentified type for Person")
            print("This shouldn't happen")
            break
        }
        
    }
}
