//
//  ApiKeys.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation

class ApiKeys {
    private static let key = "98a54793319324a265e3349768d8c2fc43fdc8083c664d4dce820d7602dabd05"
    public static let url = "https://apiv2.allsportsapi.com/"
    public static func createApiUrl(league:String , parameter: String  ) -> String {
        return "https://apiv2.allsportsapi.com/\(league)/?met=\(parameter)&APIkey=\(key)"
    }
    public static func createApiUrlWithExten(league:String , parameter: String ,exten:[String] ) -> String {
        var urlStr = "https://apiv2.allsportsapi.com/\(league)/?met=\(parameter)&APIkey=\(key)"
        for item in exten {
            urlStr.append("&")
            urlStr.append(item)
        }
        return urlStr
    }
}
