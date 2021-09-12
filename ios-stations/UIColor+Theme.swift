//
//  UIColor+Theme.swift
//  ios-stations
//

import UIKit

extension UIColor {
    struct Theme {
        static var main: UIColor  { return
            //別クラスで呼ぶときは、UIColor(named:"Main") を読んであげる！！
            UIColor(named: "Main")! }
    }
    
    static var random: UIColor {
        let r = CGFloat.random(in: 0...255) / 255.0
        return UIColor(red: r, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
