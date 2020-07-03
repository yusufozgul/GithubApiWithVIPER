//
//  SearchResultData.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 3.07.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

struct SearchResultData: Identifiable, Hashable {
    let id: Int
    let name: String
    let starCount: Int
    let watchCount: Int
    let language: String?
    let ownerAvatarUrl: String
    let ownerUserName: String
}
