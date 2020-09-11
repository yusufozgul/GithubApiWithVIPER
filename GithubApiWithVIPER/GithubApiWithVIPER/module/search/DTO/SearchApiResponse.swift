//
//  SearchApiResponse.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 15.05.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import Foundation

struct SearchApiResponse: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Repo]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}

struct Repo: Codable {
    let name: String
    let fullName: String
    let owner: Owner
    let itemDescription: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forksCount: Int
    let license: License?
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case owner = "owner"
        case itemDescription = "description"
        case size = "size"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language = "language"
        case forksCount = "forks_count"
        case license = "license"
        case forks = "forks"
        case openIssues = "open_issues"
        case watchers = "watchers"
        case defaultBranch = "default_branch"
    }
}

struct License: Codable {
    let key: String
    let name: String
    let spdxId: String
    let url: String?
    let nodeId: String

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case name = "name"
        case spdxId = "spdx_id"
        case url = "url"
        case nodeId = "node_id"
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url: String
    let htmlUrl: String
    let followersUrl: String
    let followingUrl: String
    let gistsUrl: String
    let starredUrl: String
    let subscriptionsUrl: String
    let organizationsUrl: String
    let reposUrl: String
    let eventsUrl: String
    let receivedEventsUrl: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url = "url"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
    }
}
