//
//  Movie.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 23/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

//struct Movie {
//    var Title:String
//    var Year:Int
//    var Runtime:Int
//    var Countries:[String]
//    var Director:[Person]?
//    var Cast:[Person]?
//    var Trailer:String?
//
//}

struct Movie {
    var Title:String = ""
    var Year:Int = -1
    var Runtime:Int = -1
    var Countries:[String] = [""]
    var Director:[String]? = [""]
    var Cast:[String]? = [""]
    var Trailer:String? = ""
    
}
