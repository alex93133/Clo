//
//  File.swift
//  Clo
//
//  Created by Alexander Lazarev on 19.06.2020.
//  Copyright © 2020 Alexandr Lazarev. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
