//
//  Extensions.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation
import MapKit
import UIKit

extension String {
    
    var localized :String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    var time: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: self) {
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}

extension Date {
    
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }

    
    func addDate(_ noOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: noOfDays, to: self)!
    }
    
}

extension UITextField {
    @IBInspectable var localizedPlaceholder : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.placeholder = newValue!.localized
            } else {
                self.placeholder = ""
            }
        }
        get {
            return self.placeholder
        }
    }
}

extension UILabel {
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.text = newValue!.localized
            } else {
                self.text = ""
            }
        }
        get {
            return self.text
        }
    }
}

extension UIButton {
    
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.setTitle(newValue!.localized, for: UIControl.State())
            } else {
                self.setTitle("", for: UIControl.State())
            }
        }
        get {
            return self.titleLabel?.text
        }
    }
}

extension UITextView {
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.text = newValue!.localized
            } else {
                self.text = ""
            }
        }
        get {
            return self.text
        }
    }
}

extension UIBarButtonItem {
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.title = newValue!.localized
            } else {
                self.title = ""
            }
        }
        get {
            return self.title
        }
    }
}

extension UINavigationItem {
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.title = newValue!.localized
            } else {
                self.title = ""
            }
        }
        get {
            return self.title
        }
    }
}

extension UITabBarItem {
    @IBInspectable var localizedText : String? {
        set (newValue) {
            if !(newValue!.isEmpty) {
                self.title = newValue!.localized
            } else {
                self.title = ""
            }
        }
        get {
            return self.title
        }
    }
}

extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
    
}

extension NSObject {
    
    func navSignin() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nav_signin")
    }
    
    func navSignup() -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nav_signup")
    }
    
    func navMap() -> MapViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nav_map") as! MapViewController
    }
    
}

extension MKMapView {
    
    /**
     Sets the center of the `MKMapView` to a `CLLocationCoordinate2D` with a custom zoom-level. There is no nee to set a region manually. :-)
     */
    func setCenter(_ coordinate: CLLocationCoordinate2D, zoomLevel: Double, animated: Bool){
        var region = self.region
        
        region.center.latitude = coordinate.latitude
        region.center.longitude = coordinate.longitude
        
        region.span.latitudeDelta /= zoomLevel
        region.span.longitudeDelta /= zoomLevel
        
        self.setRegion(region, animated: animated)
        self.regionThatFits(region)
    }
    
    func fitAll() {
        var zoomRect = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01)
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
    }
    
}
