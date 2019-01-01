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
}

//MARK: Ordering functions
func orderMovieByTitle(a: Movie, b: Movie) -> Bool {
    return (a.Title < b.Title)
}

func orderMovieByYear(a: Movie, b: Movie) -> Bool {
    return (a.Year < b.Year)
}

func orderMovieByDirector(a: Movie, b: Movie) -> Bool {
    return (a.Directors[0] < b.Directors[0])
}

func orderMovieByCountry(a: Movie, b: Movie) -> Bool {
    return (a.Countries[0] < b.Countries[0])
}

