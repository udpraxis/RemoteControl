//
//  AppDelegate.swift
//  RemoteControl
//
//  Created by UDLab on 26/10/15.
//  Copyright © 2015 UDLab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //form a variable of TCPClient
    var tcpclient = TCPClient()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        var(success,_) = tcpclient.close()
        //DEBUG _DELETE Before Relesing 
        if success{
            print("The client connection to the server is terminated")
        }
        else{
            print("The client connection to the server is not terminated")
        }
    }
    
    func initiateTCPconnection(IPAddress addr : String, portnumber port:Int)
    {
        tcpclient = TCPClient(addr: addr, port: port)
        
        var(success,error) = tcpclient.connect(timeout: 1)
        
        //DEBUG
        if success{
            print("Connection is succesful")
        }
        else
        {
            print(error)
        }
    }
    
    func messageRecieveManager(lengthofthemessage msglength : Int)-> String{
        let int_msg = tcpclient.read(msglength)
        
        if int_msg!.isEmpty {
            return "no message recieved"
        }else{
            var msg = " "
            
            for x in int_msg!{
                msg.append((UnicodeScalar(x)))
            }

            //This is done because somehow the msg is having a space as the first character
            let right_msg = String(msg.characters.dropFirst())
            
            return right_msg
        }
    }
    
    func commandSendManager(Message msg :String , nameofObject name:String,value:Int){
        if msg == "iam"{
                tcpclient.send(str:"\(msg):\(name)")
        }else if msg == "command"{
            tcpclient.send(str: "\(msg):\(name)=\(value)")
        }
    }
}




