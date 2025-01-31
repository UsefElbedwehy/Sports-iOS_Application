//
//  CoreDataDB.swift
//  sportsApp
//
//  Created by Usef on 31/01/2025.
//

import Foundation
import CoreData
import UIKit
protocol DataBaseProtocol {
    func SaveFavLeaguesToDBModel(leagues:[League])
    func FetchFavLeaguesFromDBModel(compilationHandler: @escaping ([League]?)->Void)
    func removeAllFavLeaguesFromDBModel()
    func isFoundInFavLeaguesInDBModel(id: Int, compilationHandler: @escaping (Bool)->Void)
}

class CoreDataDB : DataBaseProtocol {
    public static let sharedInstance = CoreDataDB()
    private var managedContex: NSManagedObjectContext!
    private var favLeagues = [NSManagedObject]()
    private let favLeaguesEntityName = "FavLeagues"
    private let leagueLogoKey = "leagueLogo"
    private let leagueNameKey = "leagueName"
    private let leagueIdKey   = "leagueId"
    private let leagueIndexKey   = "leagueIndex"
    private init(){
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        managedContex = appDelegete.persistentContainer.viewContext
    }

    func SaveFavLeaguesToDBModel(leagues:[League]){
        let entity = NSEntityDescription.entity(forEntityName: favLeaguesEntityName, in: managedContex)
        for league in leagues {
            let favLeagues = NSManagedObject(entity: entity!, insertInto: managedContex)
            favLeagues.setValue(league.league_key , forKey: leagueIdKey)
            favLeagues.setValue(league.league_name, forKey: leagueNameKey)
            favLeagues.setValue(league.league_logo, forKey: leagueLogoKey)
            favLeagues.setValue(league.leagueIndex, forKey: leagueIndexKey)
            print("\(String(describing: league.league_key))")
            print("\(String(describing: league.league_name))")
            print("\(String(describing: league.league_logo))")
            print("\(String(describing: league.leagueIndex))")
        }
        do{
            try managedContex.save()
            print("saved")
        }catch let error {
            print("XXXXXXXXXXXXXXXXXXXXXXXX")
            print(error.localizedDescription)
        }
    }
    
    func FetchFavLeaguesFromDBModel(compilationHandler: @escaping ([League]?)->Void){
        var leagueArray = [League]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: favLeaguesEntityName)
        do{
            favLeagues.removeAll()
            favLeagues = try managedContex.fetch(fetchRequest)
            for favLeague in favLeagues {
                let tempLeague = League()
                tempLeague.league_key = favLeague.value(forKey: leagueIdKey) as? Int
                tempLeague.league_name = favLeague.value(forKey: leagueNameKey) as? String
                tempLeague.league_logo = favLeague.value(forKey: leagueLogoKey) as? String
                tempLeague.leagueIndex = favLeague.value(forKey: leagueIndexKey) as? Int
                print("\(String(describing: tempLeague.league_key))")
                print("\(String(describing: tempLeague.league_name))")
                print("\(String(describing: tempLeague.league_logo))")
                print("\(String(describing: tempLeague.leagueIndex))")
                leagueArray.append(tempLeague)
            }
            compilationHandler(leagueArray)
            print("fetched")
        }catch let error{
            print("XXXXXYYYYYYYYYYYYYYYXXXX")
            print(error.localizedDescription)
        }
    }
    func FetchFavLeaguesFromDBModel()->[League]{
        var leagueArray = [League]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: favLeaguesEntityName)
        do{
            favLeagues.removeAll()
            favLeagues = try managedContex.fetch(fetchRequest)
            for favLeague in favLeagues {
                let tempLeague = League()
                tempLeague.league_key = favLeague.value(forKey: leagueIdKey) as? Int
                tempLeague.league_name = favLeague.value(forKey: leagueNameKey) as? String
                tempLeague.league_logo = favLeague.value(forKey: leagueLogoKey) as? String
                tempLeague.leagueIndex = favLeague.value(forKey: leagueIndexKey) as? Int
                print("\(String(describing: tempLeague.league_key))")
                print("\(String(describing: tempLeague.league_name))")
                print("\(String(describing: tempLeague.league_logo))")
                print("\(String(describing: tempLeague.leagueIndex))")
                leagueArray.append(tempLeague)
            }
            print("fetched")
        }catch let error{
            print("XXXXXYYYYYYYYYYYYYYYXXXX")
            print(error.localizedDescription)
        }
        return leagueArray
    }
    func removeAllFavLeaguesFromDBModel(){
        _ = FetchFavLeaguesFromDBModel()
        for favLeague in favLeagues {
            managedContex.delete(favLeague)
        }
        do{
            try managedContex.save()
            print("Deleted!")
        }catch let error {
            print(error.localizedDescription)
        }
    }
    func removeOneFavLeagueFromDBModel(id: Int){
        _ = FetchFavLeaguesFromDBModel()
        if id != 0 {
            for favLeague in favLeagues {
                if (favLeague.value(forKey: leagueIdKey) as! Int) == id  {
                    managedContex.delete(favLeague)
                }
            }
        do{
            try managedContex.save()
            print("Deleted!")
        }catch let error {
            print(error.localizedDescription)
        }
        }
    }
    func isFoundInFavLeaguesInDBModel(id: Int, compilationHandler: @escaping (Bool)->Void){
        _ = FetchFavLeaguesFromDBModel()
        var isFound = false
        for favLeague in favLeagues {
            if (favLeague.value(forKey: leagueIdKey) as! Int) == id {
                isFound = true
            }
        }
        compilationHandler(isFound)
    }
//    func removeOneFavLeagueFromDBModel(id:Int){
//        _ = FetchFavLeaguesFromDBModel()
//        for favLeague in favLeagues {
//            if (favLeague.value(forKey: leagueIdKey) as! Int) == id {
//                managedContex.delete(favLeague)
//            }
//        }
//        do{
//            try managedContex.save()
//            print("Deleted!")
//        }catch let error {
//            print(error.localizedDescription)
//        }
//    }
}
