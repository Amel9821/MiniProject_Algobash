//
//  LoginPage.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import UIKit

class LoginPage: UIViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func actionLogin(_ sender: Any) {
            APICaller.shared.login(email: tfEmail.text!, password: tfPassword.text!) { isSuccess, message in
                if isSuccess == true {
                    print("Sukses")

                } else if isSuccess == false {
                    print("Login failed")
                }
            }
        
    }
    

  
}
