//
//  ChatViewController.swift
//  Litter
//
//  Created by Leeminjae on 2018. 3. 7..
//  Copyright © 2018년 X3. All rights reserved.
//

//import UIKit
//import JSQMessagesViewController
//import MobileCoreServices
//import AVKit
//import FirebaseDatabase
//import FirebaseStorage
//import FirebaseAuth
//import SDWebImage
//
//class ChatViewController: JSQMessagesViewController {
//    
////    var user = [UserModel]()
//
//    var messages = [JSQMessage]()
//    var avatarDict = [String: JSQMessagesAvatarImage]()
//    var messageRef = Database.database().reference().child("messages")
//    //    let photoCache = NSCache()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if let currentUser = Api.User.CURRENT_USER //Auth.auth().currentUser
//        {
//            self.senderId = currentUser.uid
//            
//            if currentUser.isAnonymous == true
//            {
//                self.senderDisplayName = "anonymous"
//            } else
//            {
//                self.senderDisplayName = "\(currentUser.displayName!)"
//            }
//            
//        }
//        
//        observeMessages()
//    }
//    
//    func observeUsers(id: String)
//    {
//        Database.database().reference().child("users").child(id).observe(.value, with: {
//            snapshot in
//            if let dict = snapshot.value as? [String: Any]
//            {
//                let avatarUrl = dict["profileUrl"] as! String
//                
//                self.setupAvatar(url: avatarUrl, messageId: id)
//            }
//        })
//        
//    }
//    
//    func setupAvatar(url: String, messageId: String)
//    {
//        if url != "" {
//            let fileUrl = NSURL(string: url)
//            let data = NSData(contentsOf: fileUrl! as URL)
//            let image = UIImage(data: data! as Data)
//            let userImg = JSQMessagesAvatarImageFactory.avatarImage(with: image, diameter: 30)
//            self.avatarDict[messageId] = userImg
//            self.collectionView.reloadData()
//            
//        } else {
//            avatarDict[messageId] = JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "profileImage"), diameter: 30)
//            collectionView.reloadData()
//        }
//        
//    }
//    
//    func observeMessages() {
//        messageRef.observe(.childAdded, with: { snapshot in
//            // print(snapshot.value)
//            if let dict = snapshot.value as? [String: Any] {
//                let mediaType = dict["MediaType"] as! String
//                let senderId = dict["senderId"] as! String
//                let senderName = dict["senderName"] as! String
//                
//                self.observeUsers(id: senderId)
//                switch mediaType {
//                    
//                case "TEXT":
//                    
//                    let text = dict["text"] as! String
//                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, text: text))
//                    
//                case "PHOTO":
//                    //                    var photo = JSQPhotoMediaItem(image: nil)
//                    //                    let fileUrl = dict["fileUrl"] as! String
//                    //
//                    //                    if let cachedPhoto = self.photoCache.objectForKey(fileUrl) as? JSQPhotoMediaItem {
//                    //                        photo = cachedPhoto
//                    //                        self.collectionView.reloadData()
//                    //                    } else {
//                    //                        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
//                    //                            let data = NSData(contentsOfURL: NSURL(string: fileUrl)!)
//                    //                            dispatch_async(dispatch_get_main_queue(), {
//                    //                                let image = UIImage(data: data!)
//                    //                                photo.image = image
//                    //                                self.collectionView.reloadData()
//                    //                                self.photoCache.setObject(photo, forKey: fileUrl)
//                    //                            })
//                    //                        })
//                    //                    }
//                    let photo = JSQPhotoMediaItem(image: nil)
//                    let fileUrl = dict["fileUrl"] as! String
//                    let downloader = SDWebImageDownloader.shared()
//                    downloader.downloadImage(with: NSURL(string: fileUrl)! as URL, options: [], progress: nil, completed: { (image, data, error, finished) in
//                        
//                            photo?.image = image
//                            self.collectionView.reloadData()
//                    })
//                    
//                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: photo))
//                    
//                    if self.senderId == senderId {
//                        photo?.appliesMediaViewMaskAsOutgoing = true
//                    } else {
//                        photo?.appliesMediaViewMaskAsOutgoing = false
//                    }
//                    
//                    
//                case "VIDEO":
//                    
//                    let fileUrl = dict["fileUrl"] as! String
//                    let video = NSURL(string: fileUrl)!
//                    let videoItem = JSQVideoMediaItem(fileURL: video as URL! as URL!, isReadyToPlay: true)
//                    self.messages.append(JSQMessage(senderId: senderId, displayName: senderName, media: videoItem))
//                    
//                    if self.senderId == senderId {
//                        videoItem?.appliesMediaViewMaskAsOutgoing = true
//                    } else {
//                        videoItem?.appliesMediaViewMaskAsOutgoing = false
//                    }
//                    
//                default:
//                    print("unknown data type")
//                    
//                }
//                
//                self.collectionView.reloadData()
//                
//            }
//        })
//    }
//    
//    func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
//        //        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
//        //        collectionView.reloadData()
//        //        print(messages)
//        let newMessage = messageRef.childByAutoId()
//        let messageData = ["text": text, "senderId": senderId, "senderName": senderDisplayName, "MediaType": "TEXT"]
//        newMessage.setValue(messageData)
//        self.finishSendingMessage()
//    }
//    
//    override func didPressAccessoryButton(_ sender: UIButton!) {
//        print("didPressAccessoryButton")
//        
//        let sheet = UIAlertController(title: "Media Messages", message: "Please select a media", preferredStyle: UIAlertControllerStyle.actionSheet)
//        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alert:UIAlertAction) in
//            
//        }
//        
//        let photoLibrary = UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
//            self.getMediaFrom(type: kUTTypeImage)
//        }
//        
//        let videoLibrary = UIAlertAction(title: "Video Library", style: UIAlertActionStyle.default) { (alert: UIAlertAction) in
//            self.getMediaFrom(type: kUTTypeMovie)
//            
//        }
//        
//        
//        sheet.addAction(photoLibrary)
//        sheet.addAction(videoLibrary)
//        sheet.addAction(cancel)
//        self.present(sheet, animated: true, completion: nil)
//        
//        //        let imagePicker = UIImagePickerController()
//        //        imagePicker.delegate = self
//        //        self.presentViewController(imagePicker, animated: true, completion: nil)
//    }
//    
//    func getMediaFrom(type: CFString) {
//        print(type)
//        let mediaPicker = UIImagePickerController()
//        mediaPicker.delegate = self
//        mediaPicker.mediaTypes = [type as String]
//        self.present(mediaPicker, animated: true, completion: nil)
//    }
//    
//     func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
//        return messages[indexPath.item]
//    }
//    
//     func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//        let message = messages[indexPath.item]
//        let bubbleFactory = JSQMessagesBubbleImageFactory()
//        if message.senderId == self.senderId {
//            
//            return bubbleFactory!.outgoingMessagesBubbleImage(with: .black)
//        } else {
//            
//            return bubbleFactory!.incomingMessagesBubbleImage(with: .blue)
//            
//        }
//        
//        
//    }
//    
//     func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//        let message = messages[indexPath.item]
//        
//        return avatarDict[message.senderId]
//        //return JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "profileImage"), diameter: 30)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("number of item:\(messages.count)")
//        return messages.count
//    }
//    
//     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = super.collectionView as! JSQMessagesCollectionViewCell
//        
//        return cell
//    }
//    
//     func collectionView(collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAtIndexPath indexPath: NSIndexPath!) {
//        let message = messages[indexPath.item]
//        if message.isMediaMessage {
//            if let mediaItem = message.media as? JSQVideoMediaItem {
//                let player = AVPlayer(url: mediaItem.fileURL)
//                let playerViewController = AVPlayerViewController()
//                playerViewController.player = player
//                self.present(playerViewController, animated: true, completion: nil)
//                
//            }
//        }
//    }
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    @IBAction func logoutDidTapped(_ sender: Any) {
//        AuthService.logout(onSuccess:{
//           let storyboard = UIStoryboard(name: "Chat", bundle: nil)
//           let logInVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
//            self.present(logInVC, animated: true, completion: nil)
//        }, onError: { (errorMessage) in
//            ProgressHUD.showError(errorMessage)
//        })
//        
//    }
//    
//    func sendMedia(picture: UIImage?, video: NSURL?) {
//        print(Storage.storage().reference())
//        if let picture = picture {
//            let filePath = "\(Auth.auth().currentUser)/\(NSDate.timeIntervalSinceReferenceDate)"
//            print(filePath)
//            let data = UIImageJPEGRepresentation(picture, 0.1)
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpg"
//            Storage.storage().reference().child(filePath).putData(data!, metadata: metadata) { (metadata, error)
//                in
//                if error != nil {
//                    return
//                }
//                
//                let fileUrl = metadata!.downloadURLs![0].absoluteString
//                
//                let newMessage = self.messageRef.childByAutoId()
//                let messageData = ["fileUrl": fileUrl, "senderId": self.senderId, "senderName": self.senderDisplayName, "MediaType": "PHOTO"]
//                newMessage.setValue(messageData)
//                
//            }
//            
//        } else if let video = video {
//            let filePath = "\(String(describing: Auth.auth().currentUser))/\(NSDate.timeIntervalSinceReferenceDate)"
//            print(filePath)
//            let data = NSData(contentsOf: video as URL)
//            let metadata = StorageMetadata()
//            metadata.contentType = "video/mp4"
//            Storage.storage().reference().child(filePath).putData(data! as Data, metadata: metadata) { (metadata, error)
//                in
//                if error != nil {
//                    return
//                }
//                
//                let fileUrl = metadata!.downloadURLs![0].absoluteString
//                
//                let newMessage = self.messageRef.childByAutoId()
//                let messageData = ["fileUrl": fileUrl, "senderId": self.senderId, "senderName": self.senderDisplayName, "MediaType": "VIDEO"]
//                newMessage.setValue(messageData)
//                
//            }
//        }
//    }
//}
//
//extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        print("did finish picking")
//        // get the image
//        print(info)
//        if let picture = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            
//            sendMedia(picture: picture, video: nil)
//        }
//        else if let video = info[UIImagePickerControllerMediaURL] as? NSURL {
//            
//            sendMedia(picture: nil, video: video)
//            
//        }
//        
//        self.dismiss(animated: true, completion: nil)
//        collectionView.reloadData()
//        
//        
//    }
//}
//
//
//

