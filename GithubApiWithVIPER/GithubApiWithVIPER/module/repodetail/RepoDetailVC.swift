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
    func showRepoDetail(with repo: Repo)
    func showMarkDown(md: String)
    func showError(with description: String)
    func setLoading(to isLoading: Bool)
}

class RepoDetailVC: UIViewController {
    @IBOutlet weak var markdownView: MarkdownView!
    @IBOutlet weak var startsCount: UILabel!
    @IBOutlet weak var watchersCount: UILabel!
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var presenter: RepoDetailPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension RepoDetailVC: RepoDetailViewInterface {
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
    
    func showError(with description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLoading(to isLoading: Bool) {
        DispatchQueue.main.async {
            self.loadingIndicator.isHidden = !isLoading
        }
    }
}
