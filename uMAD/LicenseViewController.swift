//
//  LicenseViewController.swift
//  uMAD
//
//  Created by Andrew Chun on 1/31/15.
//  Copyright (c) 2015 com.MAD. All rights reserved.
//

import Foundation

class LicenseViewController: UIViewController {
    var licenseName: String!
    var licenseDetails: String!
    
    override init() {
        fatalError("Must call designated initalizer")
    }
    
    required init(licenseName: String, licenseDetails: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.licenseName = licenseName
        self.licenseDetails = licenseDetails
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        var nameLabel: UILabel = UILabel(frame: CGRectMake(CGRectGetWidth(self.view.bounds) * 0.05, CGRectGetHeight(self.view.bounds) * 0.02, CGRectGetWidth(self.view.bounds) * 0.90, 20.00))
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: FONT_SIZE + 3)
        nameLabel.text = self.licenseName
        nameLabel.sizeToFit()

        var detailsLabel: UILabel = UILabel(frame: CGRectMake(CGRectGetWidth(self.view.bounds) * 0.05, CGRectGetHeight(nameLabel.bounds) + nameLabel.frame.origin.y + CGRectGetHeight(self.view.bounds) * 0.02, CGRectGetWidth(self.view.bounds) * 0.90, 20.00))
        detailsLabel.font = UIFont.systemFontOfSize(FONT_SIZE - 3)
        detailsLabel.text = self.licenseDetails
        detailsLabel.numberOfLines = 0
        detailsLabel.sizeToFit()
        
        var scrollView: UIScrollView = UIScrollView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TABBAR_HEIGHT))
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), detailsLabel.frame.origin.y + CGRectGetHeight(detailsLabel.bounds))
        self.view.addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(detailsLabel)
    }
}