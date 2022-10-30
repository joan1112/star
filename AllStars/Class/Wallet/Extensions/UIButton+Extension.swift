

//
//  UIButton+Extension.swift
//  IB_iOS
//
//  Created by Lee on 2018/9/3.
//  Copyright © 2018年 Lee. All rights reserved.
//


import UIKit
extension UIButton  {
    
 

    
    
    /**
     设置 图片 显示状态
     
     - parameter images:    图片
     - parameter controlStates: 状态数组
    
     */
    public final func extSetImages(_ images : [UIImage] , controlStates : [UIControl.State] ){
        
        for i in 0..<images.count  {
            
            self.setImage(images[i] , for: controlStates[i])
            
        }
    
    }
    

    /**
     设置 图片 显示状态 事件响应者 响应方法名 默认单击事件
     
     - parameter images:    图片
     - parameter controlStates: 状态数组
     - parameter target:       事件响应者
     - parameter selectName:   响应方法名
     */
    public final func extSetImageNameSelector(_ images : [UIImage] , controlStates : [UIControl.State] , target : AnyObject  , selector : Selector  , tag : Int = 0 ){
        
        for i in 0..<images.count  {
            
            self.setImage(images[i], for: controlStates[i])
            
        }
        
        self.tag = tag
        
        self.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        
    }
    
    /**
     设置图片以及文字样式按钮、文字大小、颜色、以及文字图片内边距
     
     - parameter title:           标题
     - parameter titleColor:      标题颜色
     - parameter imageName:       图片名
     - parameter fontSize:        标题大小 默认18 可不传
     - parameter imageEdgeInsets: 图片内边距 默认 0 0 0 0 可不传
     - parameter titleEdgeInsets: 标题内边距 默认 0 0 0 0 可不传
     - parameter tag:             tag值 默认0 可不传
     */
    public final func extSetTitle(_ title : String , titleColor : UIColor ,  imageName : String , fontSize : CGFloat = 18.0 , imageEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero, titleEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero , tag : Int = 0 ,target : AnyObject? = nil  , selector : Selector){
        
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.tag = tag
        
        if target != nil{
            
            self.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
            
        }
        
    }
    
    public final func extSetAddTarget(_ target : Any ,_ selector : Selector , _ event : UIControl.Event = UIControl.Event.touchUpInside){
        self.addTarget(target, action: selector, for: event)
    }
    
    public final func extSetTitle(_ title : String , _ titleFont : CGFloat , _ titleColor : UIColor , _ state : UIControl.State){
        self.setTitle(title, for: state)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleFont)
        self.setTitleColor(titleColor, for: state)
    }
    
    /**
     设置图片以及文字样式按钮、文字大小、颜色、以及文字图片内边距
     
     - parameter title:           标题
     - parameter titleColor:      标题颜色
     - parameter imageName:       图片名
     - parameter fontSize:        标题大小 默认18 可不传
     - parameter imageEdgeInsets: 图片内边距 默认 0 0 0 0 可不传
     - parameter titleEdgeInsets: 标题内边距 默认 0 0 0 0 可不传
     - parameter tag:             tag值 默认0 可不传
     */
    public final func extSetTitle(_ title : String , titleColor : UIColor , fontSize : CGFloat = 18.0){
        
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    /**
     设置图片以及文字样式按钮、文字大小、颜色、以及文字图片内边距
     
     - parameter title:           标题
     - parameter titleColor:      标题颜色
     - parameter image:       图片
     - parameter fontSize:        标题大小 默认18 可不传
     - parameter imageEdgeInsets: 图片内边距 默认 0 0 0 0 可不传
     - parameter titleEdgeInsets: 标题内边距 默认 0 0 0 0 可不传
     - parameter tag:             tag值 默认0 可不传
     */
    public final func extSetTitle(_ title : String , titleColor : UIColor ,  image : UIImage , fontSize : CGFloat = 18.0 , imageEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero, titleEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero , tag : Int = 0 ,target : AnyObject? = nil  , selector : Selector){
        
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.setImage(image, for: UIControl.State.normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.tag = tag
        
        if target != nil{
            
            self.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
            
        }
        
    }
    
    /**
     设置图片以及文字样式按钮、文字大小、颜色、以及文字图片内边距
     
     - parameter title:           标题
     - parameter titleColor:      标题颜色
     - parameter imageName:       图片名
     - parameter selectImageName  选中图片名
     - parameter fontSize:        标题大小 默认18 可不传
     - parameter imageEdgeInsets: 图片内边距 默认 0 0 0 0 可不传
     - parameter titleEdgeInsets: 标题内边距 默认 0 0 0 0 可不传
     - parameter tag:             tag值 默认0 可不传
     */
    public final func extSetTitle(_ title : String , titleColor : UIColor ,  imageName : String , selectImageName : String , fontSize : CGFloat = 18.0 , imageEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero, titleEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero , tag : Int = 0 ,target : AnyObject? = nil  , selector : Selector){
        
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.setImage(UIImage.init(named: imageName), for: UIControl.State.normal)
        self.setImage(UIImage.init(named: selectImageName), for: UIControl.State.selected)
        self.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.tag = tag
        
        if target != nil{
            
            self.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
            
        }
        
    }
    
    
    /**
     设置图片以及文字样式按钮、文字大小、颜色、以及文字图片内边距
     
     - parameter title:           标题
     - parameter titleColor:      标题颜色
     - parameter image:           图片
     - parameter selectImage      选中图片
     - parameter fontSize:        标题大小 默认18 可不传
     - parameter imageEdgeInsets: 图片内边距 默认 0 0 0 0 可不传
     - parameter titleEdgeInsets: 标题内边距 默认 0 0 0 0 可不传
     - parameter tag:             tag值 默认0 可不传
     */
    public final func extSetTitle(_ title : String , titleColor : UIColor ,  image : UIImage , selectImage : UIImage , fontSize : CGFloat = 18.0 , imageEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero, titleEdgeInsets : UIEdgeInsets = UIEdgeInsets.zero , tag : Int = 0 ,target : AnyObject? = nil  , selector : Selector){
        
        self.setTitle(title, for: UIControl.State.normal)
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        self.setImage(image, for: UIControl.State.normal)
        self.setImage(selectImage, for: UIControl.State.selected)
        self.titleLabel!.font = UIFont.systemFont(ofSize: fontSize)
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
        self.tag = tag
        
        if target != nil{
            
            self.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
            
        }
        
    }
    
    /**
     按钮的状态改变
     */
    public final func extChangeBtnSelect(){
    
        self.isSelected = self.isSelected == true ? false : true
        
    }
    
    /**
     根据给的颜色更改btn的backgroundColor
    */
    public final func extsetBackgroundColor(backgroundColor : UIColor,state : UIControl.State){
    
//        self.setBackgroundImage(nil, forState: state)
        
        self.setBackgroundImage(self.imageWithColor(backgroundColor), for: state)
    
    }
    
    public final func imageWithColor(_ color : UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
        
    }
    
    private struct AssociatedKeys {
        static var topNameKey = "topNameKey"
        static var leftNameKey = "leftNameKey"
        static var bottomNameKey = "bottomNameKey"
        static var rightNameKey = "rightNameKey"
    }

    /**
     扩大按钮点击范围
     
     - parameter top:    顶部扩大多少
     - parameter left:   左边扩大多少
     - parameter bottom: 底部扩大多少
     - parameter right:  右边扩大多少
     */
    public final func setEnlargeEdgeWithTop(_ top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        
        objc_setAssociatedObject(self, &AssociatedKeys.topNameKey, NSNumber.init(value: Float(top)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.leftNameKey, NSNumber.init(value: Float(left)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.bottomNameKey, NSNumber.init(value: Float(bottom)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.rightNameKey, NSNumber.init(value: Float(right)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
    }
    
    /**
     把点击范围设置成size大小
     
     - parameter size: 调整后的点击范围的大小
     */
    public final func setTouchAreaToSize(_ size: CGSize) {
        var top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0
        if size.width > self.frame.size.width {
            left = (size.width - self.frame.size.width) / 2
            right = left
        }
        
        if (size.height > self.frame.size.height) {
            top = (size.height - self.frame.size.height) / 2
            bottom = top
        }
        setEnlargeEdgeWithTop(top, left: left, bottom: bottom, right: right)
    }
    
    public final func enlargedRect() -> CGRect {
        
        let topEdge = objc_getAssociatedObject(self, &AssociatedKeys.topNameKey) as? NSNumber
        let rightEdge = objc_getAssociatedObject(self, &AssociatedKeys.rightNameKey) as? NSNumber
        let bottomEdge = objc_getAssociatedObject(self, &AssociatedKeys.bottomNameKey) as? NSNumber
        let leftEdge = objc_getAssociatedObject(self, &AssociatedKeys.leftNameKey) as? NSNumber
        
        if topEdge != nil && rightEdge != nil && bottomEdge != nil && leftEdge != nil {
            
            return CGRect(x :self.bounds.origin.x - CGFloat.init(truncating:leftEdge!),
                          y :self.bounds.origin.y - CGFloat.init(truncating:topEdge!),
                          width: self.bounds.size.width + CGFloat.init(truncating:leftEdge!) + CGFloat.init(truncating:rightEdge!),
                          height:self.bounds.size.height + CGFloat.init(truncating:topEdge!) + CGFloat.init(truncating:bottomEdge!))
        } else {
            return self.bounds
        }
    }
    
    //倒计时，btn的type需要为custom
    public func countdown(_ num : Int ,unit : String = "s" ,defaultValue : String = "" , complete : (() -> ())? = nil){
        if num >= 0{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.setTitle("\(num)" + unit, for: UIControl.State.normal)
                self.countdown(num - 1,defaultValue:defaultValue,complete : complete)
            }
            self.isEnabled = false
        }else{
            self.setTitle(defaultValue, for: UIControl.State.normal)
            self.isEnabled = true
            if complete != nil{
                complete!()
            }
        }
    }

    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = self.enlargedRect()
        if rect.equalTo(self.bounds) || self.isHidden {
            return super.hitTest(point, with: event)
        }
        if rect.contains(point) {
            return self
        } else {
            return nil
        }
    }
    
    //设置左文字右图片
    func setLeftTextAndRightImg(){
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.size.width, 0, btn.imageView.size.width)];
//        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(self.imageView?.image?.size.width)!, bottom: 0, right: (self.imageView?.image?.size.width)!)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (self.titleLabel?.bounds.size.width)!, bottom: 0, right: -(self.titleLabel?.bounds.size.width)!)
    }
    
}

extension UIButton {

    // MARK: - 链式语法设置button属性
    @discardableResult func set(font:UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult func set(color:UIColor,state:UIControl.State = .normal) -> Self {
        self.setTitleColor(color , for: state)
        return self
    }
    
    @discardableResult func set(title:String?) -> Self {
        self.setTitle(title, for: .normal)
        return self
    }
    
    /// 更改button字体样式
    func setTitleFont(str: String) {
        let strArray = str.components(separatedBy: " ")
        if strArray.count == 2 {
            let strNum = NSMutableAttributedString.init(string: strArray[0], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: .bold)])
            let strSuffix = NSMutableAttributedString.init(string: strArray[1], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
            strNum.append(NSMutableAttributedString.init(string: " "))
            strNum.append(strSuffix)
            self.titleLabel?.attributedText = strNum
        }
    }
    
    /// 设置正常和高亮下的图片,防止点击长按是自动渲染
    ///
    /// - Parameters:
    ///   - image: 给UIImageView设置值
    ///   - backgroundImage: 给background设置.不传则清空
    func zf_set(image:UIImage? = nil , backgroundImage:UIImage? = nil) {
        setImage(image, for: UIControl.State.normal)
        setImage(image, for: UIControl.State.highlighted)
        setBackgroundImage(backgroundImage, for: UIControl.State.normal)
        setBackgroundImage(backgroundImage, for: UIControl.State.highlighted)
    }
    
    func set(backgroundImage:UIImage)  {
        self.setBackgroundImage(backgroundImage, for: .normal)
    }
    
    func set(highlightedBackgroundImage:UIImage){
        self.setBackgroundImage(highlightedBackgroundImage, for: .highlighted)
    }
    
    func layoutVertical(titleMargin : CGFloat,topOffset:CGFloat){
        sizeToFit()
        self.titleLabel?.textAlignment = .center
        let imageSize:CGSize = self.imageView!.frame.size
        let titleSize:CGSize = self.titleLabel!.frame.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0 + topOffset, left:-imageSize.width, bottom: -imageSize.height - titleMargin, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - titleMargin + topOffset, left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func layoutHorizontal(titleMargin : CGFloat , topOffset : CGFloat = 0) {
        sizeToFit()
        let margin = titleMargin / 2.0
        let top = topOffset / 2.0
        titleEdgeInsets = UIEdgeInsets(top: top, left: margin, bottom: -top, right: -margin)
        imageEdgeInsets = UIEdgeInsets(top: top, left: -margin, bottom: -top, right: margin)
    }
    
}

extension UIButton {
    //MARK: -定义button相对label的位置
    enum ButtonImagePosition {
        case top          //图片在上，文字在下，垂直居中对齐
        case bottom       //图片在下，文字在上，垂直居中对齐
        case left         //图片在左，文字在右，水平居中对齐
        case right        //图片在右，文字在左，水平居中对齐
    }
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func imagePosition(style: ButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
