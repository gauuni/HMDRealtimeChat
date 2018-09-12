//
//  ViewController.swift
//  DemoSocketIOClient
//
//  Created by Khoi Nguyen on 9/11/18.
//  Copyright © 2018 Khoi Nguyen. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    @IBOutlet private weak var textview: UITextView!
    @IBOutlet private weak var textfield: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        textview.text = ""
        
        
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPressed(){
     
    }

    func updateTextView(text: String){
        var currentText = textview.text
        currentText = currentText?.appending("\n" + text)
        textview.text = currentText
    }

}

