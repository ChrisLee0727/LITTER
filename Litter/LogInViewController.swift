//
//  LogInViewController.swift
//  Litter
//
//  Created by Leeminjae on 2018. 3. 7..
//  Copyright © 2018년 X3. All rights reserved.
//

//import UIKit
//import FirebaseStorage
//import FirebaseDatabase
//import FirebaseAuth
//
//class LogInViewController: UIViewController  {
//
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//
//    func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError:  @escaping (_ errorMessage: String?) -> Void) {
//        AuthService.logout(onSuccess: {
//            return
//        }) { (errorMessage) in
//            ProgressHUD.showError(errorMessage)
//        }
//
//        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
//            if error != nil {
//                onError(error!.localizedDescription)
//                return
//            }
//            onSuccess()
//        })
//
//    }
//
//    @IBOutlet weak var anonymousButton: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        // anonymousButton:
//        // Set boder color and width
//        anonymousButton.layer.borderWidth = 2.0
//        anonymousButton.layer.borderColor = UIColor.white.cgColor
////        GIDSignIn.sharedInstance().clientID = "187372259709-e5vmgqnfil7cne2hkfo7frf4h340d32t.apps.googleusercontent.com"
////        GIDSignIn.sharedInstance().uiDelegate = self
////        GIDSignIn.sharedInstance().delegate = self
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        Auth.auth().addStateDidChangeListener({ (auth: Auth, user: User?) in
//            print("test3")
//            if user != nil {
//                Helper.helper.switchToNavigationViewController()
//            } else {
//                print("Error!")
//            }
//        })
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func loginAnonymouslyDidTapped(_ sender: Any) {
//        print("login anonymously did tapped")
//        // Anonymously log users in
//        // switch view by setting navigation controller as root view controller
//        AuthService.logInAnonymously()
//        Helper.helper.switchToNavigationViewController()
//    }
//
//    @IBAction func maintainAccountDidTapped(_ sender: Any) {
//        print("maintain login did tapped")
//        AuthService.signIn(email: emailTextField.text!, password: passwordTextField.text!, onSuccess: {
//            ProgressHUD.showSuccess("Success")
//            self.performSegue(withIdentifier: "LogInToTabbarVC", sender: nil)
//
//        }, onError: { error in
//            ProgressHUD.showError(error!)
//
//        })
//    }
//}


//    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
//        print(user.authentication)
//        Helper.helper.logInWithGoogle(authentication: user.authentication)
//
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

