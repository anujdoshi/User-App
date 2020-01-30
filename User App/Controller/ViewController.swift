//
//  ViewController.swift
//  User App
//
//  Created by Anuj Doshi on 30/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var userArray = [User]()
    var firstName:String = ""
    var lastName: String = ""
    var phoneNo:String = ""
    var userName:String = ""
    var password:String = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.setGradientColor(colorOne: .black, colorTwo: .white)
        loadData()
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        userName = emailTextField.text!
        password = passwordTextField.text!
        
        checkUser()
    }
    func loadData(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        do{
            userArray = try context.fetch(request)
        }catch{
            print(error)
        }
    }
    func checkUser(){
        print(userArray.count)
        for i in 0..<userArray.count{
            if userName == userArray[i].email && password == userArray[i].password{
                firstName = userArray[i].firstName!
                lastName = userArray[i].lastName!
                phoneNo = userArray[i].phoneNo!
                performSegue(withIdentifier: "home", sender: self)
            }else{
                let alert = UIAlertController(title: "Login", message: "Username or Password is wrong please try again", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
                    
                }
                let cancel = UIAlertAction(title: "Exit", style: .default) { (UIAlertAction) in
                    exit(0)
                }
                alert.addAction(action)
                alert.addAction(cancel)
                present(alert,animated: true,completion: nil)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HomeViewController
        vc.firstName = firstName
        vc.lastName = lastName
        vc.phoneNo = phoneNo
        vc.email = userName
        vc.password = password
    }
    
    @IBAction func signupBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "signup", sender: self)
    }
}

