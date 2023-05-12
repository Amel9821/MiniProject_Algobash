//
//  Extension.swift
//  MiniProject_Algobash
//
//  Created by Amalia . on 12/05/23.
//

import Foundation
import Foundation
import UIKit
import Alamofire

class My {
    static func queryParams(url:String, params:[String: String]) -> String {
        var sURL = url
        var sParams = ""
        
        for(key, value) in params {
            sParams += key + "=" + value + "&"
        }
        
        if !sParams.isEmpty {
            sParams = "?" + sParams
            
            if sParams.hasSuffix("&") {
                sParams.removeLast()
            }
            
            sURL = sURL + sParams
        }
        
        return sURL
    }
    
    static func newQueryParams(params:[String: String]) -> String {
       // var sURL = url
        var sParams = ""
        
        for(key, value) in params {
            sParams += key + "=" + value + "&"
        }
        
        if !sParams.isEmpty {
            sParams = "?" + sParams
            
            if sParams.hasSuffix("&") {
                sParams.removeLast()
            }
            
           // sURL = sURL + sParams
        }
        
        return sParams
    }

}


public class LoadingOverlay{
    
    var overlayView = UIView()
    var popup = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var loadingactivityIndicator = UIActivityIndicatorView()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showLoading(controller: UIViewController) {
        
        let loadingAlertController: UIAlertController = UIAlertController(title: "Loading...", message: nil, preferredStyle: .alert)
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .white
        }
        //activityIndicator.style = .medium
        activityIndicator.color = .gray
        
        loadingAlertController.view.addSubview(activityIndicator)
        
        let xConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint: NSLayoutConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: loadingAlertController.view, attribute: .centerY, multiplier: 1.4, constant: 0)
        
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        
        let height: NSLayoutConstraint = NSLayoutConstraint(item: loadingAlertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
        loadingAlertController.view.addConstraint(height)
        
        controller.present(loadingAlertController, animated: true, completion: nil)
        
    }
    
    public func hideLoading(controller: UIViewController) {
        controller.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    public func showOverlay(view: UIView) {
        overlayView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        overlayView.backgroundColor = .gray
        overlayView.clipsToBounds = true
        
        let ukuran_x = (Int(screenWidth) - 300) / 2
        popup.frame = CGRect(x: ukuran_x, y: (Int(screenHeight) / 3), width: 300, height: 150)
        
        popup.backgroundColor = .gray
        popup.layer.cornerRadius = 10
        popup.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 50, y: 90, width: 200.0, height: 44.0))
        label.text = "Loading.."
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        popup.addSubview(label)
        loadingactivityIndicator.frame = CGRect(x: 130, y: 40, width: 40, height: 40)
        if #available(iOS 13.0, *) {
            loadingactivityIndicator.style = .large
        } else {
            loadingactivityIndicator.style = .whiteLarge
        }
        
        loadingactivityIndicator.color = .lightGray
        loadingactivityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        popup.addSubview(loadingactivityIndicator)
        overlayView.addSubview(popup)
        view.addSubview(overlayView)
        
        loadingactivityIndicator.startAnimating()
    }
    
    public func showActivityOverlay(view: UIView) {
        overlayView.frame = CGRect(x: 0, y: 120, width: view.bounds.width, height: view.bounds.height)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(named: "colorTertiaryBackground")
        overlayView.clipsToBounds = true
        
        activityIndicator.frame = CGRect(x: 170, y: 350, width: 40, height: 40)
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        activityIndicator.color = UIColor(named: "colorLabelPageview")
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        loadingactivityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    public func hideActivityView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}

//class Toast {
//    enum ToastPosition {
//        case top
//        case bottom
//    }
//    
//    static func show(message: String, controller: UIViewController, type: String) {
//        let toastContainer = UIView(frame: CGRect())
//        if type == "warning" {
//            toastContainer.backgroundColor = .yellow
//        } else if type == "success" {
//            toastContainer.backgroundColor = .green
//        } else if type == "danger" {
//            toastContainer.backgroundColor = .red
//        } else {
//            toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        }
//        toastContainer.alpha = 0.0
//        toastContainer.layer.cornerRadius = 20;
//        toastContainer.clipsToBounds  =  true
//        
//        let toastLabel = UILabel(frame: CGRect())
//        if type == "warning" {
//            toastLabel.textColor = UIColor.brown
//        } else {
//            toastLabel.textColor = UIColor.white
//        }
//        
//        toastLabel.font = UIFont(name: "OpenSans-Medium", size: 14)
//        toastLabel.textAlignment = .center;
//        toastLabel.text = message
//        toastLabel.clipsToBounds  =  true
//        toastLabel.numberOfLines = 0
//        
//        toastContainer.addSubview(toastLabel)
//        controller.view.addSubview(toastContainer)
//        
//        toastLabel.translatesAutoresizingMaskIntoConstraints = false
//        toastContainer.translatesAutoresizingMaskIntoConstraints = false
//        
//        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 10)
//        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -10)
//        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -10)
//        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 10)
//        toastContainer.addConstraints([a1, a2, a3, a4])
//        
//        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
//        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
//        let con = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -100)
//        
//        controller.view.addConstraints([c1, c2, con])
//        
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//            toastContainer.alpha = 1.0
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
//                toastContainer.alpha = 0.0
//            }, completion: {_ in
//                toastContainer.removeFromSuperview()
//            })
//        })
//    }
//    
//    
//    static func showTop(message: String, controller: UIViewController, type: String) {
//        let toastContainer = UIView(frame: CGRect())
//        if type == "warning" {
//            toastContainer.backgroundColor = .yellow //.colorYellow
//        } else if type == "success" {
//            toastContainer.backgroundColor = .green //.colorGreen
//        } else if type == "danger" {
//            toastContainer.backgroundColor = .orange //.colorRed
//        } else {
//            toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//        }
//        toastContainer.alpha = 0.0
//        toastContainer.layer.cornerRadius = 20;
//        toastContainer.clipsToBounds  =  true
//        
//        let toastLabel = UILabel(frame: CGRect())
//        toastLabel.textColor = UIColor.white
//        toastLabel.font = UIFont(name: "OpenSans-Medium", size: 14)
//        toastLabel.textAlignment = .center;
//        toastLabel.text = message
//        toastLabel.clipsToBounds  =  true
//        toastLabel.numberOfLines = 0
//        
//        toastContainer.addSubview(toastLabel)
//        controller.view.addSubview(toastContainer)
//        
//        toastLabel.translatesAutoresizingMaskIntoConstraints = false
//        toastContainer.translatesAutoresizingMaskIntoConstraints = false
//        
//        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 10)
//        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -10)
//        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -10)
//        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 10)
//        toastContainer.addConstraints([a1, a2, a3, a4])
//        
//        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
//        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
//        let con = NSLayoutConstraint(item: toastContainer, attribute: .top, relatedBy: .equal, toItem: controller.view, attribute: .top, multiplier: 1, constant: 20)
//        
//        controller.view.addConstraints([c1, c2, con])
//        
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//            toastContainer.alpha = 1.0
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
//                toastContainer.alpha = 0.0
//            }, completion: {_ in
//                toastContainer.removeFromSuperview()
//            })
//        })
//    }
//    
    
}
