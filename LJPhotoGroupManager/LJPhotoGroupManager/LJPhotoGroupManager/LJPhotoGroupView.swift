//
//  LJPhotoGroupView.swift
//  TFSwift
//
//  Created by 孙伟伟 on 2017/9/12.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

import Foundation
import UIKit

class LJPhotoGroupView: UIView {
    
    let baseIndex = 1000
    
    var originFrame : CGRect? // 图片的源尺寸
    var currentIndex : NSInteger = 0 //当前选中的图片index
    var ljPhotoArray : [Any] = [Any]()//存储多组需要加载的图片原始信息
    
    lazy var ljScrollView : UIScrollView = {
        let view  = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
        view.delegate = self
        view.isPagingEnabled = true
        //view.backgroundColor = UIColor.yellow
        return view
    }()
    
    lazy var currentIndexLabel : UILabel = {
        let view = UILabel.init(frame: CGRect(x: 0, y: 22, width: AppWidth, height: 20))
        view.textAlignment = .center
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor.white
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.ljScrollView)
        
        //顶部透明条
        let topBar = UIView()
        topBar.frame = CGRect(x: 0, y: 0, width: AppWidth, height: 64)
        topBar.backgroundColor = UIColor.lightGray
        //topBar.alpha = 0.5
        self.addSubview(topBar)
        
        topBar.addSubview(self.currentIndexLabel)
    }

    func setData(_ photoArray : Array<Any>, selectedIndex : NSInteger) {
        self.ljScrollView.contentSize = CGSize(width: floor(AppWidth) * CGFloat(photoArray.count), height: AppHeight)
        self.currentIndex = selectedIndex
        self.ljPhotoArray = photoArray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LJPhotoGroupView {

// MARK: -- 图片cell复用
    func dequeueReusableCell() -> LJPhotoView {
        
        var cell = self.viewWithTag(baseIndex + self.currentIndex) as? LJPhotoView
        
        if ljPhotoArray.count > currentIndex {
            let info = ljPhotoArray[currentIndex] as? LJPhotoInfo
            let tempImageView = info?.thumbImageview

            if cell != nil{
                self.originFrame = tempImageView?.convert((tempImageView?.bounds)!, to: self)
                return cell!
            }
            
            cell = LJPhotoView.init(frame: CGRect(x: floor(AppWidth)*CGFloat(currentIndex), y: 0, width: AppWidth, height: AppHeight))
            self.originFrame = tempImageView?.convert((tempImageView?.bounds)!, to: self)
        }
        return cell!
    }
  
// MARK: -- 展示图片
    func showPhotoView(){
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.backgroundColor = UIColor.black
        
        self.setTopCurrentIndex(self.currentIndex)
    
        let cell1 = self.dequeueReusableCell()
        cell1.tag = self.baseIndex + self.currentIndex
        
        var ljTempImage : UIImage?
        if ljPhotoArray.count > currentIndex {
            let info = ljPhotoArray[currentIndex] as? LJPhotoInfo
            ljTempImage = info?.thumbImageview?.image
        }
        
        ljTempImage = (ljTempImage != nil) ? ljTempImage : UIImage.init(named: "pic_broadcast_gray_square")
        
        let tfImageView  = UIImageView.init(image: ljTempImage)
        tfImageView.frame = self.originFrame ?? CGRect.zero
        tfImageView.clipsToBounds = true
        //tfImageView.backgroundColor = UIColor.red
        tfImageView.contentMode = .scaleAspectFit
        self.addSubview(tfImageView)
        
        //添加页面消失的手势
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hideImageView))
        self.addGestureRecognizer(tap)
        
        UIView.animate(withDuration: 0.25, animations: {
            let y : CGFloat? = (AppHeight - (ljTempImage?.size.height)! * AppWidth / (ljTempImage?.size.width)!)/2.0
            let height : CGFloat? = (ljTempImage?.size.height)! * AppWidth / (ljTempImage?.size.width)!
            tfImageView.frame = CGRect(x: 0, y: y!, width: AppWidth, height: height!)
        }) { (finish) in
            //根据选中第几张图片直接展示出来
            let cell = self.dequeueReusableCell()
            cell.tag = self.baseIndex + self.currentIndex
            //cell.backgroundColor = UIColor.gray
            
            if self.ljPhotoArray.count > self.currentIndex{
                cell.setCurrentImageview(self.ljPhotoArray[self.currentIndex] as! LJPhotoInfo)
            }
            let x : CGFloat = CGFloat(self.currentIndex) * floor(AppWidth);
            self.ljScrollView.setContentOffset(CGPoint.init(x: x, y: 0), animated: false)
            self.ljScrollView.addSubview(cell)
            
            
            tfImageView.removeFromSuperview()
        }
    }
    
// MARK: -- 移除图片
    func hideImageView(){
        let cell = self.viewWithTag(baseIndex + currentIndex) as? LJPhotoView
        UIView.animate(withDuration: 0.25, animations: {
            cell?.ljImageView.frame = self.originFrame!
        }) { (finish) in
            self.backgroundColor = UIColor.white
            self.removeFromSuperview()
        }
    }
    
// MARK: -- 设置顶部的标题
    func setTopCurrentIndex(_ page : Int){
        if self.ljPhotoArray.count == 0 {
            self.currentIndexLabel.text = ""
        }else{
            self.currentIndexLabel.text = "\(page + 1)/\(self.ljPhotoArray.count)"
        }
    }
}

extension LJPhotoGroupView : UIScrollViewDelegate{
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //滑动时，会调用多次
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     //滑动完毕时，只会调用一次
        let page = self.ljScrollView.contentOffset.x / self.frame.size.width;
        self.currentIndex = NSInteger(page);
        print("scrollViewDidEndDecelerating当前页数----\(page)")
        
        self.setTopCurrentIndex(self.currentIndex)
        
        let cell = self.dequeueReusableCell()
        cell.tag = self.baseIndex + Int(page)
        if self.ljPhotoArray.count > self.currentIndex{
            cell.setCurrentImageview(self.ljPhotoArray[self.currentIndex] as! LJPhotoInfo)
        }
        self.ljScrollView.addSubview(cell)
    }
}
