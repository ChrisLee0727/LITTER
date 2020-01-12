//
//  User.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import Foundation
class UserModel {
    var email: String?
    var profileImageUrl: String?
    var username: String?
    var id: String?
    var password: String?
    var isFollowing: Bool?
    var bio: String?
//    var displayname: String?
}

extension UserModel {
    static func transformUser(dict: [String: Any], key: String) -> UserModel {
        let user = UserModel()
        user.email = dict["email"] as? String
        user.profileImageUrl = dict["profileImageUrl"] as? String
        user.username = dict["username"] as? String
        user.password = dict["password"] as? String
        user.bio = dict["bio"] as? String
        user.id = key
//        user.displayname = dict["displayname"] as? String
        return user
    }
    
}
