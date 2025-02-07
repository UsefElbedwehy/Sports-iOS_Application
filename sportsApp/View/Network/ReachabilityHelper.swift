//
//  ReachabilityHelper.swift
//  sportsApp
//
//  Created by Usef on 02/02/2025.
//

import Foundation
import Reachability
//declare this property where it won't go out of scope relative to your listener
class ReachabilityHelper {
    public static let sharedInstance = ReachabilityHelper()
    private let reachability :Reachability!
    init() {
        reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
    }
    func checkNetwork() {
        do{
          try reachability.startNotifier()
        }catch{
          print("could not start reachability notifier")
        }
    }
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
      }
    }
}
