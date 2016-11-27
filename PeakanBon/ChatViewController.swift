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

    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = "1"
        self.senderDisplayName = "zero2launch"
        

        // Do any additional setup after loading the view.
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        print("didPressSendButton")
        print(text)
        print(senderId)
        print(senderDisplayName)
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        print(messages)
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("accessoryButton")
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
