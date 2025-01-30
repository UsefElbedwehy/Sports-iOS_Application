//
//  ApiKeys.swift
//  sportsApp
//
//  Created by Usef on 29/01/2025.
//

import Foundation


class ApiKeys {
    private static let key = "1bdf9ca0bb2950913f68e460c14c228d8775b1266523146f4c14f76ea04b5678"
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
