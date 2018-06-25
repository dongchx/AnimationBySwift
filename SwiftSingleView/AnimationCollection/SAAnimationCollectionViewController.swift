//
//  SAAnimationCollectionViewController.swift
//  SwiftSingleView
//
//  Created by dongchx on 14/06/2018.
//  Copyright © 2018 dongchx. All rights reserved.
//

import UIKit

class SAAnimationCollectionViewController:
UIViewController,
UICollectionViewDelegate,
UICollectionViewDataSource {
    
    private let reuseId = "collectionViewCellReuseId";
    private let itemCount = 30;
    private var dataList : [String]!;
    private var collectionView : UICollectionView!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.setupSubviews(parentView: self.view);
        self.reloadData();
        self.title = "CollectionView";
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    //MARK: - subviews
    
    func setupSubviews(parentView : UIView) {
        
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = UICollectionViewScrollDirection.vertical;
        layout.minimumInteritemSpacing = 18;
        layout.minimumLineSpacing = 18;
        layout.sectionInset = UIEdgeInsetsMake(14, 16, 0, 16);
        
        self.collectionView = UICollectionView(frame: parentView.frame, collectionViewLayout: layout);
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView?.register(SAAnimationCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseId);
        self.collectionView?.backgroundColor = UIColor.yellow;
        parentView.addSubview(self.collectionView);
        
        let buttonFrame = CGRect(x: 0, y: parentView.frame.size.height - 100, width: 100, height: 60);
        let button = UIButton(frame: buttonFrame);
        let center = CGPoint(x: parentView.center.x, y: button.center.y);
        button.center = center;
        button.backgroundColor = UIColor.green;
        button.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside);
        parentView.addSubview(button);
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)));
        longPressGesture.minimumPressDuration = 0.5;
        self.collectionView.addGestureRecognizer(longPressGesture);
    }
    
    func reloadData() {
        var array : [String] = [String]();
        for i in 0...self.itemCount {
            let str = String(i);
            array.append(str);
        }
        self.dataList = array;
    }
    
//    func controllerDict() -> Dictionary {
//        return {
//        }
//    }

    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemCount;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! SAAnimationCollectionViewCell;
        
        if indexPath.row < self.dataList.count {
            let data = self.dataList[indexPath.row];
            cell.setCellData(data: data);
        }
        
        return cell;
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = SABezierViewController();
        self.navigationController?.pushViewController(VC, animated: true);
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        print("collectionView canMove item");
        return true;
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("source: %ld destination: %ld", sourceIndexPath.row, destinationIndexPath.row);
        let source = self.dataList[sourceIndexPath.row]
        
        self.dataList.remove(at: sourceIndexPath.row);
        self.dataList.insert(source, at: destinationIndexPath.row);
        
        self.collectionView?.reloadData();
    }
    
    
    //MARK: - Action
    @objc func buttonTapAction() {
        print("buttonTapAction");
        self.reloadData();
        self.collectionView?.reloadData();
    }
    
    @objc func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            let cell = self.collectionView.cellForItem(at: selectedIndexPath)
            cell?.contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5);
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            self.collectionView.endInteractiveMovement()
            self.collectionView.reloadData();
        default:
            self.collectionView.cancelInteractiveMovement()
            self.collectionView.reloadData();
        }
    }
}










