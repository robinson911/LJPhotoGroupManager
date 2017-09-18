//
//  LJPhotoView.swift
//  TFSwift
//
//  Created by 孙伟伟 on 2017/9/12.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

import Foundation
import UIKit

class LJPhotoView: UIScrollView {
    
    var ljInfo : LJPhotoInfo?
    
    lazy var ljImageView : UIImageView = {
            let view = UIImageView()
            view.clipsToBounds = true
            view.contentMode = .scaleAspectFit
            return view
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.zoomScale = 1.0
        self.addSubview(self.ljImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LJPhotoView{
    func setCurrentImageview(_ info : LJPhotoInfo){
        self.ljInfo = info
        if self.ljInfo?.thumbImageview?.image == nil{
           self.ljInfo?.thumbImageview?.image = UIImage.init(named: "pic_broadcast_gray_square")
        }
        
        //无url，则通过thumbImageview获取Image展示
        //self.ljImageview.image = info.thumbImageview.image;
        let y : CGFloat? = (AppHeight - (info.thumbImageview?.image?.size.height)! * AppWidth / (info.thumbImageview?.image?.size.width)!) * 0.5;
        self.ljImageView.frame = CGRect(x: 0, y: y!, width: AppWidth, height: AppWidth*(info.thumbImageview?.image?.size.height)!/(info.thumbImageview?.image?.size.width)!)
        self.ljImageView.image = self.ljInfo?.thumbImageview?.image
        
        //请求网络图片
//        if info.largeImageURLStr != "" {
//            let url = URL(string:info.largeImageURLStr!)
//            self.ljImageView.kf.setImage(with: url)
//        }
    }
}
