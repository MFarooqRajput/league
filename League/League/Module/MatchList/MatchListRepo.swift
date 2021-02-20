//
//  MatchListRepo.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import Foundation

typealias MatchListCompletionHandler = (Data?, Error?) -> Void

class MatchListRepo {
    
    func fetchMatchList(with suffixURL: SuffixURL, params: [String: String]?, completion: @escaping MatchListCompletionHandler) {
        NetworkClient.makeCall(with: suffixURL, params: params, completionHandler: completion)
    }
}
