//
//  Helper.swift
//  PeakanBon
//
//  Created by gongzheng on 2016/11/20.
//  Copyright © 2016年 gongzheng. All rights reserved.
//

import UIKit
import FirebaseAuth



class Helper: NSObject {
    
    static let helper = Helper()
    
    func loginAnoymously() {
        print("login Anoymously did taped")
        
        FIRAuth.auth()?.signInAnonymously() { (user, error) in
            if error == nil{
                print("UserId:")
                let storyboard = UIStoryboard(name:"Main",bundle: nil)
                let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC")as! UINavigationController
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = naviVC
            }else{
                print(error!.localizedDescription)
                return
            }
        }

    }
    
    func loginWithGoogle(authentication: GIDAuthentication){
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

        
        FIRAuth.auth()?.signIn(with: credential, completion: {(user,error)in
            if error != nil {
                print(error!.localizedDescription)
                return
            }else{
                print(user?.email)
                print(user?.displayName)
                self.switchToNavigationViewController()
            }
        })
    }
    
    private func switchToNavigationViewController(){
        
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC")as! UINavigationController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }
}
