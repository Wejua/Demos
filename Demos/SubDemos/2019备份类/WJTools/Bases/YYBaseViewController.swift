//
//  YYBaseViewController.swift
//  YYVideo
//
//  Created by 杨凯 on 2018/7/10.
//  Copyright © 2018 杨凯. All rights reserved.
//

import UIKit
import Jelly

class YYBaseViewController: UIViewController {
    
    //MARK: - lazy properties
    private(set) lazy var titleBar: YYTitleBar = {
        let view = YYTitleBar()
        view.viewController_YY = self
        return view
    }()
    
    private(set) lazy var viewBoundsWithoutTitleBar: CGRect = {
        let rect = CGRect(origin: CGPoint(x: 0, y: titleBar.heightWithStatusBar), size: view.bounds.size)
        return rect
    }()
    
    //MARK: - life functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor.white
        setupTitleBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //默认隐藏navigationBar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //设置titleBar默认状态，viewDidLoad有可能在被push前就加载
        if self.navigationController == nil {
            titleBar.setHidden(isHidden: true, animate: false)
        } else {
            titleBar.setHidden(isHidden: false, animate: false)
        }
        //没有带navigationController或者navigationController的子视图为一个时，不显示默认的返回按钮
        if self.navigationController == nil || self.navigationController?.children.count == 1 {
            titleBar.defaultBackButton.isHidden = true
            navigationController?.interactivePopGestureRecognizer?.delegate = oringinPopDelegate
        } else {
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        //默认使titleBar在最上层
        view.bringSubviewToFront(titleBar)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - public functions
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.default
    }
    
    func constraintToView(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: titleBar.bottomAnchor, constant: 0),
            subView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            subView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            subView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
    }
    
    //MARK: - 去登录页面
    
    func shareAnyThing(){
        let shareVC = YYShareViewController()
        let animator = JellyAnimator(presentation: (self.jellyOver(self.scaleHeight(262)+kIsSpecTabMargin, false)))
        animator.prepare(viewController: shareVC)
        self.present(shareVC, animated: true, completion: nil)
    }
    
    func setTokenToH5(){
        guard  getCookie() == "" else {
            self.goToBaseLoginVC()
            return
        }
    }
    
    //MARK: - other properties
    lazy var oringinPopDelegate = navigationController?.interactivePopGestureRecognizer?.delegate
    
    
    private func setupTitleBar() {
        view.addSubview(titleBar)
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            titleBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            titleBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            titleBar.titleBarHeightConstraint,
        ])
    }
}

extension UIViewController {
    func goToBaseLoginVC(_ animated: Bool = true) {
        //TODO: - 重新登录，重新获取cookie
        removeCookie()
        deleteYipaiId()
        removeTimeStamp()
        EMClient.shared().logout(true)
        let login = LoginViewController()
        self.present(login, animated: animated, completion: nil)
    }
}

//MARK: -private functions
extension YYBaseViewController : UIGestureRecognizerDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func showCamera(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures=UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
            
        }
        let localPhoto=UIAlertAction(title:"相册", style: .default)
        {
            action in
            self.goImage()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
        
    }
    func goCamera(){
                    
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.normal)
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }

    }
    func goImage(){

       
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
//        func cancelVC(){
//            photoPicker.dismiss(animated: true, completion: nil)
//        }
    }
}

extension UIView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showCamera(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures = UIAlertAction(title:"拍照", style: .default){ action in
            self.goCamera()
        }
        let localPhoto = UIAlertAction(title:"相册", style: .default){ action in
            self.goImage()
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.viewController()?.present(alertController, animated:true, completion:nil)
    }
    
    func goCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.normal)
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            self.viewController()?.present(cameraPicker, animated: true, completion: nil)
        } else {
            ProgressHUD.showError("暂不支持拍照")
        }
        
    }
    
    func goImage(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        self.viewController()?.present(photoPicker, animated: true, completion: nil)
    }
    
}


