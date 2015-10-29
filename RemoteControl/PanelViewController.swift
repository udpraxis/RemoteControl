//
//  PanelViewController.swift
//  RemoteControl
//
//  Created by UDLab on 26/10/15.
//  Copyright © 2015 UDLab. All rights reserved.
//

import UIKit

class PanelViewController: UIViewController {

    var mainBrain = RemoteControlBrain()
    
    private var redledOn = false
    private var blueledOn = false
    private var greenledOn = false
    
    @IBAction func red_action_btn(sender: UIButton) {
        
        if !redledOn{
            updateParcelManager(ObjectName: "Red", ValueInt: 255)
        }else{
            updateParcelManager(ObjectName: "NRed", ValueInt: 0)
        }
        
    }
    @IBAction func blue_action_btn(sender: UIButton) {
        if !redledOn{
            updateParcelManager(ObjectName: "Blue", ValueInt: 255)
        }else{
            updateParcelManager(ObjectName: "NBlue", ValueInt: 0)
        }
    }
    @IBAction func green_action_btn(sender: UIButton) {
        if !redledOn{
            updateParcelManager(ObjectName: "Green", ValueInt: 255)
        }else{
            updateParcelManager(ObjectName: "NGreen", ValueInt: 0)
        }
    }
    
    private func updateParcelManager(ObjectName name:String, ValueInt value:Int){
            
            mainBrain.parcelManager(Message:"command", nameofObject: name, value: value)
        
    }
}

