//
//  SettingTableViewController.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import UIKit

protocol SettingTableViewControllerDelegate {
    func updateUserInfor()
}

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var usernnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var delegate: SettingTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Profile"
        usernnameTextField.delegate = self
        emailTextField.delegate = self
        //passwordTextField.delegate = self
        bioTextField.delegate = self
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        Api.User.observeCurrentUser { (user) in
            self.usernnameTextField.text = user.username
            self.emailTextField.text = user.email
            self.bioTextField.text = user.bio
            //self.passwordTextField.text = user.password
            if let profileUrl = URL(string: user.profileImageUrl!) {
                self.profileImageView.sd_setImage(with: profileUrl)
            }
        }
    }
    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
        if let profileImg = self.profileImageView.image, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            ProgressHUD.show("Waiting...")
            
            AuthService.updateUserInfor(username: usernnameTextField.text!, email: emailTextField.text!, imageData: imageData, bio: bioTextField.text!, onSuccess: {
                    ProgressHUD.showSuccess("Success")
                    self.delegate?.updateUserInfor()
                }, onError: { (errorMessage) in
                    ProgressHUD.showError(errorMessage)
                })
            }
        
    }
    
    @IBAction func logoutBtn_TouchUpInside(_ sender: Any) {
        AuthService.logout(onSuccess: {
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    @IBAction func changeProfileBtn_TouchUpInside(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
}

extension SettingTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SettingTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        textField.resignFirstResponder()
        return true
    }
}











































