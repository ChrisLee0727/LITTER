//
//  Comment.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//
import Foundation
class Comment {
    var commentText: String?
    var uid: String?
}

extension Comment {
    static func transformComment(dict: [String: Any]) -> Comment {
        let comment = Comment()
        comment.commentText = dict["commentText"] as? String
        comment.uid = dict["uid"] as? String
        return comment
    }
}
