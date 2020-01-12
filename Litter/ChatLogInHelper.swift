//
//  Helper.swift
//  Litter
//
//  Created by Leeminjae on 2018. 3. 7..
//  Copyright © 2018년 X3. All rights reserved.
//

//import Foundation
//import FirebaseAuth
//import UIKit
//import FirebaseDatabase
//
//class Helper {
//    static let helper = Helper()
//    
//    func switchToNavigationViewController() {
//        
//        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
//        let naviVC = storyboard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = naviVC
//        
//    }
//    
//}

//
//    func loginAnonymously() {
//        print("login anonymously did tapped")
//        // Anonymously log users in
//        // switch view by setting navigation controller as root view controller
//
//        Auth.auth().signInAnonymously(completion: ({ (anonymousUser: User?, error: Error?) in
//            if error == nil {
//                print("UserId: \(anonymousUser!.uid)")
//
//                let newUser = Database.database().reference().child("users").child(anonymousUser!.uid)
//                newUser.setValue(["displayname" : "anonymous", "id" : "\(anonymousUser!.uid)",
//                    "profileUrl": ""])
//                self.switchToNavigationViewController()
//
//            } else {
//                print(error!.localizedDescription)
//                return
//            }
//        } ))
//
//
//
//    }


//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//
//
//        Auth.auth().signIn(with: credential, completion: ({ (user: User?, error: Error?) in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }else {
//                let newUser = Database.database().reference().child("users").child(user!.uid)
//                newUser.setValue(["displayname" : "\(user!.displayName!)", "id" : "\(user!.uid)",
//                    "profileUrl": "\(user!.photoURL!)"])
//
//
//                self.switchToNavigationViewController()
//            }
//        } ))
