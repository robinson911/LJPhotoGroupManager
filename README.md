# LJPhotoGroupManager-----swift3.0版本的图片放大缩小效果
5张图片，展示出来。然后利用图片放大缩小管理类展示图片，多张图片可以滑动浏览

一个简单的图片浏览放大缩小管理器 2.支持图片放大和缩小效果，同时图片是原去原回的放大缩小效果
简单易用 简单使用如下：
func showClicked(_ sender : UITapGestureRecognizer){
        if self.ljArray.count > 0 {
            let index = sender.view?.tag
            let photoGroupView = LJPhotoGroupView.init(frame: CGRect(x: 0, y: 0, width: AppWidth, height: AppHeight))
            photoGroupView.setData(self.ljArray, selectedIndex: index!)
            photoGroupView.showPhotoView()
            
            print("-------\(String(describing: index))")
        }
    }
    跟我OC这篇效果图类似：
![image](https://github.com/robinson911/LJPhotoGroup/blob/master/2017-07-31%2020_08_540000000.gif)


