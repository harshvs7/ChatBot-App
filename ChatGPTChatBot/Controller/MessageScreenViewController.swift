//
//  MessageViewController.swift
//  ChatGPTChatBot
//
//  Created by Harshvardhan Sharma on 13/12/2023.
//

import UIKit
import MessageKit
import InputBarAccessoryView


struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class MessageScreenViewController: MessagesViewController, InputBarAccessoryViewDelegate {
    
    //MARK: Variables
    var messages = [MessageType]()
    var apiCaller = APICaller()
    let currentUser = Sender(senderId: "1", displayName: "You")
    let chatBot = Sender(senderId: "2", displayName: "ChatGPT")

    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        apiCall(with: "Hii")

    }
}

//MARK: Functions
extension MessageScreenViewController {
    
    //MARK: Common Functions for pop-up
    func alertPopUp(with title: String, with message: String, with buttonTitle: String){
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: {_ in
                self.dismiss(animated: true)
            }
        )
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: APICaller function
    func apiCall(with text: String) {
        apiCaller.getResponse(with: text) { [weak self] data in
            var result = data?.choices[0].message.content ?? ""
            self?.messages.append(Message(sender: self!.chatBot, messageId: "\(self?.messages.count ?? 0 + 1)", sentDate: Date(), kind: .text(result)))
            DispatchQueue.main.async {
                self?.messagesCollectionView.reloadData()
            }
        } failureCallBack: { error in
            self.alertPopUp(with: "Error", with: "An error occured. Check your internet connection or try again after some time", with: "OK")
        }
    }
}


//MARK: MessageKit Delegates
extension MessageScreenViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate  {
    var currentSender: MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }
        messages.append(Message(sender: self.currentSender, messageId: "\(messages.count + 1)", sentDate: Date(), kind: .text(text)))
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            inputBar.inputTextView.text = ""
        }
        apiCall(with: text)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
            let message = messages[indexPath.section]
            
        if message.sender.senderId == currentUser.senderId {
                avatarView.image = UIImage(named: "userLogo")
            } else {
                avatarView.image = UIImage(named: "ChatBotLogo")
            }
    }
}
 
 
