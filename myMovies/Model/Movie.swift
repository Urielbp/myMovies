//
//  Movie.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 23/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

struct Movie : Codable {
    var Title:String = ""
    var Year:Int = -1
    var Runtime:Int = -1
    var Countries:[String] = [""]
    var Directors:[String] = [""]
    var Cast:[String] = [""]
    var Trailer:String = ""
    
    //MARK: Ordering functions
    static func sortByTitle(a: Movie, b: Movie) -> Bool {
        return (a.Title < b.Title)
    }
    
    static func sortByYear(a: Movie, b: Movie) -> Bool {
        return (a.Year < b.Year)
    }
    
    static func sortByDirector(a: Movie, b: Movie) -> Bool {
        return (a.Directors[0] < b.Directors[0])
    }
    
    static func sortByCountry(a: Movie, b: Movie) -> Bool {
        return (a.Countries[0] < b.Countries[0])
    }
}



