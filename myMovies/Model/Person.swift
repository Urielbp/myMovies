//
//  Actor.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 23/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

struct Person : Codable {
    var Name:String = ""
    var Birthday:String = ""
    var Photo:String = ""
    var Movies:[String] = []
}

//MARK: Ordering functions
func orderPersonByName(a: Person, b: Person) -> Bool {
    return (a.Name < b.Name)
}

func orderPersonByBirthYear(a: Person, b: Person) -> Bool {
    let aBirthYear = a.Birthday.components(separatedBy: "/")
    let bBirthYear = b.Birthday.components(separatedBy: "/")
    return (aBirthYear.last! < bBirthYear.last!)
}
