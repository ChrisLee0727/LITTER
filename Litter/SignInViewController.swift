//
//  SignInViewController.swift
//  Litter
//
//  Created by X3non0727 on 01/15/18.
//  Copyright © 2018 X3non0727. All rights reserved.
//

import UIKit
class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.isEnabled = false
        handleTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        
        if !hasViewedWalkthrough {
            if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WalkthroughViewController") as? WalkthroughViewController {
                present(pageVC, animated: true, completion: nil)
            }
        }
     

        if Api.User.CURRENT_USER != nil {
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
            
        }
    }
    
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
        
    }
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                signInButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
                signInButton.isEnabled = false
                return
        }
        
        signInButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signInButton.isEnabled = true
    }

    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)

        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
            ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "signInToTabbarVC", sender: nil)
            
        }, onError: { error in
            ProgressHUD.showError(error!)
        })
    }
    
    
}
