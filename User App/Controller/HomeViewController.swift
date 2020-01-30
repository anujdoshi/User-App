//
//  HomeViewController.swift
//  User App
//
//  Created by Anuj Doshi on 30/01/20.
//  Copyright © 2020 Anuj Doshi. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var textField = UITextField()
    var pickerArr = ["FirstName","LastName","Email","PhoneNumber","Password"]
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var lastNamelabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    
    var edit:String = ""
    
    var firstName:String = ""
    var lastName:String = ""
    var email:String = ""
    var phoneNo:String = ""
    var password:String = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.text = firstName
        lastNamelabel.text = lastName
        emailLabel.text = email
        phoneNoLabel.text = phoneNo
        passwordLabel.text = password
        view.setGradientColor(colorOne: .black, colorTwo: .white)
    }
    
    @IBAction func editBnt(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Update Details", message: "", preferredStyle: .alert)
        //alert.isModalInPopover = true
        
        let pickerFrame = UIPickerView(frame: CGRect(x: 110, y: 0, width: 140, height: 140))
        pickerFrame.backgroundColor = .clear
        pickerFrame.becomeFirstResponder()
        pickerFrame.dataSource = self
        pickerFrame.delegate = self
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            self.checkUser()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter \(self.edit)"
            self.textField = alertTextField
        }
        alert.view.addSubview(pickerFrame)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Delete", message: "Are You Sure You want to delete?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style:.default) { (UIAlertAction) in
            self.deleteUser()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert,animated: true,completion: nil)
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        exit(0)
    }
    func saveData(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        edit = pickerArr[row]
        print(edit)
    }
    func checkUser(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        do{
            let userCheck = try context.fetch(request)
            print(userCheck.count)
            for i in 0..<userCheck.count
            {
                if email == userCheck[i].email{
                    //let check = userCheck
                    if edit == "FirstName"{
                        
                        userCheck[i].firstName! = textField.text!
                        saveData()
                        successful()
                    }
                    else if edit == "LastName"{
                        
                        userCheck[i].lastName! = textField.text!
                        saveData()
                        successful()
                    }
                    else if edit == "Email"{
                        
                        userCheck[i].email! = textField.text!
                        saveData()
                        successful()
                    }
                    else if edit == "PhoneNumber"{
                        
                        userCheck[i].phoneNo! = textField.text!
                        saveData()
                        successful()
                    }
                    else if edit == "Password"{
                        
                        userCheck[i].password! = textField.text!
                        saveData()
                        successful()
                    }else{
                        errorAlert()
                    }
                }
            }
        }catch{
            print(error)
        }
        
    }
    func loadData(){
        let request : NSFetchRequest<User> = User.fetchRequest()
        do{
            let item = try context.fetch(request)
            for i in 0..<item.count{
                if email == item[i].email{
                    firstNameLabel.text = item[i].firstName
                    lastNamelabel.text = item[i].lastName
                    emailLabel.text = item[i].email
                    phoneNoLabel.text = item[i].phoneNo
                    passwordLabel.text = item[i].password
                }
            }
        }catch{
            print(error)
        }
    }
    func successful(){
        loadData()
        let alert = UIAlertController(title: "Edit", message: "Successfully Updated Details Click ok to continue", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func errorAlert(){
        let alert = UIAlertController(title: "Edit", message: "Something went wrong try again!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func reloadData(){
        self.viewDidLoad()
        self.viewWillAppear(true)
    }
    func deleteUser(){
        let request : NSFetchRequest<User> = User.fetchRequest()
               do{
                   let userCheck = try context.fetch(request)
                   print(userCheck.count)
                   for i in 0..<userCheck.count
                   {
                       if email == userCheck[i].email{
                            context.delete(userCheck[i])
                            successfulDelete()
                            try context.save()
                       }else{
                        errorAlertDelete()
                    }
                    }
               }catch{
                print(error)
        }
    }
    func successfulDelete(){
        let alert = UIAlertController(title: "Delete", message: "Successfully Deleted Account", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            exit(0)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    func errorAlertDelete(){
        let alert = UIAlertController(title: "Delete", message: "Something went wrong try again!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
