//
//  PhotosTableViewCell.swift
//  tabbar-journal
//
//  Created by Joel Shin on 1/28/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    // JWS created a var
    weak var dataTask: NSURLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
