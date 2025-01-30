//
//  Teams.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
class Teams: Decodable {
    var success: Int?
    var result:[Team]?
}
class Team : Decodable {
    var team_key: Int?
    var  team_name: String?
    var team_logo: String?
    var players : [Players]?
}
