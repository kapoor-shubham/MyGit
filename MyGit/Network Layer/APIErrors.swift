//
//  APIErrors.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import UIKit

enum APIError: Error {
    case connectionError
    case unknownError
    case parsingError
    
    var localizedDescription: String {
        switch self {
            case .connectionError: return "No Internet"
            case .unknownError: return "Something went wrong"
            case .parsingError: return "Invalid Response"
        }
    }
}


