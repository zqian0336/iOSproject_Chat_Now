//
//  ContactsViewController.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/24/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework
import MessageKit
import FirebaseFirestore


class ChatViewController: MessagesViewController {
    
    private let userData = Firestore.firestore()
    private var reference: CollectionReference?

    //Get Message Struct from model/Message.swift
    private var messages: [Message] = []
    private var receiver: ListenerRegistration?
    
    //User Struct from Message.swift
    private let user: User
    private let channel: Channel
    
    deinit {
        receiver?.remove()
    }
    
    //==========init of class [Constructor]====
    init(user: User, channel: Channel) {
        self.user = user
        self.channel = channel
        super.init(nibName:nil, bundle:nil) // When default
        
        title = channel.name
    }
    //======require init, warning from Xcode===
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //===========
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = channel.id else {
            navigationController?.popViewController(animated: true)
            return
        }
        
    //========
    //retrieve message
        reference = userData.collection(["channels", id,"thread"].joined(separator:"/"))
        receiver = reference?.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("error! cannot update")
                return
            }
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
    //===================
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .myColor
        messageInputBar.sendButton.setTitleColor(.myColor, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
    }
    
    //=====================
    //send message
    func send(_ message: Message){
        reference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("error during sending message:\(e.localizedDescription)")
                return
            }
            self.messagesCollectionView.scrollToBottom()
        }
        print(message)
        print("----->Message is sent")
        
    }// show which message is failed
        
    func addNewMessage(_ message: Message) {
        guard !messages.contains(message) else {
            return
        }
        messages.append(message)
        messages.sort()
        let isLatestMessage = messages.index(of: message) == (messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage

        messagesCollectionView.reloadData()

        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
        
        print("-------->new message is added")
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        guard var message = Message(document: change.document) else {
            return
        }

        switch change.type {
        case .added:
            addNewMessage(message)

        default:
            break
        }
    }
//    private func handleDocumentChange(_ change: DocumentChange) {
//        guard var message = Message(document: change.document) else {
//            return
//        }
//
//        switch change.type {
//        case .added:
//            if let url = message.downloadURL {
//                downloadImage(at: url) { [weak self] image in
//                    guard let `self` = self else {
//                        return
//                    }
//                    guard let image = image else {
//                        return
//                    }
//
//                    message.image = image
//                    self.insertNewMessage(message)
//                }
//            } else {
//                insertNewMessage(message)
//            }
//
//        default:
//            break
//        }
//    }
    
}



extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .myColor : .yourColor
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
}

// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    func currentSender() -> Sender {
        return Sender(id: user.uid, displayName: AppSettings.displayName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = Message(user: user, content: text)
        
        send(message)
        inputBar.inputTextView.text = ""
    }
    
}



