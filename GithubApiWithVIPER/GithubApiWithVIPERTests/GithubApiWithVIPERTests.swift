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
class SearchModule_Presenter_Test: XCTestCase {
    private var presenter: GithubSearchPresenter!
    private var interactor: MockInteractor!
    private var view: MockView!
    private var router: MockRouter!
    
    override func setUp() {
        interactor = MockInteractor()
        view = MockView()
        router = MockRouter()
        presenter = .init(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.output = presenter
    }
    
    func test_SetPrepareUI() {
        view.viewdidLoad()
        XCTAssertEqual(view.prepareUICounts, 1)
    }
    
    func test_SearchWithKey_ShouldCheckIncomingKey() {
        let searchKey = "swift"
        view.search(keyword: searchKey)
        if interactor.searchKeys.count == 1 {
            XCTAssertEqual(interactor.searchKeys[0], searchKey)
        } else {
            XCTFail("Interactor: Unexpected error count")
        }
    }
    
    func test_HandleSearchResult_Failure_ShouldInvokeShowError() {
        interactor.output?.handleSearchResult(with: .failure(.urlEncode))
        if view.errors.count == 1 {
            XCTAssertEqual(view.errors[0], GithubApiError.urlEncode.localizedDescription)
        } else {
            XCTFail("View: Unexpected error count")
        }
    }
    
    func test_HandleSearchResult_Success_ShouldCheckDataSource() throws {
        view.search(keyword: "swift")
        
        XCTAssertEqual(presenter.searchRepoResult.count, 30)
        
        if view.dataSources.count == 1 {
            XCTAssertEqual(view.dataSources[0].numberOfSections, 1)
            XCTAssertEqual(view.dataSources[0].numberOfItems, 30)
            XCTAssertEqual(view.dataSources[0].numberOfItems(inSection: .repo), 30)
        } else {
            XCTFail("View: Unexpected data count")
        }
    }
    
    func test_SelectFirstRepo_ShouldCheckRouterInput() throws {
        view.search(keyword: "swift")
        presenter.selectRepo(at: IndexPath(row: 0, section: 0))
        
        guard let selectedData = view.dataSources.first?.itemIdentifiers(inSection: .repo).first else {
            XCTFail("View: Selected Data Not Found")
            return
        }
        
        if router.repoNames.count == 1 {
            XCTAssertEqual(router.repoNames[0], selectedData.fullName)
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

private class MockInteractor: GithubSearchInteractorInterface {
    weak var output: GithubSearchInteractorOutput?
    var searchKeys: [String] = []
    
    func search(with text: String) {
        searchKeys.append(text)
        if text == "swift" {
            if let data = try? ResourceLoader().loadSearch(resource: .swift) {
                output?.handleSearchResult(with: .success(data))
            } else {
                output?.handleSearchResult(with: .failure(.network(errorMessage: "DATA_NOT_LOAD")))
            }
            
        } else {
            output?.handleSearchResult(with: .failure(.network(errorMessage: "NOT_FOUND")))
        }
    }
}
