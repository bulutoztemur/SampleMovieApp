//
//  RemoteConfigManager.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 28.03.2021.
//

import Foundation
import Firebase

class RemoteConfigManager {
    static func fetchDataFromRemoteConfig(myKey: String, handler: @escaping (String) -> Void){
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { (status, error) in
            guard error == nil else { return }
            RemoteConfig.remoteConfig().activate()
            let value = RemoteConfig.remoteConfig().configValue(forKey: myKey).stringValue ?? ""
            handler(value)
        }
    }
}
