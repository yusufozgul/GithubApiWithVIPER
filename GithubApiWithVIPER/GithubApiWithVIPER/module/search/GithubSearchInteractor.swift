//
//  GithubSearchInteractor.swift
//  GithubApiWithVIPER
//
//  Created by Ahmet Keskin on 9.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

protocol GithubSearchInteractorInterface: class {
    func search(with text: String)
}

class GithubSearchInteractor {
    
}

extension GithubSearchInteractor: GithubSearchInteractorInterface {
    func search(with text: String) {
        
    }
}
