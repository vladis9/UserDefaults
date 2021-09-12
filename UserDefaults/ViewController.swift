//
//  ViewController.swift
//  UserDefaults
//
//  Created by Vlad Zinevich on 10.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        user = StorageManager.shared.getUser()
        user = StorageManager.shared.getUserFromFile()
        userNameLabel.text = "\(user.name) \(user.surname)"
    }

    @IBAction func donePressed() {
        
        guard let firstName = firstNameTextField.text, !(firstName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        
        guard let secondName = secondNameTextField.text, !(secondName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        
        if let _ = Double(firstName) {
            wrongFormatAlert()
        } else if let _ = Double(secondName) {
            wrongFormatAlert()
        } else {
            userNameLabel.text = firstName + " " + secondName
            user.name = firstName
            user.surname = secondName
//            StorageManager.shared.saveUser(user)
            StorageManager.shared.saveUserToFile(user)
        }
        
        firstNameTextField.text = nil
        secondNameTextField.text = nil
    }
}

extension ViewController {
    
    private func wrongFormatAlert() {
        let alert = UIAlertController(
            title: "Wrong Format",
            message: "Please enter your name",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

