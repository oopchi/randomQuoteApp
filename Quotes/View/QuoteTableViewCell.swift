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
    
    let alert = UIAlertController(title: "Copied to clipboard!", message: "", preferredStyle: .alert)
    
    @IBAction func copyButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = content.text
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideAlert), userInfo: nil, repeats: false)
        })
    }
    
    @objc func hideAlert() {
        alert.dismiss(animated: true, completion: nil)
    }
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
