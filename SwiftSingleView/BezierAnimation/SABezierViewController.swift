//
//  SABezierViewController.swift
//  SwiftSingleView
//
//  Created by dongchx on 2018/6/22.
//  Copyright © 2018 dongchx. All rights reserved.
//

import UIKit

class SABezierViewController: UIViewController, CAAnimationDelegate {
    
    var bezierPath : UIBezierPath!
    var shipLayer : CALayer!
    var button : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView(frame: CGRect(x: 30, y: 150, width: 300, height: 300));
        self.view.addSubview(view);
        self.view.backgroundColor = UIColor.white;
        self.setupSubviews(parentView: view);
        
        let button = UIButton(frame: CGRect(x: 200, y: 500, width: 100, height: 60))
        button.backgroundColor = UIColor.yellow;
        button.addTarget(self, action: #selector(animationStart), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        self.button = button;
    }
    
    func setupSubviews(parentView: UIView) {
        
        parentView.backgroundColor = UIColor.white;
        
        self.bezierPath = UIBezierPath();
        self.bezierPath.move(to: CGPoint(x: 0, y: 150));
        self.bezierPath.addCurve(to: CGPoint(x: 300, y: 150),
                                 controlPoint1: CGPoint(x: 75, y: 0),
                                 controlPoint2: CGPoint(x: 225, y: 300));
        
        // drawPath
        let pathLayer = CAShapeLayer();
        pathLayer.path = self.bezierPath.cgPath;
        pathLayer.fillColor = UIColor.clear.cgColor;
        pathLayer.strokeColor = UIColor.red.cgColor;
        pathLayer.lineWidth = 3.0;
        parentView.layer.addSublayer(pathLayer);
        
        // shipLayer
        self.shipLayer = CALayer()
        self.shipLayer.frame = CGRect(x: 0, y: 0, width: 64, height: 64);
        self.shipLayer.position = CGPoint(x: 0, y: 150);
        self.shipLayer.contents = UIImage(named: "ship")?.cgImage;
        
        let angel = CGFloat(Double.pi/2)
        let trans = CATransform3DMakeRotation(angel, 0, 0, 1)
        self.shipLayer.transform = trans

        parentView.layer.addSublayer(self.shipLayer);
    }
    
    //MARK: - action
    @objc func animationStart() {
        print("run animation")
        self.button.isEnabled = false;
        self.shipLayer.removeAllAnimations();
        
        let animation = CAKeyframeAnimation();
        animation.keyPath = "position";
        animation.duration = 4.0;
        animation.path = self.bezierPath.cgPath;
        animation.rotationMode = kCAAnimationRotateAuto;
        animation.delegate = self
        self.shipLayer.add(animation, forKey: nil);
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.button.isEnabled = true
    }
}













