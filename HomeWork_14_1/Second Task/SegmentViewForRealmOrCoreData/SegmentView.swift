//
//  XibView.swift
//  HomeWork_11
//
//  Created by Vlad Ralovich on 6/5/20.
//  Copyright © 2020 Vonkad. All rights reserved.
//

import UIKit

protocol SegmentViewDelegate: NSObjectProtocol {
    func SegmentViewPressed(_ testView: String)
}

@IBDesignable
class SegmentView: UIView {
    
    weak var delegate: SegmentViewDelegate?
    
    @IBOutlet var segmentView: UIView!
    @IBOutlet var myButton1: UIButton!
    @IBOutlet var myButton2: UIButton!
    
    //cоздаю подложку
    @IBOutlet var underView: UIView!
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?
    var moveTo = CGPoint()
    

    @IBInspectable var colorBackground: UIColor = .red {
        didSet { segmentView.backgroundColor = colorBackground }
    }
    
    @IBInspectable var colorUnder: UIColor = .red {
        didSet { underView.backgroundColor = colorUnder }
    }
    @IBInspectable var textButton1: String = "First" {
        didSet { myButton1.setTitle(textButton1, for: .normal) }
    }
    @IBInspectable var textButton2: String = "Second" {
        didSet { myButton2.setTitle(textButton2, for: .normal) }
    }
    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet { layer.cornerRadius = cornerRadius
            underView.layer.cornerRadius = cornerRadius }
    }
    @IBAction func presedbutton1(_ sender: Any) {
        
        delegate?.SegmentViewPressed("Выбран Realm")
        moveTo = myButton1.center
        createAnimatorAndBehavior()
    }
    
    @IBAction func presedButton2(_ sender: Any) {
        
        delegate?.SegmentViewPressed("Выбран CoreData")
        moveTo = myButton2.center
        createAnimatorAndBehavior()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegment()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSegment()
    }
    
    func setupSegment() {
            
        let bundle = Bundle(for: SegmentView.self)
        bundle.loadNibNamed("SengemtView", owner: self, options: nil)
        addSubview(segmentView)
        segmentView.frame = bounds
        segmentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func createAnimatorAndBehavior() {
        
        let collision = UICollisionBehavior(items: [underView])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
        animator = UIDynamicAnimator(referenceView: self)
        
        if snapBehavior != nil {
            animator.removeBehavior(snapBehavior!)
        }
        
        snapBehavior = UISnapBehavior(item: underView, snapTo: moveTo)
        snapBehavior?.damping = 0.5
        animator.addBehavior(snapBehavior!)
    }
}
