//
//  ChatResponse.swift
//  ChatGPTChatBot
//
//  Created by Harshvardhan Sharma on 11/12/2023.
//

import Foundation

struct ChatResponse: Codable {
    let id, object: String
    let created: Int
    let choices: [Choice]
    let usage: Usage
}

// MARK: - Choice
struct Choice: Codable {
    let index: Int
    let message: Messages
    let finishReason: JSONNull?
}

// MARK: - Message
struct Messages: Codable {
    let role, content: String
}

// MARK: - Usage
struct Usage: Codable {
    let messageTokens, tokensLeft, totalTokens: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
