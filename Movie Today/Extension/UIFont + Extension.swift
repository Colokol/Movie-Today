//
//  UIFont + Extension.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 27.12.23.
//

import UIKit

extension UIFont {
    static func montserratRegular(ofSize: CGFloat) -> UIFont? {
        return UIFont(name: "Montserrat-Regular", size: ofSize)
    }
    
    static func montserratMedium(ofSize: CGFloat) -> UIFont? {
            return UIFont(name: "Montserrat-Medium", size: ofSize)
        }
    
    static func montserratSemiBold(ofSize: CGFloat) -> UIFont? {
            return UIFont(name: "Montserrat-SemiBold", size: ofSize)
        }
}
