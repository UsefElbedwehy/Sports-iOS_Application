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
    var favLeagueView:FavLeagueProtocol?
    func attachToView(view:HomeProtocol) {
        self.view = view
    }
    func attachToLeagueView(view:LeagueProtocol) {
        self.leagueView = view
    }
    func attachToFavLeagueView(view:FavLeagueProtocol) {
        self.favLeagueView = view
    }
    
    func FetchLeaguesFromJson(_ leagueIndex:Int){
        Service.fetchLeaguesFromModel(leagueIndex:leagueIndex) { res in
            guard let res = res else{
                print("empty data...please try again!")
                return
            }
            self.view?.renderDataToView(res:res)
        }
    }
    func FetchTeamsFromJson(_ leagueIndex:Int, leagueID:String) {
        Service.fetchTeamsFromModel(leagueIndex:leagueIndex, exten: leagueID) { res in
            guard let res = res else{
                print("empty data...please try again!")
                return
            }
            self.leagueView?.renderTeamsToView(res:res)
        }
    }
    //from=2025-01-25&to=2025-02-25&leagueId=
    func FetchFixtureFromJson(_ leagueIndex:Int , leagueID:String) {
        if leagueID == "28"{
            Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2022-11-20","to=2022-12-19","leagueId=\(leagueID)"]) { res in
                guard let res = res else{
                    print("empty data...please try again!")
                    return
                }
                self.leagueView?.renderLatestMatchesToView(res:res)
            }
        }else{
            Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2024-01-29","to=2025-01-29","leagueId=\(leagueID)"]) { res in
                guard let res = res else{
                    print("empty data...please try again!")
                    return
                }
                self.leagueView?.renderLatestMatchesToView(res:res)
            }
        }
    }
    func FetchUpComingFixtureFromJson(_ leagueIndex:Int , leagueID:String) {
        Service.fetchFixturesFromModel(leagueIndex:leagueIndex , exten: ["from=2025-02-5","to=2025-06-30","leagueId=\(leagueID)"]) { res in
            guard let res = res else{
                print("empty data...please try again!")
                return
            }
            self.leagueView?.renderUpcomingMatchesToView(res:res)
        }
    }
    //  -- Core Data -- --- ---- ----- ------ ------- --------
    func FetchfavLeaguesFromDataBase(){
        CoreDataDB.sharedInstance.FetchFavLeaguesFromDBModel { res in
            guard let res = res else{
                print("empty data...please try again!")
                return
            }
            self.favLeagueView!.renderFavLeaguesToTableView(res: res)
        }
    }
    func removeAllFavLeagues(){
        CoreDataDB.sharedInstance.removeAllFavLeaguesFromDBModel()
    }
    func removeTheLeagueFromFavourites(id:Int){
        CoreDataDB.sharedInstance.removeOneFavLeagueFromDBModel(id: id)
    }
    func isFound(id:Int){
        CoreDataDB.sharedInstance.isFoundInFavLeaguesInDBModel(id: id) { res in
            self.leagueView!.chechFavourite(res: res)
        }
    }
    func saveLeagueToFavLeagues(leagues: [League]/*,index:Int*/){
        CoreDataDB.sharedInstance.SaveFavLeaguesToDBModel(leagues: leagues/*,index:index*/)
    }
    
}
