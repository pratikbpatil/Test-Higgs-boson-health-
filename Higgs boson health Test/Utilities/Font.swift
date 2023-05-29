//
//  Font.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 29/05/23.
//

import Foundation
import UIKit

//  All the font related configurations to be done here

struct AppFont {
    //    Enum for all the types of the font
    enum FontType: String {
        case Bold = "Roboto-Bold"
        case Black = "Roboto-Black"
        case BlackItalic = "Roboto-BlackItalic"
        case BoldItalic = "Roboto-BoldItalic"
        case Italic = "Roboto-Italic"
        case Light = "Roboto-Light"
        case LightItalic = "Roboto-LightItalic"
        case Medium = "Roboto-Medium"
        case MediumItalic = "Roboto-MediumItalic"
        case Regular = "Roboto-Regular"
        case Thin = "Roboto-Thin"
        case ThinItalic = "Roboto-ThinItalic"
        
    }
    //     Function for setting the font
    static func setRobotoFont(type: FontType, size: CGFloat) -> UIFont{
        return UIFont(name: type.rawValue, size: size)!
    }
}


