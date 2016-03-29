//
//  EFKGameViewController.swift
//  EnglishForKids
//
//  Created by Panajotis Maroungas on 19/03/16.
//  Copyright © 2016 Panajotis Maroungas. All rights reserved.
//

import UIKit

class EFKGameViewController: UIViewController {

	// MARK: - Outlets

	@IBOutlet private weak var topScrollView	: UIScrollView?
	@IBOutlet private weak var defaultImageView	: UIImageView?

	// MARK: - Properties

	var imageViews: [UIImageView]?

	// MARK: - View life cycle

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		var imageArray = ["burger", "a", "b"]

		let lastimageView = UIImageView(frame: self.defaultImageView?.frame ?? CGRect())
		lastimageView.image = UIImage(named: imageArray.last ?? "")

		self.imageViews = [lastimageView]

		imageArray.append(imageArray[0])

		for image in imageArray {
			if let frame = self.imageViews?.last?.frame {
				var newFrame 		= frame
				newFrame.origin.x 	= (frame.origin.x + frame.size.width)
				let imageView 		= UIImageView(frame: newFrame)
				imageView.image 	= UIImage(named: image)

				self.imageViews?.append(imageView)
			}
		}

		self.addViewsToScrollView(self.imageViews ?? [])

		let contentSize = CGSize(width: (CGFloat(self.imageViews?.count ?? 0) * (self.defaultImageView?.frame.width ?? 0)), height: self.defaultImageView?.frame.height ?? 0)
		self.topScrollView?.contentSize = contentSize

		self.topScrollView?.scrollRectToVisible(CGRectMake((self.defaultImageView?.frame.size.width ?? 0), 0, (self.defaultImageView?.frame.size.width ?? 0), CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)

		//NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(EFKGameViewController.moveToNextPage), userInfo: nil, repeats: true)
	}

}

extension EFKGameViewController: UIScrollViewDelegate {

	@IBAction func swipeRight(sender: AnyObject) {
		self.moveToPreviousPage()
	}

	@IBAction func swipeLeft(sender: AnyObject) {
		self.moveToNextPage()
	}


	func moveToNextPage (){

		let pageWidth:CGFloat = CGRectGetWidth(self.topScrollView?.frame ?? CGRect())
		let maxWidth:CGFloat = pageWidth * (CGFloat(self.imageViews?.count ?? 0) - 1)
		let contentOffset:CGFloat = (self.topScrollView?.contentOffset.x ?? 0)

		let slideToX = contentOffset + pageWidth

		print(slideToX/pageWidth)

		if  slideToX == maxWidth{

			UIView.animateWithDuration(0.25, animations: {
				self.topScrollView?.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)
				}, completion: { (completed) in
					self.topScrollView?.scrollRectToVisible(CGRectMake((self.topScrollView?.frame.size.width) ?? 0, 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)
			})
			return
		}
		UIView.animateWithDuration(0.25, animations: {
			self.topScrollView?.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)
		})
	}

	func moveToPreviousPage (){

		let pageWidth:CGFloat = CGRectGetWidth(self.topScrollView?.frame ?? CGRect())
		let contentOffset:CGFloat = (self.topScrollView?.contentOffset.x ?? 0)

		let slideToX = contentOffset - pageWidth

		print(slideToX/pageWidth)

		if  (slideToX == 0) {

			UIView.animateWithDuration(0.25, animations: {
				self.topScrollView?.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)
				}, completion: { (completed) in
					self.topScrollView?.scrollRectToVisible(CGRectMake(((self.topScrollView?.frame.size.width) ?? 0) * (CGFloat((self.imageViews?.count) ?? 0) - 2) , 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: false)
			})
			return
		}
		UIView.animateWithDuration(0.25, animations: {
			self.topScrollView?.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.topScrollView?.frame ?? CGRect())), animated: true)
		})
	}

	func addViewsToScrollView(imageViews: [UIImageView]) {
		for imageView in imageViews {
			self.topScrollView?.addSubview(imageView)
		}
	}
}