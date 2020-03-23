//
//  ImageTitleTableViewCell.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-20.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

class ImageTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailView.image = nil
    }
}
