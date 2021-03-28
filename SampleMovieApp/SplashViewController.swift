//
//  SplashViewController.swift
//  SampleMovieApp
//
//  Created by Alaattin Bulut Öztemur on 25.03.2021.
//

import UIKit
import Firebase
import Alamofire

class SplashViewController: UIViewController {

    @IBOutlet weak var splashLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPage()
    }
    
    func setupPage(){
        self.hideNavigationBar()
        if(self.checkInternetConnection()) {
            self.fetchDataFromRemoteConfig()
        } else {
            self.createNoInternetAlert()
        }
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
            
    func fetchDataFromRemoteConfig(){
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
            guard error == nil else { return }
            RemoteConfig.remoteConfig().activate()
            self.updateLabelOnSplash()
        }
    }
    
    func updateLabelOnSplash() {
        let labelText = RemoteConfig.remoteConfig().configValue(forKey: "loodos_text").stringValue ?? ""
        self.splashLabel.text = labelText
        self.transitionToMainPageWithDelay()
    }
    
    func transitionToMainPageWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.transitionToMainPage()
        }
    }

    func transitionToMainPage() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    func checkInternetConnection() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func createNoInternetAlert() {
        let alert = UIAlertController(title: "Error", message: "You're offline", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
