//
//  JoinViewController.swift
//  RemoteControl
//
//  Created by UDLab on 26/10/15.
//  Copyright © 2015 UDLab. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {
    
    var mainBrain = RemoteControlBrain()
    
    
    //Outlet Variable
   
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var ip_address: UITextField!
    @IBOutlet weak var port_input: UITextField!
    @IBOutlet weak var join_btn: UIButton!
    @IBOutlet weak var disconnect: UIButton!
    
    @IBAction func disconnect(sender: UIButton) {
        mainBrain.stoptcpConnection()
        if mainBrain.isConnected{
            print("Disconnect is not working")
        }
        else
        {
            print("Disconnect is working")
            self.disconnect.hidden = true
        }
    }
    @IBAction func join_btn(sender: UIButton) {
    
        
        // in this funtion the connection to the tcp connection is initialised
    mainBrain.starttcpConnection(address:stringChecking(ip_address.text!) ,Port:stringtoInt(port_input.text!) )
        if mainBrain.isConnected{
            self.status.hidden = false
            status?.text = "Connected"
            status?.textColor = UIColor.greenColor()
            self.join_btn.hidden = true
            self.disconnect.hidden = false
            
            
        }
        else{
            status?.text = " Not Connected"
            status?.textColor = UIColor.redColor()
            self.join_btn.hidden = false
            self.disconnect.hidden = true
        }
    }
    
    
    private func stringtoInt(word : String) ->Int{
        if word.isEmpty{
            return 0
        }
        else{
            var interger = Int(word)
            return interger!
        }
        
    }
    
    private func stringChecking(word:String) -> String{
        if word.isEmpty{
            return "Empty"
            
        }
        else{
            return word
        }
    }
    
   
}
