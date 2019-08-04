//
//  BaseNavigationBar.swift
//  week6
//
//  Created by Trương Quốc Tài on 7/23/19.
//  Copyright © 2019 Trương Quốc Tài. All rights reserved.
//

import UIKit
protocol BaseNavigationBarDelegate {
    func touchUpInsideBtnRight(_ view: UIView,_ btnRight:UIButton)
}
@IBDesignable
class BaseNavigationBar: UIView {

    @IBOutlet var vContainer: UIView!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var lblMid: UILabel!
    
    @IBAction func onBtnRight(_ sender: Any) {
        self.delegate?.touchUpInsideBtnRight(self, btnRight)
    }
    
    var delegate:BaseNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    func defaultInit(){
        let bundle =  Bundle(for: BaseNavigationBar.self)
        bundle.loadNibNamed("BaseNavigationBar", owner: self, options: nil)
        self.vContainer.fixInView(self)
    }
}

extension UIView{
    func fixInView(_ container: UIView) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
}
