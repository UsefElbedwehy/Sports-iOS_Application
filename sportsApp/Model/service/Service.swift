//
//  Service.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
protocol ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,completionHandler: @escaping (Leagues?,Error?)->Void)
    static func fetchFixturesFromModel(leagueIndex:Int,exten:[String],completionHandler: @escaping (Fixtures?,Error?)->Void)
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,completionHandler: @escaping (Teams?,Error?)->Void)
}
class Service : ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,completionHandler: @escaping(Leagues?,Error?) -> Void) {
        fetchData(url: ApiKeys.createApiUrl(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Leagues), completion: completionHandler)
    }
    static func fetchFixturesFromModel(leagueIndex:Int ,exten:[String],completionHandler: @escaping(Fixtures?,Error?) -> Void) {
       fetchData(url:  ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Fixtures, exten: exten), completion: completionHandler)
    }
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,completionHandler: @escaping(Teams?,Error?) -> Void) {
        fetchData(url:  ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Teams, exten: ["leagueId=\(exten)"]) , completion: completionHandler)
    }
}

extension Service {
    static func fetchData<T: Decodable>(url: String,completion: @escaping (T?, Error?) -> Void){
        guard let newUrl = URL(string: url) else {
            completion(nil, NSError(domain: "Invalid URL", code: 1000, userInfo: nil))
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil,NSError(domain: "Invalid Data", code: 1021, userInfo: nil))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                completion(responseData, nil)
            }catch let error {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
}

