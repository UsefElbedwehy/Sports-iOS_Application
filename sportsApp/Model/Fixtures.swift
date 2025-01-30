//
//  Fixtures.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
class Fixtures : Decodable {
    var success: Int?
    var result:[Fixture]?
}

class Fixture : Decodable{
       var event_key: Int?
       var event_date: String?
       var event_time: String?
       var event_home_team: String?
       var home_team_key: Int?
       var event_away_team: String?
       var away_team_key: Int?
//       var event_halftime_result: String?
//       var event_final_result: String?
//       var event_ft_result: String?
//       var event_penalty_result: String?
//       var event_status: String?
//       var country_name: String?
       var league_name: String?
       var league_key: Int?
//       var league_round: String?
//       var league_season: String?
//       var event_live: Int?
//       var event_stadium: String?
//       var event_referee: String?
       var home_team_logo: String?
       var away_team_logo: String?
//       var event_country_key: Int?
//       var league_logo: String?
//       var country_logo: String?
//       var event_home_formation: String?
//       var event_away_formation: String?
//       var fk_stage_key: Int?
//       var stage_name: String?
//       var league_group: String?
}
