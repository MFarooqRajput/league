//
//  MatchDetailRepo.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-21.
//

import Foundation

typealias MatchDetailCompletionHandler = (MatchResponse?, Error?) -> Void

class MatchDetailRepo {
    
    func fetchMatchDetail(with suffixURL: SuffixURL, params: [String: String]?, completion: @escaping MatchDetailCompletionHandler) {
        NetworkClient.makeCall(with: suffixURL, params: params, completionHandler: completion)
    }
    
}
