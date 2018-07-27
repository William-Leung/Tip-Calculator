//
//  ColorTheme.swift
//  TipCalculatorStarter
//
//  Created by pawn on 7/27/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

//This new struct contains the data for each theme
struct ColorTheme {
    
    static let light = ColorTheme(isDefaultStatusBar: true,viewControllerBackgroundColor: .tcOffWhite, primaryColor: .tcWhite, primaryTextColor: .tcCharcoal, secondaryColor: .tcDarkBlue, accentColor: UIColor.tcHotPink, outputTextColor: UIColor.tcAlmostBlack)
    
    static let dark = ColorTheme(isDefaultStatusBar: false,viewControllerBackgroundColor: .tcAlmostBlack, primaryColor: .tcMediumBlack, primaryTextColor: .tcWhite, secondaryColor: .tcBlueBlack, accentColor: .tcSeafoamGreen, outputTextColor: .tcWhite)
    
    let isDefaultStatusBar: Bool
    let viewControllerBackgroundColor: UIColor
    
    let primaryColor: UIColor
    let primaryTextColor: UIColor
    
    let secondaryColor: UIColor
    
    let accentColor: UIColor
    let outputTextColor: UIColor
}
