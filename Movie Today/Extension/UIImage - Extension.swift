//
//  UIImage - Extension.swift
//  Movie Today
//
//  Created by Nikita on 06.01.2024.
//

import UIKit

extension UIImage {
    
    static func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        
        let x: CGFloat = 0
        let y: CGFloat = 0
        context.moveTo(x, y)
        context.addLine(to: x + size.width, y: y)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
