//
//  Service.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
protocol ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,compilationHandler: @escaping (Leagues?)->Void)
    static func fetchFixturesFromModel(leagueIndex:Int,exten:[String],compilationHandler: @escaping (Fixtures?)->Void)
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,compilationHandler: @escaping (Teams?)->Void)
}
class Service : ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,compilationHandler: @escaping(Leagues?) -> Void) {
        let url = URL(string: ApiKeys.createApiUrl(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Leagues))
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(Leagues.self, from: data)
                compilationHandler(result)
            }catch let error {
                print("------------------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    static func fetchFixturesFromModel(leagueIndex:Int ,exten:[String],compilationHandler: @escaping(Fixtures?) -> Void) {
//        let url = URL(string: "https://apiv2.allsportsapi.com/\(leagueIndex)/?met=Fixtures&APIkey=1bdf9ca0bb2950913f68e460c14c228d8775b1266523146f4c14f76ea04b5678&from=2025-01-25&to=2025-02-25&leagueId=\(exten)")
        let url = URL(string: ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Fixtures, exten: exten))
        print(url ?? "url")
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil)
                return
            }
            // Debug: Print the raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
            }
            do{
                let result = try JSONDecoder().decode(Fixtures.self, from: data)
                compilationHandler(result)
            }catch let error {
                print("----------XX-------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,compilationHandler: @escaping(Teams?) -> Void) {
//        let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&APIkey=1bdf9ca0bb2950913f68e460c14c228d8775b1266523146f4c14f76ea04b5678&leagueId=152")
        let url = URL(string: ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Teams, exten: ["leagueId=\(exten)"]))
        print(url ?? "url")
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil)
                return
            }
            // Debug: Print the raw JSON response
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }
                       
            do{
                let result = try JSONDecoder().decode(Teams.self, from: data)
                compilationHandler(result)
            }catch let error {
                print("--------XXX--------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
