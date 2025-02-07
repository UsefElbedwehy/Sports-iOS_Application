//
//  Service.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
protocol ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,compilationHandler: @escaping (Leagues?,Error?)->Void)
    static func fetchFixturesFromModel(leagueIndex:Int,exten:[String],compilationHandler: @escaping (Fixtures?,Error?)->Void)
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,compilationHandler: @escaping (Teams?,Error?)->Void)
}
class Service : ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,compilationHandler: @escaping(Leagues?,Error?) -> Void) {
        let url = URL(string: ApiKeys.createApiUrl(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Leagues))
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil,error)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil,error.unsafelyUnwrapped)
                return
            }
            do{
                let result = try JSONDecoder().decode(Leagues.self, from: data)
                compilationHandler(result,nil)
            }catch let error {
                print("------------------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    static func fetchFixturesFromModel(leagueIndex:Int ,exten:[String],compilationHandler: @escaping(Fixtures?,Error?) -> Void) {
        let url = URL(string: ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Fixtures, exten: exten))
        print(url ?? "url")
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil,error)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil,error)
                return
            }
//            // Debug: Print the raw JSON response
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON response: \(jsonString)")
//            }
            do{
                let result = try JSONDecoder().decode(Fixtures.self, from: data)
                compilationHandler(result,nil)
            }catch let error {
                print("----------XX-------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,compilationHandler: @escaping(Teams?,Error?) -> Void) {
        let url = URL(string: ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Teams, exten: ["leagueId=\(exten)"]))
        print(url ?? "url")
        guard let url = url else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                compilationHandler(nil,error)
                return
            }
            guard let data = data else {
                print("No data received from server.")
                compilationHandler(nil,error)
                return
            }     
            do{
                let result = try JSONDecoder().decode(Teams.self, from: data)
                compilationHandler(result,nil)
            }catch let error {
                print("--------XXX--------------")
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
