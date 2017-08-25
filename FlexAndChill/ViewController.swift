//
//  ViewController.swift
//  FlexAndChill
//
//  Created by Hongfei Zhang on 8/24/17.
//  Copyright © 2017 Deja View Concepts, Inc. All rights reserved.
//

import UIKit
import YogaKit

// main view
class ViewController: UIViewController
{
	private let paddingHorizontal: YGValue = 8.0
	private let padding: YGValue = 8.0
	private let backgroundColor: UIColor = .black
	
	fileprivate var shows = [Show]()
	
	fileprivate let contentView: UIScrollView = UIScrollView(frame: .zero)
	fileprivate let kShowCellIdentifier = "ShowCell"
	
	// Overall show info
	private let showPopularity = 5
	private let showYear = "2010"
	private let showRating = "TV-14"
	private let showLength = "3 Series"
	private let showCast = "Benedict Cumberbatch, Martin Freeman, Una Stubbs"
	private let showCreators = "Mark Gatiss, Steven Moffat"
	
	// Show selected
	private let showSelectedIndex = 2
	private let selectedShowSeriesLabel = "S3:E3"
	
	// MARK: - Life cycle methods
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// Calculate and set the content size for the scroll view
		var contentViewRect: CGRect = .zero
		for view in contentView.subviews {
			// Returns the smallest rectangle that contains the two source rectangles.
			contentViewRect = contentViewRect.union(view.frame)
		}
		contentView.contentSize = contentViewRect.size
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Load shows from plist
		shows = Show.loadShows()
		let show = shows[showSelectedIndex]
		
		// -----------------------
		// Content View
		// -----------------------
		contentView.backgroundColor = backgroundColor
		contentView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.height = YGValue(self.view.bounds.size.height)
			layout.width = YGValue(self.view.bounds.size.width)
			layout.justifyContent = .flexStart
		}
		self.view.addSubview(contentView)
		
		/// Lay out content sub-views ///
		
		/// Step-1: Episode Image View
		// 1.x
		let episodeImageView = UIImageView(frame: .zero)
		episodeImageView.backgroundColor = .gray
		// 2.x
		let image = UIImage(named: show.image)
		episodeImageView.image = image
		// 3.x
		let imageWidth = image?.size.width ?? 1.0
		let imageHeight = image?.size.height ?? 1.0
		// 4.x
		episodeImageView.configureLayout { (ygLayout) in
			ygLayout.isEnabled = true
			ygLayout.flexGrow = 1.0
			ygLayout.aspectRatio = imageWidth/imageHeight
		}
		contentView.addSubview(episodeImageView)
		
		/// Step-2: Summary View
		let summaryView = UIView(frame: .zero)
		summaryView.configureLayout { (ygLayout) in
			ygLayout.isEnabled = true
			ygLayout.flexDirection = .row
			ygLayout.padding = self.padding
		}
		let summaryPopularityLabel = UILabel(frame: .zero)
		summaryPopularityLabel.text = String(repeating: "★", count: showPopularity)
		summaryPopularityLabel.textColor = .red
		summaryPopularityLabel.configureLayout { (ygLayout) in
			ygLayout.isEnabled = true
			ygLayout.flexGrow = 1.0
		}
		summaryView.addSubview(summaryPopularityLabel)
		
		let summaryInfoView = UIView(frame: .zero)
		summaryInfoView.configureLayout { (ygLayout) in
			ygLayout.isEnabled = true
			ygLayout.flexGrow = 2.0		// means summaryInfoView >= 2 * summaryPopularityLabel 's space
			ygLayout.flexDirection = .row
			ygLayout.justifyContent = .spaceBetween
		}
		
		for text in [showYear, showRating, showLength] {
			let summaryInfoLabel = UILabel(frame: .zero)
			summaryInfoLabel.text = text
			summaryInfoLabel.font = UIFont.systemFont(ofSize: 14.0)
			summaryInfoLabel.textColor = .lightGray
			summaryInfoLabel.configureLayout(block: { (layout) in
				layout.isEnabled = true
			})
			summaryInfoView.addSubview(summaryInfoLabel)
		}
		
		summaryView.addSubview(summaryInfoView)
		
		// To tweak the layout to get the spacing just right, add one more space view
		let summaryInfoSpacerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 1))
		summaryInfoSpacerView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
		}
		summaryView.addSubview(summaryInfoSpacerView)
		
		// summaryView has 3 child items. The first and third child items will take 25% of any remaining container space while the second item will take 50% of the available space.
		contentView.addSubview(summaryView)
		
		/// Step-3: Title view
		let titleView = UIView(frame: .zero)
		titleView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = self.padding
		}
		
		let titleEpisodeLabel = showLabelFor(text: selectedShowSeriesLabel, font: UIFont.boldSystemFont(ofSize: 16.0))
		titleView.addSubview(titleEpisodeLabel)
		
		let titleFullLabel = UILabel(frame: .zero)
		titleFullLabel.text = show.title
		titleFullLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleFullLabel.textColor = .lightGray
		titleFullLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginLeft = 20.0
			layout.marginBottom = 5.0
		}
		titleView.addSubview(titleFullLabel)
		
		contentView.addSubview(titleView)
		
		/// Step-4: Description view
		let descriptionView = UIView(frame: .zero)
		descriptionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.paddingHorizontal = self.paddingHorizontal
		}
		
		let descLabel = UILabel(frame: .zero)
		descLabel.font = UIFont.systemFont(ofSize: 14.0)
		descLabel.numberOfLines = 3
		descLabel.textColor = .lightGray
		descLabel.text = show.detail
		descLabel.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		descriptionView.addSubview(descLabel)
		
		let castText = "Cast: \(showCast)"
		let castLabel = showLabelFor(text: castText, font: UIFont.boldSystemFont(ofSize: 14.0))
		descriptionView.addSubview(castLabel)
		let creatorText = "Creators: \(showCreators)"
		let creatorLabel = showLabelFor(text: creatorText, font: UIFont.boldSystemFont(ofSize: 14.0))
		descriptionView.addSubview(creatorLabel)
		
		contentView.addSubview(descriptionView)
		
		/// Step-5: Show's action views
		let actionsView = UIView(frame: .zero)
		actionsView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = self.padding
		}
		
		let addActionView = showActionViewFor(imageName: "add", text: "My List")
		actionsView.addSubview(addActionView)
		let shareActionView = showActionViewFor(imageName: "share", text: "Share")
		actionsView.addSubview(shareActionView)
		
		contentView.addSubview(actionsView)
		
		/// Step-6: Tab View
		let tabsView = UIView(frame: .zero)
		tabsView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexDirection = .row
			layout.padding = self.padding
		}
		
		let episodesTabView = showTabBarFor(text: "EPISODES", selected: true)
		tabsView.addSubview(episodesTabView)
		let moreTabView = showTabBarFor(text: "MORE LIKE THIS", selected: false)
		tabsView.addSubview(moreTabView)
		
		contentView.addSubview(tabsView)
		
		/// Step-7: Table view
		let showsTableView = UITableView()
		showsTableView.delegate = self
		showsTableView.dataSource = self
		showsTableView.backgroundColor = backgroundColor
		showsTableView.register(ShowTableViewCell.self, forCellReuseIdentifier: kShowCellIdentifier)
		showsTableView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.flexGrow = 1.0
		}
		
		contentView.addSubview(showsTableView)
		
		/// Apply the layout to view and subviews
		contentView.yoga.applyLayout(preservingOrigin: false)
	}
	
	
}//End-Class

// MARK: - Private methods

private extension ViewController {
	
	func showLabelFor(text: String, font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> UILabel
	{
		let label = UILabel(frame: .zero)
		label.font = font
		label.textColor = .lightGray
		label.text = text
		label.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		return label
	}
	
	func showActionViewFor(imageName: String, text: String) -> UIView {
		let actionView = UIView(frame: .zero)
		actionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.alignItems = .center
			layout.marginRight = 20.0
		}
		
		let actionButton = UIButton(type: .custom)
		actionButton.setImage(UIImage(named: imageName), for: .normal)
		actionButton.configureLayout { (layout) in
			layout.isEnabled = true
			layout.padding = 10.0
		}
		actionView.addSubview(actionButton)
		
		let actionLabel = showLabelFor(text: text)
		actionView.addSubview(actionLabel)
		
		return actionView
	}
	
	func showTabBarFor(text: String, selected: Bool) -> UIView {
		let tabView = UIView(frame: .zero)
		tabView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.alignItems = .center
			layout.marginRight = 20.0
		}
		
		let tabLabelFont = selected ? UIFont.boldSystemFont(ofSize: 14.0) : UIFont.systemFont(ofSize: 14.0)
		let fontSize: CGSize = text.size(attributes: [NSFontAttributeName: tabLabelFont])
		
		// Create a view to indicate that a tab is selected
		let tabSelectionView = UIView(frame: CGRect(x: 0, y: 0, width: fontSize.width, height: 3))
		if selected {
			tabSelectionView.backgroundColor = .red
		}
		tabSelectionView.configureLayout { (layout) in
			layout.isEnabled = true
			layout.marginBottom = 5.0
		}
		tabView.addSubview(tabSelectionView)
		
		// tab title
		let tabLabel = showLabelFor(text: text, font: tabLabelFont)
		tabView.addSubview(tabLabel)
		
		return tabView
	}
	
}

// MARK: - UITableViewDataSource methods

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shows.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: ShowTableViewCell =
			tableView.dequeueReusableCell(withIdentifier: kShowCellIdentifier, for: indexPath) as! ShowTableViewCell
		cell.show = shows[indexPath.row]
		return cell
	}
	
}

// MARK: - UITableViewDelegate methods

extension ViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Selected row \(indexPath.row)")
	}
	
}
