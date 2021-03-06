//
//  AuthService.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class AuthService {
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
        
    }
    
//    static func logInAnonymously() {
//        print("func logInAnonymously start")
//        Auth.auth().signInAnonymously()
//
//    }
//    
//    func loginAnonymously() {
//        print("login anonymously did tapped")
//        // Anonymously log users in
//        // switch view by setting navigation controller as root view controller
//        
//        FIRAuth.auth()?.signInAnonymouslyWithCompletion({ (anonymousUser: FIRUser?, error: NSError?) in
//            if error == nil {
//                print("UserId: \(anonymousUser!.uid)")
//                
//                let newUser = FIRDatabase.database().reference().child("users").child(anonymousUser!.uid)
//                newUser.setValue(["displayname" : "anonymous", "id" : "\(anonymousUser!.uid)",
//                    "profileUrl": ""])
//                self.switchToNavigationViewController()
//                
//            } else {
//                print(error!.localizedDescription)
//                return
//            }
//        })
//    }
//    
//    static func setAnonymousUserInfomation(username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
//        let ref = Database.database().reference()
//        let usersReference = ref.child("users")
//        let newUserReference = usersReference.child(uid)
//        newUserReference.setValue(["username": username, "username_lowercase": username.lowercased(), "email": email])
//        onSuccess()
//    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid!)
            
            storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                let profileImageUrl = metadata?.downloadURL()?.absoluteString
                
                self.setUserInfomation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccess: onSuccess)
            })
        })
        
    }
    
    static func setUserInfomation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping () -> Void) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "username_lowercase": username.lowercased(), "email": email, "profileImageUrl": profileImageUrl])
        onSuccess()
    }
    
    static func updateUserInfor(username: String, email: String, imageData: Data, bio: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        
        Api.User.CURRENT_USER?.updateEmail(to: email, completion: { (error) in
            if error != nil {
                onError(error!.localizedDescription)
            }else {
                let uid = Api.User.CURRENT_USER?.uid
                let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid!)
                
                storageRef.putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                        return
                    }
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString
                    
                    self.updateDatabase(profileImageUrl: profileImageUrl!, username: username, email: email, bio: bio, onSuccess: onSuccess, onError: onError)
                })
            }
        })
        
    }
    
    static func updateDatabase(profileImageUrl: String, username: String, email: String, bio: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        let dict = ["username": username, "username_lowercase": username.lowercased(), "email": email, "profileImageUrl": profileImageUrl, "bio": bio]
        Api.User.REF_CURRENT_USER?.updateChildValues(dict, withCompletionBlock: { (error, ref) in
            if error != nil {
                onError(error!.localizedDescription)
            } else {
                onSuccess()
            }
            
        })
    }
    
    static func logout(onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
        do {
            try Auth.auth().signOut()
            onSuccess()
            
        } catch let logoutError {
            onError(logoutError.localizedDescription)
        }
    }
}
