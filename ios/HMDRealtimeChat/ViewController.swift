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
    
    let manager = SocketManager(socketURL: URL(string: "http://192.168.1.15:5000")!,
                                config: [.log(false),
                                         .compress
        ])
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        textview.text = ""
        
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) {data, ack in
            self.updateTextView(text: "connected successful")
            
            self.socket.emit("connectUser", with: ["khoinguyen"])
        }
        
        socket.on("chat") {data, ack in
            print(data)
            guard let cur = data[0] as? String else { return }
            self.updateTextView(text: cur)
        }
        
        socket.on("connectUser") { (data, ack) in
            print(data)
        }
        
        socket.connect()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPressed(){
        socket.emit("chat", with: [textfield.text!])
    }

    func updateTextView(text: String){
        var currentText = textview.text
        currentText = currentText?.appending("\n" + text)
        textview.text = currentText
    }

}

