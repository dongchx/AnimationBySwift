//
//  SAAnimationCollectionViewCell.swift
//  SwiftSingleView
//
//  Created by dongchx on 2018/6/20.
//  Copyright © 2018 dongchx. All rights reserved.
//

import UIKit

class SAAnimationCollectionViewCell: UICollectionViewCell {
    
    private var title: UILabel!;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setupSubviews(parentView: self.contentView)
    }
    
    //subviews
    func setupSubviews(parentView: UIView) {
        parentView.backgroundColor = UIColor.green;
        self.title = UILabel(frame: parentView.frame);
        self.title.textColor = UIColor.white;
        self.title.textAlignment = NSTextAlignment.center;
        parentView.addSubview(self.title);
    }
    
    func setCellData(data: String) {
        self.contentView.backgroundColor = UIColor.green;
        self.title.text = data;
    }
    
}
