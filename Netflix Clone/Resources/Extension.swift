//
//  Extension.swift
//  Netflix Clone
//
//  Created by Umut Barış Çoşkun on 8.01.2023.
//

import UIKit


extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}


extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
