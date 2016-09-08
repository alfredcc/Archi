//
//  Repos.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import Foundation

//"repo": {
//    "id": 39185018,
//    "name": "torodev/forPR",
//    "url": "https://api.github.com/repos/torodev/forPR"
//}

struct Repos {
    var content: [Repo]
}

extension Repos: JSONAbleType {
    
    static func fromJSON(rawValue: AnyObject?) -> Repos? {
        if let rawRepos = rawValue as? [JSONDictionary] {
            
            var repos = Array<Repo>()
            
            for rawRepo in rawRepos {
                if let repo = Repo.fromJSON(rawRepo["repo"] as? JSONDictionary) {
                    repos.append(repo)
                }
                
            }
            return Repos(content: repos)
        }
        return nil
    }
}

struct Repo {
    
    let id: Int
    let name: String
    let url: String
}

extension Repo: JSONAbleType {
    
    static func fromJSON(rawValue: AnyObject?) -> Repo? {
        guard let
            repo = rawValue as? JSONDictionary,
            id = repo["id"] as? Int,
            name = repo["name"] as? String,
            url = repo["url"] as? String else {
                return nil
        }
        
        return Repo(id: id, name: name, url: url)
    }

}

