//
//  AleatExtebsuibs.swift
//  DoubanBooks
//
//  Created by 2017YD on 2019/10/12.
//  Copyright © 2019 2017YD. All rights reserved.
//

import UIKit
extension UIAlertController{
    static func showAlert(_ massage:String, in controller:UIViewController){
        //显示一个警告框
        let aleat = UIAlertController(title:"", message:
            massage,preferredStyle: .alert)
        let action = UIAlertAction(title: "确认", style: .destructive, handler: nil)
        aleat.addAction(action)
        controller.present(aleat,animated: true, completion: nil)
    }
    
    static func showConfirm(_ message:String, in contreller:UIViewController,confirm:((UIAlertAction) -> Void)?)  {
        //显示一个对话框
        let aleat = UIAlertController(title:"", message:
            message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确认", style: .default, handler: confirm)
        aleat.addAction(confirm)
        aleat.addAction(cancel)
        contreller.present(aleat,animated: true, completion: nil)
        
    }
    
    static func showAlertAndDismiss(_ message:String,in contreller:UIViewController){
        //显示警告框，几秒后消失
        let alert = UIAlertController(title: message,message:nil,preferredStyle: .alert)
        contreller.present(alert,animated:true,completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {()-> Void in
            contreller.presentedViewController?.dismiss(animated: true, completion: nil)
        })
        
    }
    
    static func showAlertAndDismiss(_ message:String,in contreller:UIViewController,completion:(() -> Void)? = nil){
        //显示警告框，几秒后消失,举要dismiss回调方法
        let alert = UIAlertController(title: message,message:nil,preferredStyle: .alert)
        contreller.present(alert,animated:true,completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {()-> Void in
            contreller.presentedViewController?.dismiss(animated: true, completion: completion)
        })
    }
}
