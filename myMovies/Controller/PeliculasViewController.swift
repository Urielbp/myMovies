//
//  FirstViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

class PeliculasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    //Outlets and local variables
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var orderByPickerView: UIPickerView!
    var movies:[Movie] = []
    let pickerViewOptions:[String] = ["Título", "Año", "Dirección", "País"]
    
    
    //MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            movies.sort(by: Movie.sortByTitle)
            table.reloadData()
            break
        case 1:
            movies.sort(by: Movie.sortByYear)
            table.reloadData()
            break
        case 2:
            movies.sort(by: Movie.sortByDirector)
            table.reloadData()
            break
        case 3:
            movies.sort(by: Movie.sortByCountry)
            table.reloadData()
            break
        default:
            print("This shouldn't happen")
        }
    }
    
    //MARK: UITableView
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
    
    //MARK: Segue preparation
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
    

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseMovie")
        orderByPickerView.dataSource = self
        orderByPickerView.delegate = self
        movies = MoviesList.shared
        //By default, sorted by titles
        movies.sort(by: Movie.sortByTitle)
        //notifyUser(self, alertTitle: "Title", alertMessage: "Message", runOnOK: {_ in })
    }
    



}

