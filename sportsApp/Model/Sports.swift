//
//  Sports.swift
//  sportsApp
//
//  Created by Usef on 27/01/2025.
//

import Foundation
class footballAPIs {
    static let apiKey = "1bdf9ca0bb2950913f68e460c14c228d8775b1266523146f4c14f76ea04b5678"
    static let footballUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&\(apiKey)=!\(apiKey))!"
}

let leagues = ["Football","Basketball"
               ,"Cricket","Tennis"]

class Sports : Decodable {
    
}

class Leagues : Decodable  {
    
}
class H2H : Decodable  {
    
}
class Teams : Decodable  {
    
}
class Players : Decodable  {
    
}

class FootballLeague: Decodable {
    var league:Leagues?
    var headToHead:H2H?
    var teams:Teams?
    var players:Players?
}

class BasketballLeague: Decodable {
    
}

class CricketLeague: Decodable {
    
}

class TennisballLeague: Decodable {
    
}
