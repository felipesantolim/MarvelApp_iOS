//
//  BaseXibView.swift
//  MarvelAppSupport
//
//  Created by Felipe Henrique Santolim on 21/09/18.
//  Copyright © 2018 Felipe Santolim. All rights reserved.
//

import UIKit

open class BaseXibView: UIView {
    
    public var shouldLayoutSubviews = false
    @IBOutlet public weak var view: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        xibSetup("\(type(of: self))")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup("\(type(of: self))")
    }
    
    open func xibSetup( _ named: String ) {
        view = loadViewFromNib( named )
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    internal func loadViewFromNib(_ named: String) -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: named, bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    override open func layoutSubviews() {
        guard shouldLayoutSubviews else { return }
        
        super.layoutSubviews()
        
        if let size = superview?.frame.size {
            frame.size = size
        }
    }
}

