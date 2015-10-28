//
//  RemoteControlBrain.swift
//  RemoteControl
//
//  Created by UDLab on 26/10/15.
//  Copyright © 2015 UDLab. All rights reserved.
//

import Foundation
import CoreMotion


class RemoteControlBrain
{
    
    private var tcpclient = TCPClient?()
    
    var underDevelopment = true
    
    var isConnected = false
    
    
    //this is the tcp connection connecter
    func starttcpConnection(address addr:String, Port port:Int)
    {
       
        
        tcpclient = TCPClient(addr: addr,port: port)
        
        var (success,error)=tcpclient!.connect(timeout: 1)
        if success{
            
            if underDevelopment{
                print(success)
            }
            
            isConnected = true
            
        }
        else{
            
            if underDevelopment{
                print(error)
            }
            isConnected = false
        }
        
    }
    
    func stoptcpConnection(){
        tcpclient!.close()
    }
    
    func sendcommandtoserver(command)
    
    func gyroreading()
    {
        
    }
    
}