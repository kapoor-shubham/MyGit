//
//  UrlList.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import Foundation

func gitURL(page: Int) -> URL {
    return URL(string: "https://api.github.com/users/JakeWharton/repos?page=\(page)&per_page=15")!
}
