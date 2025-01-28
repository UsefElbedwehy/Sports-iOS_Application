//
//  FootBallSport.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import Foundation

class FootBallSport : Decodable {
    var result:[FootBallLeague]?
}
class FootBallLeague : Decodable {
    var league_key:String?
    var league_name:String?
    var country_name:String?
    var league_logo:String?
    var country_logo:String?
}
