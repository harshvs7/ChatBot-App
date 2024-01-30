//
//  APICaller.swift
//  ChatGPTChatBot
//
//  Created by Harshvardhan Sharma on 11/12/2023.
//

import Foundation

@frozen enum Constants {
    
    static let url = "http://localhost:8080/api/chat"
}

final class APICaller {
    
    static let shared = APICaller()
    
    func getResponse(with message: String, successCallBack: @escaping (ChatResponse?) -> Void, failureCallBack: @escaping (_ errorString: String) -> Void){
        guard let apiUrl = URL(string: Constants.url) else { return }
        let chatQuery = ChatQuery(message: message)
        guard let uploadData = try? JSONEncoder().encode(chatQuery) else {
            print("error in conversion")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = uploadData

        let session = URLSession.shared
        let _: Void = session.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data {
                    let apiData = try JSONDecoder().decode(ChatResponse.self, from: data)
                    successCallBack(apiData)
                } else { failureCallBack("unknown error") }
            } catch {
                failureCallBack("\(error)")
            }
        }.resume()
        
    }
    
}
