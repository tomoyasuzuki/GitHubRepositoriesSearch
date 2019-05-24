
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let gitHubSearchRepository = try? newJSONDecoder().decode(GitHubSearchRepository.self, from: jsonData)

import Foundation

// MARK: - GitHubSearchRepositoryElement
struct GitHubSearchRepositoryElement: Codable {
    let id: Int
    let nodeId, name, fullName: String?
    let gitHubSearchRepositoryPrivate: Bool?
    let owner: Owner
    let htmlUrl: String?
    let gitHubSearchRepositoryDescription: String?
    let fork: Bool?
    let url, forksUrl: String?
    let keysUrl, collaboratorsUrl: String?
    let teamsUrl, hooksUrl: String?
    let issueEventsUrl: String?
    let eventsUrl: String?
    let assigneesUrl, branchesUrl: String?
    let tagsUrl: String?
    let blobsU, gitTagsUrl, gitRefsUrl, treesUrl: String?
    let statusesUrl: String?
    let languagesUrl, stargazersUrl, contributorsUrl, subscribersUrl: String?
    let subscriptionURL: String?
    let commitsUrl, gitCommitsUrl, commentsUrl, issueCommentUrl: String?
    let contentsrlL, compareUrl: String?
    let mergesUrl: String?
    let archiveUrl: String?
    let downloadsUrl: String?
    let issuesUrl, pullsUrl, milestonesUrl, notificationsUrl: String?
    let labelsUrl, releasesUrl: String?
    let deploymentsUrl: String?
    let createdAt, updatedAt, pushedAt: Date?
    let gitUrl, sshUrl: String?
    let cloneUrl: String?
    let svnUrl: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages: Bool?
    let forksCount: Int?
    let mirrorUrl: String?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    let license: License?
    let forks, openIssues, watchers: Int?
    let defaultBranch: DefaultBranch?
    
}

enum DefaultBranch: String, Codable {
    case master = "master"
}

// MARK: - License
struct License: Codable {
    let key, name, spdxId: String?
    let url: String?
    let nodeId: String?
}

// MARK: - Owner
struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeid: String?
    let avatarUrl: String?
    let gravatarId: String?
    let url, htmlUrl, followersUrl: String?
    let followingUrl: String?
    let gistsUrl: String?
    let starredUrl: String?
    let subscriptionsUrl, organizationsUrl, reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: String?
    let siteAdmin: Bool?
}

typealias GitHubSearchRepository = [GitHubSearchRepositoryElement]


