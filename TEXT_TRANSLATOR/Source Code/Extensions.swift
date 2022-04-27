//
//  Extensions.swift
//  Text_Translation
//
//  Created by iMac on 25/04/22.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIApplication{
    
    func getTopMostVC(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?{
        
        if let navigationController = controller as? UINavigationController {
            return getTopMostVC(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopMostVC(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return getTopMostVC(controller: presented)
        }
        
        return controller
    }
}

extension UIViewController{
    func loader(isStart:Bool = true,message:String){
        if isStart{
            MBProgressHUD.showAdded(to: view, animated: true)
        }else{
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
