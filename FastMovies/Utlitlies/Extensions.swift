//
//  Extensions.swift
//  FastMovies
//
//  Created by Taha Muneeb on 15/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// Place to define extentions
extension Date {
    func movieFilterDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.locale = Locale.init(identifier: "en")
        let year = formatter.string(from: self)
        return year + "-01-01"
    }
}
extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}

extension UIImageView {
    func setShadow() {
        self.layer.shadowColor = UIColor.init(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        self.layer.shadowRadius = 5
    }
}

extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

func areEqual (_ left: Any, _ right: Any) -> Bool {
    if  type(of: left) == type(of: right) &&
        String(describing: left) == String(describing: right) { return true }
    if let left = left as? [Any], let right = right as? [Any] { return left == right }
    if let left = left as? [AnyHashable: Any], let right = right as? [AnyHashable: Any] { return left == right }
    return false
}

extension Array where Element: Any {
    static func != (left: [Element], right: [Element]) -> Bool { return !(left == right) }
    static func == (left: [Element], right: [Element]) -> Bool {
        if left.count != right.count { return false }
        var right = right
        loop: for leftValue in left {
            for (rightIndex, rightValue) in right.enumerated() where areEqual(leftValue, rightValue) {
                right.remove(at: rightIndex)
                continue loop
            }
            return false
        }
        return true
    }
}
extension Dictionary where Value: Any {
    static func != (left: [Key: Value], right: [Key: Value]) -> Bool { return !(left == right) }
    static func == (left: [Key: Value], right: [Key: Value]) -> Bool {
        if left.count != right.count { return false }
        for element in left {
            guard   let rightValue = right[element.key],
                areEqual(rightValue, element.value) else { return false }
        }
        return true
    }
}
