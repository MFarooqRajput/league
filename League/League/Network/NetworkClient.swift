//
//  NetworkClient.swift
//  League
//
//  Created by Muhammad Farooq on 2021-02-18.
//

import Foundation

class NetworkClient {
    
    class func makeCall<T: Decodable>(with suffixURL: SuffixURL,
                                      params: [String: String]? = nil,
                                      completionHandler completion:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        guard var urlComponents = URLComponents(string: "\(Constants.apiBaseUrl)\(suffixURL.rawValue)") else {
            completion(nil, ResponseError.invalidURL)
                    return
        }
        
        var queryItems: [URLQueryItem] = []
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
                
        guard let url = urlComponents.url else {
            completion(nil, ResponseError.invalidURL)
            return
        }
        
        debugPrint(url)
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, ResponseError.requestFailed)
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        
                        do {
                            let jsonObj = try JSONDecoder().decode(T.self, from: data)
                            completion(jsonObj, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, ResponseError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
}



