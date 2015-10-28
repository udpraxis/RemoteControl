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
    private var clientNameVerified = false
    
    private var ID:String = ""
    
    
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
    
    
    //This function deals with the command send action from clientto the server
    func sendcommandtoserver(Command command :String){
        
        if clientNameVerified {
            let comm_compiling:String = "command:\(command)/r/n"
            tcpclient?.send(str: comm_compiling)
        }
        else{
            firstVerification()
            sleep(2)
            tcpclient?.send(str: "command:\(command)/r/n")
        }
        
    }
    
    func setClientID(name:String){
        if name.isEmpty{
            ID = "Guess"
        }
        else{
            ID = name
        }
        
    }
    
    private func getclientID()-> String{
        
        if ID.isEmpty{
            ID = "Guess"
            return ID
        }
        else{
            return ID
        }
        
    }
    
    func readmsgfromserver(msglength:Int)->String{
        let int_msg = tcpclient?.read(msglength)
        if int_msg!.isEmpty {
            if underDevelopment{
                print("The funtion readmsgfromServer is wrong")
            }
            return "no message recieved"
        }
        else{
             let msg = String(int_msg)
            return msg
        }
    }
    
    
    func firstVerification(){
        tcpclient?.send(str: "iam:\(getclientID())")
        let msg = readmsgfromserver(12)
        
        if msg == "Success"{
            clientNameVerified = true
        }else{
            clientNameVerified = false
        }
        
    }
    
}