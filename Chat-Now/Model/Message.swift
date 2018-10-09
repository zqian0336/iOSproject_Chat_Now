//
//  Message.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/24/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import Firebase
import MessageKit


struct Message: MessageType {
    var id: String?

    let content: String
    let sentDate: Date
    let sender: Sender
 
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    
 
    init(user: User, content: String) {
        sender = Sender(id:user.uid, displayName: AppSettings.displayName)
        self.content = content
        sentDate = Date()
        id = nil
        }
    
    //To get message from Firebase and show it on screen, QueryDocumentSnapshot
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let sentDate = data["created"] as? Date else {
            return nil
        }
        guard let senderID = data["senderID"] as? String else {
            return nil
        }
        guard let senderName = data["senderName"] as? String else {
            return nil
        }
        
        id = document.documentID
        
        self.sentDate = sentDate
        sender = Sender(id: senderID, displayName: senderName)
        
        if let content = data["content"] as? String {
            self.content = content
        } else {
            return nil
        }
    }
    
 
}

extension Message: DatabaseRepresentation {
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created": sentDate,
            "senderID": sender.id,
            "senderName": sender.displayName
        ]
        
 
            rep["content"] = content
        
        
        return rep
    }
    
}


extension Message: Comparable {
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
}


