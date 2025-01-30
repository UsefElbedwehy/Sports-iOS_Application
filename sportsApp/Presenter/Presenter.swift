//
//  Presenter.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import Foundation

class Presenter {
    
    var view:HomeProtocol?
    var leagueView:LeagueProtocol?
    func attachToView(view:HomeProtocol) {
        self.view = view
    }
    func attachToLeagueView(view:LeagueProtocol) {
        self.leagueView = view
    }
    
    func FetchLeaguesFromJson(_ leagueIndex:Int){
        Service.fetchLeaguesFromModel(leagueIndex:leagueIndex) { res in
            self.view?.renderDataToView(res:res!)
        }
    }
    func FetchTeamsFromJson(_ leagueIndex:Int) {
        Service.fetchTeamsFromModel(leagueIndex:leagueIndex) { res in
            self.leagueView?.renderTeamsToView(res:res!)
        }
    }
    func FetchFixtureFromJson(_ leagueIndex:Int) {
        Service.fetchFixturesFromModel(leagueIndex:leagueIndex) { res in
            self.leagueView?.renderLatestMatchesToView(res:res!)
        }
    }
}
