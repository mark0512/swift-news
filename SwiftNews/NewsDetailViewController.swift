//
//  NewsDetailViewController.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-23.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var service: NewsDetailService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView.removeFooter()
    }
}

extension NewsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailTableViewCell", for: indexPath) as? ImageTitleTableViewCell  else {
            return UITableViewCell()
        }
        
        cell.titleLabel?.text = service.article.desc
        if service.article.hasThumbnail {
            cell.thumbnailView?.getImage(urlString: service.article.thumbnail) {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        
        return cell
    }
}
