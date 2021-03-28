//
//  ConnectivityManager.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import Foundation
import Alamofire

class ConnectivityManager {
    static func checkInternetConnection() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
