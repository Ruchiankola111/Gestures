//
//  ViewController.swift
//  Ass9Gestures
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let myImageView:UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "pic6.jpg")
        imageview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        return imageview
    }()
    
    private let imagePicker: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = false
        return ip
    }()
    
    private let myView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(myView)
        myView.addSubview(myImageView)
        imagePicker.delegate = self
        
        
        
        //tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        myView.addGestureRecognizer(tapGesture)
        
        
        //PinchGesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        view.addGestureRecognizer(pinchGesture)
        
        
        //RotationGesture
        let rotationGestures = UIRotationGestureRecognizer(target: self, action: #selector(didRotateView))
        view.addGestureRecognizer(rotationGestures)
        
        //SwipeGesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        
        //PanGesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        view.addGestureRecognizer(panGesture)
        
    }
    
}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            myImageView.image = selectedImage
            
        }
        picker.dismiss(animated: true)
    }
}

extension ViewController {
    //tapGesture
    @objc private func didTapView(gesture: UITapGestureRecognizer) {
        print("Tapped at location: \(gesture.location(in: view))")
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
        }
    }
    
    
    //PinchGesture
    @objc private func didPinchView(gesture: UIPinchGestureRecognizer) {
        myView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    
    
    //RotationGesture
    @objc private func didRotateView(gesture: UIRotationGestureRecognizer) {
        myView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    //SwipeGesture
    @objc private func didSwipeView(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            UIView.animate(withDuration: 0.5){
                self.myView.frame = CGRect(x: self.myView.frame.origin.x - 40, y: self.myView.frame.origin.y, width: 200, height: 200)
            }
            
        }
        else if gesture.direction == .right {
            myView.frame = CGRect(x: myView.frame.origin.x - 40, y: myView.frame.origin.y, width: 200, height: 200)
        }
        else if gesture.direction == .up {
            myView.frame = CGRect(x: myView.frame.origin.x, y: myView.frame.origin.y - 40, width: 200, height: 200)
        }
        else if gesture.direction == .down {
            myView.frame = CGRect(x: myView.frame.origin.x, y: myView.frame.origin.y - 40, width: 200, height: 200)
        }
    }
    
    //PanGesture
    @objc private func didPanView(gesture: UIPanGestureRecognizer) {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        
        myView.center = CGPoint(x: x, y: y)
    }
}


