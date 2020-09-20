//
//  GithubApiWithVIPERTests.swift
//  GithubApiWithVIPERTests
//
//  Created by Yusuf Özgül on 19.09.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import XCTest
@testable import GithubApiWithVIPER

/// test cases for repo search module
class GithubApiWithVIPERTSearchModuleests: XCTestCase {
    private var presenter: GithubSearchPresenter!
    private var interactor: GithubSearchInteractor!
    private var view: MockView!
    private var router: MockRouter!
    
    override func setUp() {
        interactor = GithubSearchInteractor()
        view = MockView()
        router = MockRouter()
        presenter = .init(view: view, interactor: interactor, router: router)
        view.presenter = presenter
    }
    
    func testSetPrepareUI() {
        view.viewdidLoad()
        XCTAssertEqual(view.prepareUICounts, 1)
    }
    
    func testErroredSearch() {
        presenter.handleSearchResult(with: .failure(.urlEncode))
        if view.errors.count == 1 {
            XCTAssertEqual(view.errors[0], GithubApiError.urlEncode.localizedDescription)
        } else {
            XCTFail("View: Unexpected error count")
        }
    }
    
    func testData() throws {
        let data = try ResourceLoader().loadSearch(resource: .swift)
        presenter.handleSearchResult(with: .success(data))
        
        if view.dataSources.count == 1 {
            XCTAssertEqual(view.dataSources[0].numberOfSections, 1)
            XCTAssertEqual(view.dataSources[0].numberOfItems, 30)
            XCTAssertEqual(view.dataSources[0].numberOfItems(inSection: .repo), 30)
        } else {
            XCTFail("View: Unexpected data count")
        }
    }
    
    func testSelectRepo() throws {
        let data = try ResourceLoader().loadSearch(resource: .swift)
        presenter.handleSearchResult(with: .success(data))
        presenter.selectRepo(at: IndexPath(row: 0, section: 0))
        
        if router.repoNames.count == 1 {
            XCTAssertEqual(router.repoNames[0], data.items.first?.fullName)
        } else {
            XCTFail("Router: Unexpected count of calls")
        }
    }
}

private class MockView: GithubSearchViewInterface {
    private typealias DataSource = UICollectionViewDiffableDataSource<RepoListSection, SearchResultData>
    
    var presenter: GithubSearchPresenterInterface!
    var dataSources: [SearchRepoSnapshot] = []
    var errors: [String] = []
    var prepareUICounts = 0
    
    func viewdidLoad() {
        presenter.viewDidLoad()
    }
    
    func prepareUI() {
        prepareUICounts += 1
    }
    
    func search(keyword: String) {
        presenter.searchBarTextDidChange(text: keyword)
    }
    
    func showData(with snapshot: SearchRepoSnapshot) {
        dataSources.append(snapshot)
    }
    
    func showError(with description: String) {
        errors.append(description)
    }
}

private class MockRouter: GithubSearchRouterInterface {
    var repoNames: [String] = []
    func navigateToRepoDetail(to repoName: String) {
        repoNames.append(repoName)
    }
}
