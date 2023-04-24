//
//  UIImage+Resize.swift
//  The Wire Character Viewer
//
//  Created by Rashad Surratt on 4/24/23.
//

import CoreGraphics
import Accelerate
import CoreImage
import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
