//
//  ViewController.swift
//  Sign In Sign Up
//
//  Created by Rishav Pandey on 21/12/16.
//  Copyright © 2016 AviaBird. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var signupLabel: UILabel!
    @IBOutlet var ageText: UITextField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var successfulLabel: UILabel!
    @IBOutlet var signupButtonOutlet: UIButton!
    @IBOutlet var logOutOutlet: UIButton!
    @IBAction func logoutButton(_ sender: AnyObject) {
        emailText.isHidden = false
        button.isHidden = false
        successfulLabel.isHidden = true
        signupLabel.isHidden = true
        signupButtonOutlet.isHidden = true
        logOutOutlet.isHidden = true
        ageText.isHidden = true
        passwordText.isHidden = true
        label1.isHidden = true
        emailText.text = ""
        flag = 0
        let p = UserDefaults.standard.object(forKey: "Session")
        var session:[String]
        if let item = p as? [String] {
            session = item
            session.append("0")
        } else {
            session = ["0"]
        }
        UserDefaults.standard.set(session, forKey: "Session")
    }
    @IBAction func signupButton(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue("\(emailText.text!)", forKey: "email")
        newUser.setValue("\(passwordText.text!)", forKey: "password")
        newUser.setValue(Int(ageText.text!), forKey: "age")
        do {
            try context.save()
            successfulLabel.isHidden = false
            emailText.isHidden = true
            button.isHidden = true
            label1.isHidden = true
            signupLabel.isHidden = true
            ageText.isHidden = true
            passwordText.isHidden = true
            signupButtonOutlet.isHidden = true
            logOutOutlet.isHidden = false
        } catch {
            successfulLabel.isHidden = false
            successfulLabel.text = "Something Went Wrong"
        }
    }
    var flag = 0
    @IBOutlet var button: UIButton!
    @IBOutlet var label1: UILabel!
    
    @IBAction func search(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do {
//            print(emailText.text!)
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    let email = result.value(forKey: "email") as? String
                    if email == emailText.text! {
                        flag = 1
                        break
                    }
                }
                if flag == 1 {
                    emailText.isHidden = true
                    button.isHidden = true
                    label1.isHidden = false
                    logOutOutlet.isHidden = false
                    signupButtonOutlet.isHidden = true
                    let p = UserDefaults.standard.object(forKey: "Session")
                    var session:[String]
                    if let item = p as? [String] {
                        session = item
                        session.append("\(emailText.text!)")
                    } else {
                        session = ["\(emailText.text!)"]
                    }
                    UserDefaults.standard.set(session, forKey: "Session")
                } else {
                    emailText.isHidden = true
                    button.isHidden = true
                    label1.isHidden = true
                    signupLabel.isHidden = false
                    ageText.isHidden = false
                    passwordText.isHidden = false
                    signupButtonOutlet.isHidden = false
                    ageText.text = ""
                    passwordText.text = ""
                    let p = UserDefaults.standard.object(forKey: "Session")
                    var session:[String]
                    if let item = p as? [String] {
                        session = item
                        session.append("\(emailText.text!)")
                    } else {
                        session = ["\(emailText.text!)"]
                    }
                    UserDefaults.standard.set(session, forKey: "Session")
                }
            } else {
                emailText.isHidden = true
                button.isHidden = true
                label1.isHidden = true
                signupLabel.isHidden = false
                ageText.isHidden = false
                ageText.text = ""
                passwordText.isHidden = false
                passwordText.text = ""
                signupButtonOutlet.isHidden = false
                let p = UserDefaults.standard.object(forKey: "Session")
                var session:[String]
                if let item = p as? [String] {
                    session = item
                    session.append("\(emailText.text!)")
                } else {
                    session = ["\(emailText.text!)"]
                }
                UserDefaults.standard.set(session, forKey: "Session")
            }
        } catch {
            label1.isHidden = false
            label1.text = "An Error Occured"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let check = UserDefaults.standard.object(forKey: "Session")
        var chechLast: [String]
        if let temp = check as? [String]{
            chechLast = temp
            if chechLast.last != "0" {
                emailText.isHidden = true
                button.isHidden = true
                label1.isHidden = false
                logOutOutlet.isHidden = false
                signupButtonOutlet.isHidden = true
                ageText.isHidden = true
                passwordText.isHidden = true
                successfulLabel.isHidden = true
                signupLabel.isHidden = true

            }else {
                logOutOutlet.isHidden = true
                label1.isHidden = true
                successfulLabel.isHidden = true
                signupLabel.isHidden = true
                ageText.isHidden = true
                passwordText.isHidden = true
                signupButtonOutlet.isHidden = true
            }
        }else {
            logOutOutlet.isHidden = true
            label1.isHidden = true
            successfulLabel.isHidden = true
            signupLabel.isHidden = true
            ageText.isHidden = true
            passwordText.isHidden = true
            signupButtonOutlet.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

