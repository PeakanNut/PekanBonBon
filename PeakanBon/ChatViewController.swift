//
//  ChatViewController.swift
//  PeakanBon
//
//  Created by gongzheng on 2016/11/20.
//  Copyright © 2016年 gongzheng. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import MobileCoreServices
import AVKit



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
        collectionView.reloadData()
        print(messages)
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("accessoryButton")
        let sheet = UIAlertController.init(title: "Media Message", message: "Please select a media", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil)
        let photoLibrary = UIAlertAction.init(title: "Photo Library", style: UIAlertActionStyle.default){
            (alert:UIAlertAction)in
            self.getMediaFrom(type: kUTTypeImage)
        }
        let movieLibrary = UIAlertAction.init(title: "Video Library", style: UIAlertActionStyle.default){
            (alert:UIAlertAction)in
            self.getMediaFrom(type: kUTTypeMovie)

        }
        
        sheet.addAction(photoLibrary)
        sheet.addAction(movieLibrary)
        sheet.addAction(cancel)
        self.present(sheet, animated: true, completion: nil)
    }
    
    func getMediaFrom(type: CFString){
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        return bubbleFactory?.outgoingMessagesBubbleImage(with: .black)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        let message = messages[indexPath.item]
        if message.isMediaMessage{
            if let mediaItem = message.media as? JSQVideoMediaItem{
                let player = AVPlayer(url:mediaItem.fileURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true, completion: nil)
            }
        }
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


extension ChatViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("did finish picking")
        print(info)
        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let photo = JSQPhotoMediaItem(image:picture)
            messages.append(JSQMessage(senderId:senderId, displayName:senderDisplayName,media:photo))
        }
        else if let video = info[UIImagePickerControllerMediaURL] as? NSURL {
            let videoItem = JSQVideoMediaItem(fileURL: video as URL!, isReadyToPlay:true)
            messages.append(JSQMessage(senderId:senderId, displayName:senderDisplayName,media: videoItem))
        }
        self.dismiss(animated: true, completion: nil)
        collectionView.reloadData()
    }
}

