//
//  Show.swift
//  FlexAndChill
//
//  Created by Hongfei Zhang on 8/24/17.
//  Copyright © 2017 Deja View Concepts, Inc. All rights reserved.
//

import Foundation

struct Show {
  let title: String
  let length: String
  let detail: String
  let image: String
}

// MARK: - Support for loading data from plist

extension Show {
	
	static func loadShows() -> [Show] {
		return loadMixersFrom("Shows")
	}
	
	fileprivate static func loadMixersFrom(_ plistName: String) -> [Show] {
		guard
			let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
			let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
			else {
				fatalError("An error occurred while reading \(plistName).plist")
		}
		
		var shows = [Show]()
		
		for dict in dictArray {
			guard
				let title = dict["title"] as? String,
				let length = dict["length"] as? String,
				let detail = dict["detail"] as? String,
				let image = dict["image"] as? String
				else {
					fatalError("Error parsing dict \(dict)")
			}
			
			let show = Show(title: title, length: length, detail: detail, image: image)
			shows.append(show)
		}
		
		return shows
	}
	
}
