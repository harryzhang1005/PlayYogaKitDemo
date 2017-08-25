//
//  ShowTableViewCell.swift
//  FlexAndChill
//
//  Created by Hongfei Zhang on 8/24/17.
//  Copyright © 2017 Deja View Concepts, Inc. All rights reserved.
//

import UIKit

// Display an episode in the table view
class ShowTableViewCell: UITableViewCell {
	
	var show: Show! {
		didSet {
			self.textLabel?.text = show.title
			self.detailTextLabel?.text = show.length
			self.imageView?.image = UIImage(named: show.image)
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		
		self.textLabel?.textColor = .white
		self.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
		self.textLabel?.numberOfLines = 2
		self.textLabel?.adjustsFontSizeToFitWidth = true
		self.textLabel?.minimumScaleFactor = 0.8
		self.detailTextLabel?.textColor = .lightGray
		
		let accessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
		accessoryView.image = UIImage(named: "download")
		self.accessoryView = accessoryView
		
		self.backgroundColor = .clear
		self.separatorInset = .zero
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}
