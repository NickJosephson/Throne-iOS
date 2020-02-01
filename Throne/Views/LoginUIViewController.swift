//
//  LoginUIViewController.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-01-31.
//  Copyright © 2020 Throne. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginUIViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }

    @IBAction func pressStart(_ sender: UIButton) {
        session.start()
    }
    
    var session: ASWebAuthenticationSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Use the URL and callback scheme specified by the authorization provider.
        guard let authURL = URL(string: "https://findmythrone.com") else { return }
        let scheme = "exampleauth"

        // Initialize the session.
        session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
        { callbackURL, error in
            // Handle the callback.
            LoginManager.sharedInstance.login()
        }
        
        session.presentationContextProvider = self
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
