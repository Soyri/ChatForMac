//
//  ViewController.swift
//  ChatForMac
//
//  Created by Admin on 27/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SwiftSocket

class ViewController: UIViewController {
    
    //@IBAction func playVideo(_ sender: UIButton) {
        /*//action from StartVideo button
        
        guard let url = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8") else {
            return
        }
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        
        // Modally present the player and call the player's play() method when complete.
        present(controller, animated: true) {
            player.play()
        }
        */
   /// }
    
    //@IBOutlet weak var buttonPress_ListenButton: UIButton!
    //@IBOutlet weak var buttonPress_ConnectButton: UIButton!
    //@IBOutlet weak var buttonPress_StartVideoButton: UIButton!
    
    @IBAction func buttonPress_ListenButton(_ sender: UIButton) {
        
   
        let server = TCPServer(address: "127.0.0.1", port: 8080)
        switch server.listen() {
        case .success:
            while true {
                if var client = server.accept() {
                    echoService(client: client)
                } else {
                    print("accept error")
                }
            }
        case .failure(let error):
            print(error)
        }
      
        
        
    }
    
    
    //Client connect callback
    func echoService(client: TCPClient) {
        print("Newclient from:\(client.address)[\(client.port)]")
        var d = client.read(1024*10)
        client.send(data: d!)
        client.close()
    }
    
    @IBAction func buttonPress_ConnectButton(_ sender: Any) {
        let client = TCPClient(address: "www.apple.com", port: 80)
        switch client.connect(timeout: 1) {
        case .success:
            switch client.send(string: "GET / HTTP/1.0\n\n" ) {
            case .success:
                guard let data = client.read(1024*10) else { return }
                
                if let response = String(bytes: data, encoding: .utf8) {
                    print(response)
                }
            case .failure(let error):
                print(error)
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

