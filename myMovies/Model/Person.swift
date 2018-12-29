//
//  Actor.swift
//  myMovies
//
//  Created by Uriel Pinheiro on 23/12/2018.
//  Copyright © 2018 Uriel Pinheiro. All rights reserved.
//

import Foundation
import UIKit

//struct Person {
//    var Name:String
//    var Birthday:Date
//    var Photo:UIImage
//    var MoviesAsDirector:[Movie]?
//    var MoviesAsActor:[Movie]?
//}

struct Person : Codable {
    var Name:String = ""
    var Birthday:String = ""
    var Photo:String = ""
    var Movies:[String] = []
}
