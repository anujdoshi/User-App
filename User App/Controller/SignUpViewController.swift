//
//  SignUpViewController.swift
//  User App
//
//  Created by Anuj Doshi on 30/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit
import CoreData
class SignUpViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    var userArray = [User]()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filePath)
        loadData()
        view.setGradientColor(colorOne: .black, colorTwo: .white)
    }

    @IBAction func signUpBtn(_ sender: UIButton) {
        
        let newUser = User(context: context)
        newUser.firstName = firstNameTextField.text
        newUser.lastName = lastNameTextField.text
        newUser.email = emailTextField.text
        newUser.phoneNo = phoneNoTextField.text
        newUser.password = passwordTextField.text
        userArray.append(newUser)
        saveData()
    }
    func saveData(){
        do{
            try context.save()
            successful()
        }catch{
            errorAlert()
            print(error)
        }
    }
    func successful(){
        let alert = UIAlertController(title: "Sign-Up", message: "Successfully Sign-up Click ok to continue", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "homeSign", sender: self)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func errorAlert(){
        let alert = UIAlertController(title: "Sign-Up", message: "Something went wrong try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            //self.performSegue(withIdentifier: "signup_home", sender: self)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HomeViewController
        vc.firstName = firstNameTextField.text!
        vc.lastName = lastNameTextField.text!
        vc.email = emailTextField.text!
        vc.phoneNo = phoneNoTextField.text!
        vc.password = passwordTextField.text!
    }
    func loadData(){
        
    }
}
