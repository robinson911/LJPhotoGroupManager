//
//  ViewController.swift
//  LJPhotoGroupManager
//
//  Created by 孙伟伟 on 2017/9/14.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

import Foundation
import UIKit

class ViewController : UIViewController{

    lazy var ljArray : [LJPhotoInfo] = [LJPhotoInfo]()
    let ljUrlArray = ["http://pica.nipic.com/2007-12-12/20071212235955316_2.jpg",
                      "http://d.lanrentuku.com/down/png/1706/10avatars-material-pngs/avatars-material-man-4.png",
                      "http://image.nationalgeographic.com.cn/2017/0703/20170703042329843.jpg",
                      "http://image.nationalgeographic.com.cn/2015/0121/20150121033625957.jpg",
                      "http://image.nationalgeographic.com.cn/2017/0702/20170702124619643.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "图片浏览测试Demo"
        self.setUI()
    }
}

extension ViewController{
    func setUI(){
        
        //for index in 0...4
        for index in 0..<5{
            
            //1.加载本地图片
            let image = UIImage.init(named: "\(index + 1).jpg")
            let showImageView = UIImageView.init()
            showImageView.image = image
            showImageView.tag = index
            showImageView.frame = CGRect(x: Int((AppWidth - 200)/2.0), y: 80 + Int(90 * index), width: 200, height: 80)
            showImageView.isUserInteractionEnabled = true
            view.addSubview(showImageView)
            
            //2.加载网络图片
            //let url = URL(string:ljUrlArray[index])
            //showImageView.kf.setImage(with: url)
            
            let gestrue = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.showClicked(_:)))
            showImageView.addGestureRecognizer(gestrue)
            
            //需要浏览的图片添加到数组
            let info = LJPhotoInfo.init()
            info.largeImageURLStr = ljUrlArray[index]
            info.thumbImageview = showImageView
            info.currentSelectIndex = index
            self.ljArray.append(info)
        }
    }
}

extension ViewController{
    
    func showClicked(_ sender : UITapGestureRecognizer){
        if self.ljArray.count > 0 {
            let index = sender.view?.tag
            let photoGroupView = LJPhotoGroupView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
            photoGroupView.setData(self.ljArray, selectedIndex: index!)
            photoGroupView.showPhotoView()
            
            print("-------\(String(describing: index))")
        }
    }
}

