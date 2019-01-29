//
//  APIRequestManager.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import UIKit

typealias ServerResponse = (_: Any?, _: Bool?, _: Error?) -> Void

enum RequestType: String {
    case RequestTypeGet = "GET"
    case RequestTypePost = "POST"
    case RequestTypePut = "PUT"
    case RequestTypeDelete = "DELETE"
}

class APIRequestManager: NSObject {
    
    static let apiRequestManager = APIRequestManager()
    
    func apiCall<T>(url: URL, httpType: RequestType, header: [String: String]?, params: [String: AnyObject]?, modelType: T.Type, responseObj: @escaping (ServerResponse)) -> Void  where T:(Decodable) {
        
        if Reachability.isConnectedToNetwork() == false {
            responseObj(nil, false, APIError.connectionError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpType.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = header {
            request.allHTTPHeaderFields = headers
        }
        
        if let parameter = params {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else  {
                return
            }
            request.httpBody = httpBody
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    let dataModel = try decoder.decode(modelType, from: responseData)
                    responseObj(dataModel, true, nil)
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    responseObj(json, true, nil)
                } catch {
                    responseObj(nil, false, error.localizedDescription as? Error ?? APIError.parsingError)
                }
            }
        }.resume()
    }
}
