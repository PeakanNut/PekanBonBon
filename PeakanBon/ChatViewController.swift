//
//  ChatViewController.swift
//  PeakanBon
//
//  Created by gongzheng on 2016/11/20.
//  Copyright © 2016年 gongzheng. All rights reserved.
//

import UIKit
import JSQMessagesViewController



class ChatViewController: JSQMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "1"
        self.senderDisplayName = "zero2launch"
        
        override func didPressSend(<#T##button: UIButton!##UIButton!#>, withMessageText: <#T##String!#>, senderId: <#T##String!#>, senderDisplayName: <#T##String!#>, date: <#T##Date!#>){
            print("didPreeeSendButton")
            print("")
        }

        // Do any additional setup after loading the view.
    }

    @IBAction func logOutDidClicked(_ sender: Any) {
        print("logOut Anoymously did taped")
        
        //Create a main storyboard instance
        let storyboard = UIStoryboard(name:"Main",bundle: nil)
        //From main storyboard instance
        
        let naviVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")as! LoinViewController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = naviVC
    }

}
