//
//  LJPhotoInfo.swift
//  TFSwift
//
//  Created by 孙伟伟 on 2017/9/12.
//  Copyright © 2017年 孙伟伟. All rights reserved.
//

import Foundation
import UIKit

public let AppWidth: CGFloat = UIScreen.main.bounds.size.width
public let AppHeight: CGFloat = UIScreen.main.bounds.size.height

class LJPhotoInfo: NSObject {

    var currentSelectIndex : Int?
    var largeImageURLStr : String?
    var thumbImageview : UIImageView?
    
    override init() {
        super.init()
    }
}
