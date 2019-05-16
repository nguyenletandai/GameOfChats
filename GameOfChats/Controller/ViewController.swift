//
//  ViewController.swift
//  GameOfChats
//
//  Created by dai on 07/05/2019.
//  Copyright © 2019 dai. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = Database.database().reference(fromURL: "https://gameofchats-1535a.firebaseio.com/")
//        ref.updateChildValues(["someValue": 1233123])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        // user is not login in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        // Do any additional setup after loading the view, typically from a nib.
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

