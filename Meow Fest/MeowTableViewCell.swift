//
//  MeowTableViewCell.swift
//  Meow Fest
//
//  Created by Nicholas Ollis on 3/24/18.
//  Copyright © 2018 Nicholas Ollis. All rights reserved.
//

import UIKit

class MeowTableViewCell: UITableViewCell {
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var meowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(meow: Meow) -> Self {
        dateLabel.text = dateFormatter.string(from: meow.timestamp)
        titleLabel.text = meow.title
        descriptionLabel.text = meow.description
        meowImageView.downloadedFrom(url: meow.image_url)
        
        return self
    }

}
