//
//  MainView.swift
//  SwiftSingleView
//
//  Created by dongchx on 17/04/2018.
//  Copyright © 2018 dongchx. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    var layerView : UIView?;
    
    override init(frame : CGRect) {
        super.init(frame: frame);
        setupSubviews();
    }
    
    required init?(coder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        // center
        self.backgroundColor = UIColor.gray;
        let centerView = UIView(frame : CGRect(x:0,y:0,width:200,height:200));
        self.addSubview(centerView);
        
        centerView.center = self.center;
        centerView.backgroundColor = UIColor.white;
        self.layerView = centerView;
        
        // CALayer
        let blueLayer = CALayer();
        blueLayer.frame = CGRect(x:50,y:50,width:100,height:100);
        blueLayer.backgroundColor = UIColor.blue.cgColor;
        centerView.layer.addSublayer(blueLayer);
        
        blueLayer.delegate = self;
        blueLayer.contentsScale = UIScreen().scale;
        
        // force layer to redraw
        blueLayer.display();
        
        //        let image = UIImage(named :"snowman.png");
        //        blueLayer.contents = image?.cgImage;
        //        blueLayer.contentsGravity
        //        blueLayer.contentsScale
        
    }
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        // draw a thick red circle
        ctx.setLineWidth(10.0);
        ctx.setStrokeColor(UIColor.red.cgColor);
        ctx.strokeEllipse(in: layer.bounds);
    }

}
