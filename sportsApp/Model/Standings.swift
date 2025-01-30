//
//  Standings.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
class Standings : Decodable {
    var success: Int?
    var result:[Standing]?
}

class Standing : Decodable {
    var standing_place: Int?
    var standing_place_type: String?
    var standing_team: String?
    var standing_P: Int?
    var standing_W: Int?
    var standing_D: Int?
    var standing_L: Int?
    var standing_F: Int?
    var standing_A: Int?
    var standing_GD: Int?
    var standing_PTS:Int?
    var team_key: Int?
    var league_key: Int?
    var league_season: String?
    var league_round: String?
}
