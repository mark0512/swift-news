//
//  NewsListViewController.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-20.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let service = NewsListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        self.showSpinner(onView: self.view)
        service.fetchArticles { [weak self] error in
            guard let self = self else { return }
            self.removeSpinner()
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - setup tableview
private extension NewsListViewController {
    func setUpTableView() {
        tableView.removeFooter()
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = service.article(atIndexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTitleTableViewCell", for: indexPath) as? ImageTitleTableViewCell else {
             return UITableViewCell()
        }
        cell.titleLabel?.text = article.title
        if article.hasThumbnail {
            cell.thumbnailView?.getImage(urlString: article.thumbnail) {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        return cell
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = service.article(atIndexPath: indexPath)
        let storyboard = UIStoryboard(name: "NewsDetailViewController", bundle: nil)

        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else {
            return
        }
        
        detailVC.service = NewsDetailService(article)
        self.show(detailVC, sender: nil)
    }
}

