//
//  FakeNetwork.swift
//  sportsAppTests
//
//  Created by Usef on 05/02/2025.
//

import Foundation
@testable import sportsApp

class FakeNetwork {
    var shouldReturnError = false
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    enum ResponseWithError : Error {
    case responseError
    }
}
extension FakeNetwork {
    func fetchLeaguesFromModel(leagueIndex:Int,compilationHandler: @escaping (Leagues?,Error?)->Void){
        if shouldReturnError {
            compilationHandler(nil,ResponseWithError.responseError)
        }else{
            let leaguesArr = Leagues()
            compilationHandler(leaguesArr,nil)
        }
    }
    func fetchFixturesFromModel(leagueIndex:Int,exten:[String],compilationHandler: @escaping (Fixtures?,Error?)->Void){
        if shouldReturnError {
            compilationHandler(nil,ResponseWithError.responseError)
        }else{
            let fixtureArr = Fixtures()
            compilationHandler(fixtureArr,nil)
        }
    }
    func fetchTeamsFromModel(leagueIndex:Int,exten:String,compilationHandler: @escaping (Teams?,Error?)->Void){
        if shouldReturnError {
            compilationHandler(nil,ResponseWithError.responseError)
        }else{
            let teamsArr = Teams()
            compilationHandler(teamsArr,nil)
        }
    }
}
