//
//  Leagues.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
class Leagues : Decodable {
    var success: Int?
    var result:[League]?
}
class League : Decodable {
    var league_key:Int?
    var league_name:String?
    var country_key:Int?
    var country_name:String?
    var league_logo:String?
    var country_logo:String?
}
