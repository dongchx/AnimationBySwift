//
//  ViewController.swift
//  SwiftSingleView
//
//  Created by dongchx on 16/04/2018.
//  Copyright © 2018 dongchx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CALayerDelegate {
    
    var layerView : UIView?;
    var blueLayer : CALayer?;
    var contaninerView :UIView!;
    var colorLayer : CALayer!;

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContainerView();
//        self.setupSubviews();
//        self.createShapeLayer();
//        self.createTransformLayer();
//        self.createGradientLayer();
//        self.createReplicatorLayer();
        self.randomColorCube();
    }
    
    func setupSubviews() {
//        self.view.backgroundColor = UIColor.gray;
//        let mView = MainView(frame : self.view.bounds);
////        let mView = UIView(frame : self.view.bounds);
//        self.view.addSubview(mView);
        
        // center
        self.view.backgroundColor = UIColor.gray;
        let centerView = UIView(frame : CGRect(x:0,y:0,width:200,height:200));
        self.view.addSubview(centerView);
        
        centerView.center = self.view.center;
        centerView.backgroundColor = UIColor.white;
        self.layerView = centerView;
        
        // CALayer
        let blueLayer = CALayer();
        blueLayer.frame = CGRect(x:50,y:50,width:100,height:100);
        blueLayer.backgroundColor = UIColor.blue.cgColor;
        centerView.layer.addSublayer(blueLayer);
        self.blueLayer = blueLayer;
        
        blueLayer.delegate = self;
        blueLayer.contentsScale = UIScreen().scale;
        
        // force layer to redraw
        blueLayer.display();
        
        //        let image = UIImage(named :"snowman.png");
        //        blueLayer.contents = image?.cgImage;
        //        blueLayer.contentsGravity
        //        blueLayer.contentsScale
        
    }
    
    func createContainerView() {
        let cView = UIView(frame: self.view.frame);
        cView.backgroundColor = UIColor.gray;
        self.view.addSubview(cView);
        
        self.contaninerView = cView;
    }
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        // draw a thick red circle
        ctx.setLineWidth(10.0);
        ctx.setStrokeColor(UIColor.red.cgColor);
        ctx.strokeEllipse(in: layer.bounds);
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        // get touch position relative to main view
//        var point = touches.first?.location(in: self.view);
//        //
//        point = self.layerView?.layer.convert(point!, from: self.view.layer);
//
//        //
//        if (self.layerView?.layer.contains(point!))! {
//
//            if (self.blueLayer?.contains(point!))! {
//                print("Inside blue layer");
//            }
//            else {
//                print("Inside white layer");
//            }
//
//        }
//    }
    
    func createShapeLayer() {
        
        let path = UIBezierPath();
        path.move(to: CGPoint(x: 175, y: 100));
        path.addArc(withCenter: CGPoint(x: 150, y: 100),
                    radius: 25,
                    startAngle: 0,
                    endAngle: CGFloat(2*Double.pi),
                    clockwise: true);
        path.move(to: CGPoint(x: 150, y: 125));
        path.addLine(to: CGPoint(x: 150, y: 175));
        path.addLine(to: CGPoint(x: 125, y: 225));
        path.move(to: CGPoint(x: 150, y: 175));
        path.addLine(to: CGPoint(x: 175, y: 225));
        path.move(to: CGPoint(x: 100, y: 150));
        path.addLine(to: CGPoint(x: 200, y: 150));
        
        let shapeLayer = CAShapeLayer();
        shapeLayer.strokeColor = UIColor.red.cgColor;
        shapeLayer.fillColor = UIColor.clear.cgColor;
        shapeLayer.lineWidth = 5;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.path = path.cgPath;
        
        self.view.layer.addSublayer(shapeLayer);
    }
    
    // 用 CATransformLayer 装配一个3D图层体系
    func faceWithTransform(transform: CATransform3D) -> CALayer {
        // create cube face layer
        let face = CALayer();
        face.frame =  CGRect(x: -50, y: -50, width: 100, height: 100);
        
        // apply a random color
        let red     = CGFloat(drand48());
        let green   = CGFloat(drand48());
        let blue    = CGFloat(drand48());
        face.backgroundColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1).cgColor;
        
        // apply the transform and return
        face.transform = transform;
        return face;
    }
    
    func cubeWithTransform(transform: CATransform3D) -> CALayer {
        // create cube layer
        let cube = CATransformLayer();
        
        // add cube face 1
        var ct = CATransform3DMakeTranslation(0, 0, 50);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // add cube face 2
        ct = CATransform3DMakeTranslation(50, 0, 0);
        ct = CATransform3DRotate(ct, CGFloat(Double.pi/2), 0, 1, 0);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // add cube face 3
        ct = CATransform3DMakeTranslation(0, -50, 0);
        ct = CATransform3DRotate(ct, CGFloat(Double.pi/2), 1, 0, 0);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // add cube face 4
        ct = CATransform3DMakeTranslation(0, 50, 0);
        ct = CATransform3DRotate(ct, -CGFloat(Double.pi/2), 1, 0, 0);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // add cube face 5
        ct = CATransform3DMakeTranslation(-50, 0, 0);
        ct = CATransform3DRotate(ct, -CGFloat(Double.pi/2), 0, 1, 0);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // add cube face 6
        ct =  CATransform3DMakeTranslation(0, 0, -50);
        ct = CATransform3DRotate(ct, CGFloat(Double.pi), 0, 1, 0);
        cube.addSublayer(self.faceWithTransform(transform: ct));
        
        // center the cube layer within the container
        let containerSize = self.view.bounds.size;
        cube.position = CGPoint(x: containerSize.width/2, y: containerSize.height/2);
        
        // apply the transform and return
        cube.transform = transform;
        return cube;
    }
    
    func createTransformLayer() {
        
        // set up the perspective transform
        var pt = CATransform3DIdentity;
        pt.m34 = -1.0/500.0;
        self.contaninerView.layer.sublayerTransform = pt;
        
        // set up the transform for cube 1 and add it
        var c1t = CATransform3DIdentity;
        c1t = CATransform3DTranslate(c1t, -100, 0, 0);
        let cube1 = self.cubeWithTransform(transform: c1t);
        self.contaninerView.layer.addSublayer(cube1);
        
        // set up the transform for cube 2 and add it
        var c2t = CATransform3DIdentity;
        c2t = CATransform3DTranslate(c2t, 100, 0, 0);
        c2t = CATransform3DRotate(c2t, -CGFloat(Double.pi/4), 1, 0, 0);
        c2t = CATransform3DRotate(c2t, -CGFloat(Double.pi/4), 0, 1, 0);
        let cube2 = self.cubeWithTransform(transform: c2t);
        cube2.masksToBounds = false;
        self.contaninerView.layer.addSublayer(cube2);
    }
    
    // CAGradientLayer
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer();
        gradientLayer.frame = self.contaninerView.bounds;
        self.contaninerView.layer.addSublayer(gradientLayer);
        
        // set gradientLayer colors
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor];
        
        // set gradientLayer start and end point
        gradientLayer.startPoint = CGPoint(x: 0, y: 0);
        gradientLayer.endPoint = CGPoint(x: 1, y: 1);
    }
    
    // CAReplicatorLayer
    func createReplicatorLayer() {
        let replicatorLayer = CAReplicatorLayer();
        replicatorLayer.frame = self.contaninerView.bounds;
        self.contaninerView.layer.addSublayer(replicatorLayer);
        
        replicatorLayer.instanceCount = 10;
        
        var transform = CATransform3DIdentity;
        transform = CATransform3DTranslate(transform, 0, 200, 0);
        transform = CATransform3DRotate(transform, CGFloat(Double.pi/5.0), 0, 0, 1);
        transform = CATransform3DTranslate(transform, 0, -200, 0);
        replicatorLayer.instanceTransform = transform;
        
        replicatorLayer.instanceBlueOffset = -0.1;
        replicatorLayer.instanceGreenOffset = -0.1;
        
        let layer = CALayer();
        layer.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        layer.backgroundColor = UIColor.white.cgColor;
        replicatorLayer.addSublayer(layer);
    }
    
    // CAEmitterLayer
    func createEmitterLayer() {
        let emitterLayer = CAEmitterLayer();
        emitterLayer.frame = self.contaninerView.bounds;
        self.contaninerView.layer.addSublayer(emitterLayer);
        
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        emitterLayer.emitterPosition = CGPoint(x: emitterLayer.frame.size.width/2,
                                               y: emitterLayer.frame.size.height/2);
        
        let cell = CAEmitterCell();
//        cell.contents =
        cell.birthRate = 150;
        cell.lifetime = 5.0;
        cell.color = UIColor.init(red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor;
        cell.alphaSpeed = -0.4;
        cell.velocity = 50;
        cell.velocityRange = 50;
        cell.emissionRange = CGFloat(Double.pi*2);
        
        emitterLayer.emitterCells = [cell];
    }
    
    // CAEAGLLayer
    func createEAGLLayer() {
        
    }
    
    // random color cube
    func randomColorCube() {
        
        self.colorLayer = CALayer();
        self.colorLayer.frame = CGRect(x: 50, y: 50,
                                       width:  100,
                                       height: 100);
        self.colorLayer.backgroundColor = UIColor.blue.cgColor;
        
        let transition = CATransition();
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        
        self.colorLayer.actions = ["backgroundColor": transition];
        self.contaninerView.layer.addSublayer(self.colorLayer);
    }
    
    // 过渡
    func switchImage() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        CATransaction.begin();
        CATransaction.setAnimationDuration(1.0);
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut));

        
//        CATransaction.setCompletionBlock {
//            var transform = self.colorLayer.affineTransform();
//            transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4));
//            self.colorLayer.setAffineTransform(transform);
//        };
        let red     = CGFloat(drand48());
        let green   = CGFloat(drand48());
        let blue    = CGFloat(drand48());
        self.colorLayer.backgroundColor =
            UIColor.init(red: red, green: green, blue: blue, alpha: 1).cgColor;
        CATransaction.commit();
    }
}




























