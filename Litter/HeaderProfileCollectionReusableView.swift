//
//  HeaderProfileCollectionReusableView.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import UIKit

protocol HeaderProfileCollectionReusableViewDelegate {
    func updateFollowButton(forUser user: UserModel)
}

protocol HeaderProfileCollectionReusableViewDelegateSwitchSettingVC {
    func goToSettingVC()
}

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var myPostsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    
    var delegate: HeaderProfileCollectionReusableViewDelegate?
    var delegate2: HeaderProfileCollectionReusableViewDelegateSwitchSettingVC?
    var user: UserModel? {
        didSet {
            updateView()
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
    }
    
    func updateView() {
        self.nameLabel.text = user!.username
        self.bioLabel.text = user!.bio
        if let photoUrlString = user!.profileImageUrl {
            let photoUrl = URL(string: photoUrlString)
            self.profileImage.sd_setImage(with: photoUrl)
        }
        
        Api.MyPosts.fetchCountMyPosts(userId: user!.id!) { (count) in
             self.myPostsCountLabel.text = "\(count)"
        }
        
        Api.Follow.fetchCountFollowing(userId: user!.id!) { (count) in
            self.followingCountLabel.text = "\(count)"
        }
        
        Api.Follow.fetchCountFollowers(userId: user!.id!) { (count) in
            self.followersCountLabel.text = "\(count)"
        }
        
        if user?.id == Api.User.CURRENT_USER?.uid {
            followButton.setTitle("Edit Profile", for: UIControlState.normal)
            followButton.addTarget(self, action: #selector(self.goToSettingVC), for: UIControlEvents.touchUpInside)

        } else {
            updateStateFollowButton()
        }
    }
    
//    func textField(_ bioLabel: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let currentCharacterCount = bioLabel.text?.characters.count ?? 0
//        if (range.length + range.location > currentCharacterCount){
//            return false
//        }
//        let newLength = currentCharacterCount + string.characters.count - range.length
//        return newLength <= 25
//    }
    
    func clear() {
        self.myPostsCountLabel.text = ""
        self.followingCountLabel.text = ""
        self.followersCountLabel.text = ""
        self.bioLabel.text = ""
        self.nameLabel.text = ""
    }

    @objc func goToSettingVC() {
        delegate2?.goToSettingVC()
    }
    
    func updateStateFollowButton() {
        if user!.isFollowing! {
            configureUnFollowButton()
        } else {
            configureFollowButton()
        }
    }
    
    func configureFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        followButton.backgroundColor = UIColor(red: 69/255, green: 142/255, blue: 255/255, alpha: 1)
        followButton.setTitle("Follow", for: UIControlState.normal)
        followButton.addTarget(self, action: #selector(self.followAction), for: UIControlEvents.touchUpInside)
    }
    
    func configureUnFollowButton() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232.255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
        
        followButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        followButton.backgroundColor = UIColor.clear
        followButton.setTitle("Following", for: UIControlState.normal)
        followButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControlEvents.touchUpInside)
    }
    
    @objc func followAction() {
        if user!.isFollowing! == false {
            Api.Follow.followUserAction(withUser: user!.id!)
            configureUnFollowButton()
            user!.isFollowing! = true
            delegate?.updateFollowButton(forUser: user!)
        }
    }
    
    @objc func unFollowAction() {
        if user!.isFollowing! == true {
            Api.Follow.unFollowAction(withUser: user!.id!)
            configureFollowButton()
            user!.isFollowing! = false
            delegate?.updateFollowButton(forUser: user!)
        }
    }

}
