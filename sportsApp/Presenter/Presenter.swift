//
//  Presenter.swift
//  sportsApp
//
//  Created by Usef on 28/01/2025.
//

import Foundation
import UIKit

class Presenter {
    var view: HomeProtocol?
    var leagueView: LeagueProtocol?
    var favLeagueView: FavLeagueProtocol?
    func attachToView(view: HomeProtocol) { self.view = view }
    func attachToLeagueView(view: LeagueProtocol) { self.leagueView = view }
    func attachToFavLeagueView(view: FavLeagueProtocol) {
        self.favLeagueView = view
    }
}
// MARK: Service Presenter
extension Presenter {
    func FetchLeaguesFromJson(_ leagueIndex: Int) {
        Service.fetchLeaguesFromModel(leagueIndex: leagueIndex) {
            [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.view?.renderDataToView(res: res)
                }

            case .failure(let error):
                self?.printErrorMessage(error.localizedDescription)
                return
            }
        }
    }
    func FetchTeamsFromJson(_ leagueIndex: Int, leagueID: String) {
        Service.fetchTeamsFromModel(leagueIndex: leagueIndex, exten: leagueID) {
            [weak self]
            result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.leagueView?.renderTeamsToView(res: res)
                }
            case .failure(let error):
                self?.printErrorMessage(error.localizedDescription)
                return
            }
        }
    }

    func FetchFixtureFromJson(_ leagueIndex: Int, leagueID: String) {
        let worldCupID: String = "28"
        let date1 =
            (leagueID == worldCupID) ? "from=2022-11-20" : "from=2024-01-29"
        let date2 = (leagueID == worldCupID) ? "to=2022-12-19" : "to=2025-01-29"
        Service.fetchFixturesFromModel(
            leagueIndex: leagueIndex,
            exten: [date1, date2, "leagueId=\(leagueID)"]
        ) { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.leagueView?.renderLatestMatchesToView(res: res)
                }
            case .failure(let error):
                self?.printErrorMessage(error.localizedDescription)
                return
            }
        }
    }

    func FetchUpComingFixtureFromJson(_ leagueIndex: Int, leagueID: String) {
        Service.fetchFixturesFromModel(
            leagueIndex: leagueIndex,
            exten: ["from=2025-02-5", "to=2025-06-30", "leagueId=\(leagueID)"]
        ) { [weak self] result in
            switch result {
            case .success(let res):
                DispatchQueue.main.async {
                    self?.leagueView?.renderUpcomingMatchesToView(res: res)
                }
            case .failure(let error):
                self?.printErrorMessage(error.localizedDescription)
                return
            }
        }
    }
}

// MARK: Core-Data Presenter
extension Presenter {
    func FetchfavLeaguesFromDataBase() {
        CoreDataDB.sharedInstance.FetchFavLeaguesFromDBModel {
            [weak self] res in
            guard let res = res else {
                self?.printErrorMessage("empty data...please try again!")
                return
            }
            DispatchQueue.main.async {
                self?.favLeagueView!.renderFavLeaguesToTableView(res: res)
            }
        }
    }
    func removeAllFavLeagues() {
        CoreDataDB.sharedInstance.removeAllFavLeaguesFromDBModel()
    }
    func removeTheLeagueFromFavourites(id: Int) {
        CoreDataDB.sharedInstance.removeOneFavLeagueFromDBModel(id: id)
    }
    func isFound(id: Int) {
        CoreDataDB.sharedInstance.isFoundInFavLeaguesInDBModel(id: id) { res in
            self.leagueView!.chechFavourite(res: res)
        }
    }
    func saveLeagueToFavLeagues(leagues: [League] /*,index:Int*/) {
        CoreDataDB.sharedInstance.SaveFavLeaguesToDBModel(
            leagues: leagues /*,index:index*/
        )
    }
}

// MARK: Helpers
extension Presenter {
    func printErrorMessage(_ message: String) {
        print(String.presenterErrorTitle, message)
    }
}
