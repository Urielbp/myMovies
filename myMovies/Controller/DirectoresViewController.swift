//
//  SecondViewController.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 27/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import UIKit

class DirectoresViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    //Outlets
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var orderByPickerView: UIPickerView!
    var directors:[Person] = []
    let pickerViewOptions:[String] = ["Nombre", "Año de nacimiento"]
    
    //Mark: UIPickerView
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
            directors.sort(by: Person.sortByName)
            table.reloadData()
            break
        case 1:
            directors.sort(by: Person.sortByBirthYear)
            table.reloadData()
            break
        default:
            print("This shouldn't happen")
        }
    }

    
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
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "reuseDirectors")
        orderByPickerView.dataSource = self
        orderByPickerView.delegate = self
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        directors = DirectorsList.shared
        //By default, sorted by names
        directors.sort(by: Person.sortByName)
    }


}

