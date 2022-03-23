//
//  server.swift
//  M2Band
//
//  Created by Luke Fanizzi on 12/29/21.
//

import Foundation
import SwiftUI
class Server {
    func Main(){
    let servicePort = "1234"

 
    print("Welcome to our simple echo server!")

    var server = Server()
    server.start()
    server.socket_create()
        
    RunLoop.main.run()
    exit(EXIT_SUCCESS)

    }
    
    
    func start() {
      print("Server starting...")
    }
    func socket_create(){
        let socketFD = socket(AF_INET6, //Domain e.g. [AF_INET,AF_INET6, AF_UNIX]
                               SOCK_STREAM, //Type e.g. [SOCK_STREAM, SOCK_DGRAM, SOCK_SEQPACKET, SOCK_RAW]
                               IPPROTO_TCP  //Protocol e.g. [IPPROTO_TCP, IPPROTO_SCTP, IPPROTO_UDP, IPPROTO_DCCP]
                               )//Return a FileDescriptor -1 = error
         if socketFD == -1 {
           print("Error creating BSD Socket")
           return
         }
    }
    
}

