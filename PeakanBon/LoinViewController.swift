//
//  LoinViewController.swift
//  PeakanBon
//
//  Created by gongzheng on 2016/11/20.
//  Copyright © 2016年 gongzheng. All rights reserved.
//

import UIKit
import GoogleSignIn



class LoinViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate{
    

    @IBOutlet weak var anoymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        anoymousButton.layer.borderWidth = 2.0
        anoymousButton.layer.borderColor = UIColor.white.cgColor
        GIDSignIn.sharedInstance().clientID = "945616063443-fc74gkeqjtnndhdv9l84q7p072qsigsn.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    
    @IBAction func loginAnoymously(_ sender: Any) {
        print("login Anoymously did taped")
        Helper.helper.loginAnoymously()
    }


    @IBAction func googleLoginDidTaped(_ sender: Any) {
        print("login google did taped")
        GIDSignIn.sharedInstance().signIn()
        
        
    }


     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        Helper.helper.loginWithGoogle(authentication: user.authentication)
        
        print("ocalizedDescriptionloginwithgoogle")
        
        
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {

    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
     
    }
    

}
