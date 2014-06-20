//
//  StatusViewController.swift
//  Canvas
//
//  Created by Salazar, Alexandros on 6/18/14.
//  Copyright (c) 2014 nomothetis. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    @IBOutlet var targetLabel: UILabel
    @IBOutlet var currentLabel: UILabel
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var neededCommitmentsBar: UIView
    @IBOutlet var commitmentsBar: UIView
    @IBOutlet var barGraphConstraint: NSLayoutConstraint
    
    var statusModel:StatusViewModel = StatusViewModel(state:AppState.LoggedOut)
    
    override func viewDidLoad() {
        self.barGraphConstraint.constant = self.neededCommitmentsBar.frame.size.width * self.statusModel.barFraction
        self.neededCommitmentsBar.backgroundColor = self.statusModel.targetBarColor
        self.targetLabel.text = self.statusModel.targetLabelText
        self.targetLabel.alpha = self.statusModel.targetLabelAlpha
        self.currentLabel.text = self.statusModel.currentLabelText
        self.currentLabel.alpha = self.statusModel.currentLabelAlpha
    }
    
    @IBAction func toggleLoginState() {
        switch self.statusModel.state {
        case .LoggedOut:
            self.statusModel = self.statusModel.login()
        case .LoggedIn(_):
            self.statusModel = self.statusModel.logout()
        }
        
        UIView.animateWithDuration(0.25, animations: {
            self.titleLabel.alpha = 0
            }, completion: { done in
                
                UIView.animateWithDuration(0.25, animations: {
                    self.titleLabel.alpha = 1
                    self.titleLabel.text = self.statusModel.titleLabelText
                    }, completion: { done in
                        
                        self.barGraphConstraint.constant = self.statusModel.barFraction * self.neededCommitmentsBar.frame.size.width
                        UIView.animateWithDuration(0.5) {
                            self.neededCommitmentsBar.backgroundColor = self.statusModel.targetBarColor
                            self.targetLabel.text = self.statusModel.targetLabelText
                            self.targetLabel.alpha = self.statusModel.targetLabelAlpha
                            self.currentLabel.text = self.statusModel.currentLabelText
                            self.currentLabel.alpha = self.statusModel.currentLabelAlpha
                            self.view.layoutIfNeeded()
                        }
                    })
            })
    }
}

