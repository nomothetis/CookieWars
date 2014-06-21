//
//  StatusModelView.swift
//  Canvas
//
//  Created by Salazar, Alexandros on 6/18/14.
//  Copyright (c) 2014 nomothetis. All rights reserved.
//

import Foundation
import UIKit


enum AppState {
    case LoggedIn(SellerData)
    case LoggedOut
}

struct SellerData {
    let name:String
    let salesTarget:Int
    let salesToDate:Int
}

struct StatusViewModel {
    let state:AppState
    let targetLabelText:String
    let currentLabelText:String
    let barFraction:CGFloat
    let targetBarColor:UIColor
    let targetLabelAlpha:CGFloat
    let currentLabelAlpha:CGFloat
    let titleLabelText:String
    //let lgin:(() -> StatusViewModel)
    //let lgout:() -> StatusViewModel
    
    init(state:AppState) {
        self.state = state
        switch state {
        case .LoggedOut:
            self.targetLabelText = ""
            self.targetLabelAlpha = 0.0
            self.currentLabelText = ""
            self.currentLabelAlpha = 0.0
            self.barFraction = 0
            self.targetBarColor = UIColor(hue: 22.0 / 359.0, saturation: 0.0, brightness: 0.60, alpha: 1.0)
            self.titleLabelText = "Logged Out"
        case .LoggedIn(let sellerData):
            self.targetLabelText = String(sellerData.salesTarget)
            self.targetLabelAlpha = 1.0
            self.currentLabelText = String(sellerData.salesToDate)
            self.currentLabelAlpha = 1.0
            self.barFraction = CGFloat(sellerData.salesToDate) / CGFloat(sellerData.salesTarget)
            self.targetBarColor = UIColor(hue: 22.0 / 359.0, saturation: 1.0, brightness: 0.95, alpha: 1.0)
            self.titleLabelText = sellerData.name
        }
    }
    
    func login() -> StatusViewModel {
        switch state {
        case .LoggedOut:
            var stubSellerData = SellerData(name:"Little Orphan Annie", salesTarget: 100, salesToDate: 30)
            return StatusViewModel(state:AppState.LoggedIn(stubSellerData))
        case .LoggedIn(let sellerdata):
            return self
        }
    }
    
    func logout() -> StatusViewModel {
        switch state {
        case .LoggedOut:
            return self
        case .LoggedIn:
            return StatusViewModel(state:AppState.LoggedOut)
        }
    }
    
}