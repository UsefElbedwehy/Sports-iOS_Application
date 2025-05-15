//
//  Service.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation
protocol ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,completionHandler: @escaping (Result<Leagues,ServiceErrors>)->Void)
    static func fetchFixturesFromModel(leagueIndex:Int,exten:[String],completionHandler: @escaping (Result<Fixtures,ServiceErrors>)->Void)
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,completionHandler: @escaping (Result<Teams,ServiceErrors>)->Void)
}
class Service : ApiProtocol {
    static func fetchLeaguesFromModel(leagueIndex:Int,completionHandler: @escaping(Result<Leagues,ServiceErrors>) -> Void) {
        fetchData(url: ApiKeys.createApiUrl(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Leagues), completion: completionHandler)
    }
    static func fetchFixturesFromModel(leagueIndex:Int ,exten:[String],completionHandler: @escaping (Result<Fixtures,ServiceErrors>) -> Void) {
       fetchData(url:  ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Fixtures, exten: exten), completion: completionHandler)
    }
    static func fetchTeamsFromModel(leagueIndex:Int,exten:String,completionHandler: @escaping (Result<Teams,ServiceErrors>) -> Void) {
        fetchData(url:  ApiKeys.createApiUrlWithExten(league: Sports.sports[leagueIndex] , parameter: ApiParameters().Teams, exten: ["leagueId=\(exten)"]) , completion: completionHandler)
    }
}

extension Service {
    static func fetchData<T: Decodable>(url: String,completion: @escaping (Result<T,ServiceErrors>) -> Void){
        guard let newUrl = URL(string: url) else {
            completion(.failure(.urlFailed))
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.customError(error.localizedDescription)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseData))
            }catch let error {
                completion(.failure(.decodingFailed(error.localizedDescription)))
            }
        }
        task.resume()
    }
}

