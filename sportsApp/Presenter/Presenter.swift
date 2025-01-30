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
    func FetchTeamsFromJson(_ leagueIndex:Int, leagueID:String) {
        Service.fetchTeamsFromModel(leagueIndex:leagueIndex, exten: leagueID) { res in
            self.leagueView?.renderTeamsToView(res:res!)
        }
    }
    //from=2025-01-25&to=2025-02-25&leagueId=
    func FetchFixtureFromJson(_ leagueIndex:Int , leagueID:String) {
        if leagueID == "28"{
            Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2022-11-20","to=2022-12-19","leagueId=\(leagueID)"]) { res in
                self.leagueView?.renderLatestMatchesToView(res:res!)
            }
        }else{
            Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2024-12-01","to=2025-01-29","leagueId=\(leagueID)"]) { res in
                self.leagueView?.renderLatestMatchesToView(res:res!)
            }
        }
    }
    func FetchUpComingFixtureFromJson(_ leagueIndex:Int , leagueID:String) {
        Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2025-03-30","to=2025-04-30","leagueId=\(leagueID)"]) { res in
            self.leagueView?.renderUpcomingMatchesToView(res:res!)
        }
    }
}
