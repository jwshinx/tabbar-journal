//
//  ItalyImageFeedItemTableViewCell.swift
//  tabbar-journal
//
//  Created by Joel Shin on 2/1/17.
//  Copyright © 2017 Joel Shin. All rights reserved.
//

import UIKit

class ItalyImageFeedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    weak var dataTask: NSURLSessionDataTask?
    
    override func awakeFromNib() {
        // print("+++> IIFITVCell awakeFromNib")
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        // print("+++> IIFITVCell setSelected")
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
