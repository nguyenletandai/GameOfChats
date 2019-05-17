//
//  ViewController.swift
//  GameOfChats
//
//  Created by dai on 07/05/2019.
//  Copyright © 2019 dai. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let ref = Database.database().reference(fromURL: "https://gameofchats-1535a.firebaseio.com/")
        //        ref.updateChildValues(["someValue": 1233123])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        checkIfUserIsLogin()
    }
    @objc func handleNewMessage() {
        let newMessageController = NewMessegeController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    // user is not login in
    func checkIfUserIsLogin() {
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    self.navigationItem.title = dictionary["name"] as? String
                }

            }, withCancel: nil)
        }
    }

    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
    
}

