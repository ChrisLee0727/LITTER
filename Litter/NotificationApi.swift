//
//  NotificationApi.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import Foundation
import FirebaseDatabase
class NotificationApi {
    var REF_NOTIFICATION = Database.database().reference().child("notification")
    func observeNotification(withId  id: String, completion: @escaping (Notification) -> Void) {
        REF_NOTIFICATION.child(id).observe(.childAdded, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                print(dict)
                let newNoti = Notification.transform(dict: dict, key: snapshot.key)
                completion(newNoti)
            }
        })
    }

}
