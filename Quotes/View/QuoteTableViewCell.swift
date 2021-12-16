//
//  QuoteTableViewCell.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        content.numberOfLines = 0
        content.lineBreakMode = .byWordWrapping
        
        tagLabel.numberOfLines = 0
        tagLabel.lineBreakMode = .byWordWrapping
        tagLabel.textColor = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
