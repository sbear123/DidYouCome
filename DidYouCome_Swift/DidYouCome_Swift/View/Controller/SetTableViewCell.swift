//
//  SetTableViewCell.swift
//  DidYouCome_Swift
//
//  Created by 박지현 on 2020/10/29.
//

import UIKit

class SetTableViewCell: UITableViewCell {
    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var nextIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
