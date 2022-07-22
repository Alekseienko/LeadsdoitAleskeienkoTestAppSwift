//
//  UISegmentedView.swift
//  LeadsdoitAleskeienkoTestAppSwift
//
//  Created by alekseienko on 30.06.2022.
//

import UIKit

extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor(red: 0.081, green: 0.077, blue: 0.096, alpha: 1).cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor(red: 0.081, green: 0.077, blue: 0.096, alpha: 1).cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        self.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "SourceSansPro-Bold", size: 20)!,
                                     NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name:
            "SourceSansPro-Bold", size: 20)!,
                                     NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / 5.0
        let underlineHeight: CGFloat = 4.0
        let underlineXPosition = (self.bounds.width / 2) * CGFloat(selectedSegmentIndex) + 50
        let underLineYPosition = self.bounds.size.height - 4.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1)
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / 2) * CGFloat(selectedSegmentIndex) + 50
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
