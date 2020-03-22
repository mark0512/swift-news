//
//  NewsListViewController.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-20.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let service = NewsListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        service.fetchArticles { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")

        tableView.register(UINib(nibName: "ImageTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTitleTableViewCell")
    }
}

// MARK: - UITableViewDataSource
extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.numberOfArticles
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = service.article(atIndexPath: indexPath)
        
        if article.hasThumbnail {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTitleTableViewCell", for: indexPath) as? ImageTitleTableViewCell else {
                return UITableViewCell()
            }
            
            cell.titleLabel?.text = article.title
            cell.thumbnailView?.getImage(url: article.thumbnail) 
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else {
                return UITableViewCell()
            }
            cell.titleLabel?.text = article.title
            return cell
        }
    }
}

