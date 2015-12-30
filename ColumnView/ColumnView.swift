//
//  ColumnView.swift
//  ColumnView
//
//  Created by xuemincai on 15/12/28.
//  Copyright © 2015年 xuemincai. All rights reserved.
//

import UIKit
import SnapKit

class ColumnView: UIView {

    var xVals: Array<UILabel>? = Array<UILabel>()
    var yColumnar: Array<UIImageView>? = Array<UIImageView>()
    var ycolumnarMask: Array<UIView>? = Array<UIView>()
    var dots: Array<UIImageView>? = Array<UIImageView>()
    var lineView: UIView? = UIView()
    var sampleLab: UILabel? = UILabel()
    var sampleImage: UIImageView? = UIImageView(image: UIImage(named: "color_small"))
    var maxValue = 10000
    var columnarValues: Array<Double>? = Array<Double>()
    var isStartAnim = false
        
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        addSubviews()
        defineLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     添加子视图
     */
    func addSubviews() {
        
        for index in 0...6 {
            
            xVals?.append(UILabel());
            yColumnar?.append(UIImageView(image: UIImage(named: "barChart")))
            ycolumnarMask?.append(UIView())
            dots?.append(UIImageView(image: UIImage(named: "dot")))
            
            self.addSubview(xVals![index])
            self.addSubview(dots![index])
            xVals![index].text = "\(index)"
            self.addSubview(yColumnar![index])
            ycolumnarMask![index].backgroundColor = UIColor.whiteColor()
            yColumnar![index].addSubview(ycolumnarMask![index])
        }
        
        sampleLab?.text = "示例"
        self.addSubview(sampleLab!)
        self.addSubview(sampleImage!)
        
        lineView?.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(lineView!)
    }
    
    
    /**
     定义布局
     */
    func defineLayout() {
        
        let gap : CGFloat = (UIScreen.mainScreen().bounds.width - ((2*30) + (6*7))) / 6
        
        sampleImage?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(self).offset(-15)
            make.top.equalTo(self).offset(25)
            make.size.equalTo(CGSize(width: 11, height: 11))
        })
        
        sampleLab?.snp_makeConstraints(closure: { (make) -> Void in
            make.right.equalTo(sampleImage!.snp_left).offset(-5)
            make.centerY.equalTo(sampleImage!)
        })
        
        for index in 0...6 {
            
            xVals![index].snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self).offset(-12)
                make.centerX.equalTo(dots![index])
                make.height.equalTo(16)
            })
            
            dots![index].snp_makeConstraints(closure: { (make) -> Void in
                
                if index == 0 {
                    make.left.equalTo(self).offset(30)
                } else {
                    make.left.equalTo(self).offset((gap * CGFloat(index)) + CGFloat(index*6) + 30)
                }
                
                make.bottom.equalTo(xVals![index].snp_top).offset(-10)
                make.size.equalTo(CGSize(width: 6, height: 6))
            })
            
            yColumnar![index].snp_makeConstraints(closure: { (make) -> Void in
                make.centerX.equalTo(dots![index])
                make.bottom.equalTo(dots![index].snp_top).offset(-10)
                make.width.equalTo(30)
                make.top.equalTo(sampleImage!.snp_bottom).offset(30)
            })
            
            ycolumnarMask![index].snp_makeConstraints(closure: { (make) -> Void in
                make.top.bottom.left.right.equalTo(yColumnar![index])
            })
            
        }
        
        lineView!.snp_makeConstraints { (make) -> Void in
            
            make.width.equalTo(self)
            make.centerY.equalTo(dots![0])
            make.height.equalTo(0.5)
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"startAnim", userInfo: nil, repeats: false)
        
    }
    
    /**
     开始动画效果
     */
    func startAnim() {
        
        if isStartAnim == false {
            isStartAnim = true
            self.setNeedsUpdateConstraints()
            self.updateConstraintsIfNeeded()
            UIView.animateWithDuration(2, animations: { () -> Void in
                self.layoutIfNeeded()
            })
        }
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if isStartAnim == false {
            
            return
        }
        
        var index: Int = 0
        
        for colValue in columnarValues! {
            
            var percent: Double = colValue / Double(maxValue)
            
            percent = (percent > 1 ? 1 :percent)
            
            ycolumnarMask![index].snp_updateConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(yColumnar![index]).offset(-(Double(yColumnar![index].frame.height) * percent))
            })
            
            index++
            
        }
        
    }

}
