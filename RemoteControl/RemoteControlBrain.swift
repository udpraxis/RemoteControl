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
    
    var tcpclient = TCPClient?()
    
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
    func parcelManager(Message msg :String , nameofObject name:String,value:Int ){
        
            if msg == "iam"{
                tcpclient!.send(str:"\(msg):\(name)")
            }else
                if msg == "command"{
                        tcpclient!.send(str: "\(msg):\(name)=\(value)")
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
    
    
    //Read the Message from the server with the length of msg expected
    func readmsgfromserver(msglength:Int)->String{
        let int_msg = tcpclient!.read(msglength)
        
        if int_msg!.isEmpty {
            if underDevelopment{
                print("The funtion readmsgfromServer is wrong")
            }
            return "no message recieved"
            
            
        }else{
            var msg = " "
            
            for x in int_msg!{
                 msg.append((UnicodeScalar(x)))
            }
            
            if underDevelopment{
                print("The real message from the server is \(int_msg)")
                print("the converted message is:\(msg)")
                
            }
            
            //This is done because somehow the msg is having a space as the first character
            let right_msg = String(msg.characters.dropFirst())
            
            return right_msg
            }
        }
    
    
    func firstVerification(){
        self.parcelManager(Message: "iam", nameofObject: getclientID(),value: 0)
        let msg = readmsgfromserver(7)
        
        if msg == "success"{
            clientNameVerified = true
        }else{
            clientNameVerified = false
            print("ClientnameVerification is still false")
        }
        
    }

}
    
    

