//
//  RepoDetailVC.swift
//  GithubApiWithVIPER
//
//  Created by Yusuf Özgül on 12.07.2020.
//  Copyright © 2020 Yusuf Özgül. All rights reserved.
//

import UIKit
import MarkdownView

protocol RepoDetailViewInterface: class {
    func prepareUI()
    func showRepoDetail(with repo: Repo)
    func showMarkDown(md: String)
}

class RepoDetailVC: UIViewController {
    
    @IBOutlet weak var markdownView: MarkdownView!
    @IBOutlet weak var startsCount: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: RepoDetailPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension RepoDetailVC: RepoDetailViewInterface {
    
    func prepareUI() {
        
    }
    
    func showRepoDetail(with repo: Repo) {
        DispatchQueue.main.async {
            
            self.startsCount.text = String(repo.stargazersCount)
            self.watchersCount.text = String(repo.watchers)
            self.forksCount.text = String(repo.forksCount)
            self.descriptionLabel.text = repo.itemDescription
        }
    }
    
    func showMarkDown(md: String) {
        DispatchQueue.main.async {
            self.markdownView.load(markdown: md)
        }
    }
}
