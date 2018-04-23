//
//  ViewController.swift
//  vw
//
//  Created by frida manzana on 4/22/18.
//  Copyright © 2018 gekko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        if dataTask != nil{
            dataTask?.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let usernameStr = username.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let passwordStr = password.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = NSURL(string: "http://www.iroseapps.com/moviles/login.php?username=\(usernameStr)&password=\(passwordStr)")
        let request = URLRequest(url: url! as URL)
        dataTask = defaultSession.dataTask(with: request){
            data, response, error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if let error = error {
                print(error.localizedDescription)
            }
            else{
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200{
                        DispatchQueue.main.async {
                            self.goToCrafter(data: data!)
                        }
                    }
                }
            }
        }
        
        dataTask?.resume()
    }
    
    
    func goToCrafter(data: Data){
        
        
    }
}

