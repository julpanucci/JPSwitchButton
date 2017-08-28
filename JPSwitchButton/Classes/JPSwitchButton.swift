//
//  MyButton.swift
//  CustomButton
//
//  Created by Panucci, Julian R on 3/22/17.
//  Copyright © 2017 Panucci, Julian R. All rights reserved.
//

import UIKit

@IBDesignable
public class JPSwitchButton: UIView {
    
    
    //MARK:Constants
    let kLabelHeight: CGFloat = 42.0
    let kLabelFontSizeSmall: CGFloat = 16.0
    let kLabelFontSizeLarge: CGFloat = 22.0
    

    //MARK: Inspectables
    @IBInspectable var cornerRadius: CGFloat = 20.0
    @IBInspectable var shadow: CGFloat = 0.0
    @IBInspectable open var duration: Double = 0.5
    @IBInspectable var onTintColor: UIColor = .blue
    @IBInspectable public var isOn = false
        @IBInspectable var offColor: UIColor = .black
    
    private var longPressGesture: UILongPressGestureRecognizer!
    private var shortDescriptionLabel: UILabel?
    private var titleLabel: UILabel?
    private var descriptionLabel: UILabel?
    private var imageView: UIImageView?
    


    fileprivate var shape: CAShapeLayer! = CAShapeLayer()
    
    private var rectShape = CAShapeLayer()
    private var startShape: CGPath!
    private var endShape: CGPath!
    private var button: UIButton!
    private var image: UIImage?
    
    
    open var animationDidStartClosure = {(onAnimation: Bool) -> Void in }
    open var animationDidStopClosure  = {(onAnimation: Bool, finished: Bool) -> Void in }
    open var onClick = { () -> Void in }
    open var onLongPress = { () -> Void in }
    open var isEnabled: Bool = true
    
    public var buttonTitle: String? {
        didSet {
            self.titleLabel?.text = buttonTitle
        }
    }
    
    public var buttonDescription: String? {
        didSet {
            self.descriptionLabel?.text = buttonDescription
        }
    }
    
    var shortText: String? {
        didSet {
            guard let shortText = shortText else {
                return
            }
            shortDescriptionLabel?.text = shortText
            shortDescriptionLabel?.font = shortText.characters.count > 7 ? UIFont(name: "Futura", size: kLabelFontSizeSmall) : UIFont(name: "Futura", size: kLabelFontSizeLarge)
            shortDescriptionLabel?.numberOfLines = shortText.contains(" ") ? 0 : 1
            shortDescriptionLabel?.lineBreakMode = .byWordWrapping
            shortDescriptionLabel?.adjustsFontSizeToFitWidth = true
            shortDescriptionLabel?.text = shortText
            shortDescriptionLabel?.textAlignment = .center
        }
    }
    
    var labelColor: UIColor = .white {
        didSet {
            shortDescriptionLabel?.textColor = labelColor
            titleLabel?.textColor = labelColor
            descriptionLabel?.textColor = labelColor
        }
    }
    var imageColor: UIColor = .white {
        didSet {
            imageView?.tintColor = imageColor
        }
    }
    
    
    public override var frame: CGRect  {
        didSet {
            let imageSize = 0.14 * frame.width
            let imageY = (frame.height - imageSize) / 2
            let imageX: CGFloat = 8.0
            let imageFrame = CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize)
            imageView?.frame = imageFrame
            
            let fontSize = sqrt(self.frame.width * self.frame.height) / 10.0
            let titleLabelFrame = CGRect(x: 8, y: 5, width: Int(self.frame.width - 16), height: 20)
            titleLabel?.frame = titleLabelFrame
            titleLabel?.font = UIFont(name: "Futura", size: fontSize)
            
            let labelHeight = self.frame.height - titleLabelFrame.height
            let labelWidth = self.frame.width - imageFrame.size.width - 16
            let labelY  = titleLabelFrame.height + 5
            let labelX = imageFrame.size.width + 15
            
            let font = sqrt(self.frame.width * self.frame.height) / 11.5
            let descriptionLabelFrame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            descriptionLabel?.frame = descriptionLabelFrame
            descriptionLabel?.font = UIFont(name: "Futura", size: font)
            
        }
    }
    
    public override func layoutSubviews() {
        commonInit()
    }
    

    public override func draw(_ rect: CGRect) {
        layer.cornerRadius = cornerRadius
        commonInit()
    }
    
    public init(frame: CGRect, offColor: UIColor, onColor: UIColor, image: UIImage?, title: String?, description: String?, isOn: Bool = false) {
        super.init(frame: frame)
        
        buttonTitle = title
        buttonDescription = description
        
        if let image = image {
            self.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        self.onTintColor = onColor
        self.offColor = offColor
        
        //Add image view
        let imageSize = 0.14 * frame.width
        let imageY = (frame.height - imageSize) / 2
        let imageX: CGFloat = 8.0
        imageView = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize))
        imageView?.image = self.image
        imageView?.contentMode = .scaleAspectFit
        self.addSubview(imageView!)
        
        //Add title label
        let fontSize = sqrt(self.frame.width * self.frame.height) / 10.0
        let titleLabelFrame = CGRect(x: 8, y: 10, width: Int(self.frame.width - 16), height: 35)
        titleLabel = UILabel(frame: titleLabelFrame)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont(name: "Futura", size: fontSize)
        titleLabel?.minimumScaleFactor = 0.5
        titleLabel?.text = title
        titleLabel?.numberOfLines = 1
        titleLabel?.lineBreakMode = .byWordWrapping
        addSubview(titleLabel!)
        
        //Add description label
        let labelHeight = self.frame.height - titleLabelFrame.height
        let labelWidth = self.frame.width - (imageView?.frame.size.width)! - 16
        let labelY  = titleLabelFrame.height + 5
        let labelX = (imageView?.bounds.size.width)! + 8
        let font = sqrt(self.frame.width * self.frame.height) / 11.5
        let descriptionLabelFrame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        descriptionLabel = UILabel(frame: descriptionLabelFrame)
        descriptionLabel?.adjustsFontSizeToFitWidth = true
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.lineBreakMode = .byWordWrapping
        descriptionLabel?.font = UIFont(name: "Futura", size: font)
        descriptionLabel?.text = description
        descriptionLabel?.textAlignment = .center
        descriptionLabel?.minimumScaleFactor = 0.5
        addSubview(descriptionLabel!)
    
        self.backgroundColor = offColor
        layer.cornerRadius = cornerRadius
        
        self.isOn = isOn
        
        commonInit()
    }
   
   public init(frame: CGRect, offColor: UIColor, onColor: UIColor, image: UIImage, shortText: String, isOn: Bool) {
        super.init(frame: frame)

        self.image = image.withRenderingMode(.alwaysTemplate)
        self.onTintColor = onColor
        self.offColor = offColor
        
        //Add image view and label
        let labelWidth = 0.575 * frame.width
        let imageSize = 0.25 * frame.width
        let imageY = (frame.height - imageSize) / 2
        let imageX: CGFloat = 8.0
        let labelX = labelWidth - imageSize + 10
        imageView = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize))
            imageView?.image = self.image
        imageView?.contentMode = .scaleAspectFit
        
        shortDescriptionLabel = UILabel(frame: CGRect(x: labelX, y: (imageView?.center.y)! - kLabelHeight / 2.0, width: labelWidth, height: kLabelHeight))
        shortDescriptionLabel?.font = shortText.characters.count > 7 ? UIFont(name: "Futura", size: kLabelFontSizeSmall) : UIFont(name: "Futura", size: kLabelFontSizeLarge)
        shortDescriptionLabel?.numberOfLines = shortText.contains(" ") ? 0 : 1
        shortDescriptionLabel?.lineBreakMode = .byWordWrapping
        shortDescriptionLabel?.adjustsFontSizeToFitWidth = true
        shortDescriptionLabel?.text = shortText
        shortDescriptionLabel?.textAlignment = .center
        
        self.addSubview(imageView!)
        self.addSubview(shortDescriptionLabel!)
        
        self.backgroundColor = offColor
        layer.cornerRadius = cornerRadius
        
        self.isOn = isOn
        commonInit()
    }
    
   public init(frame: CGRect ,color: UIColor) {
        super.init(frame: frame)
        onTintColor = color
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Helpers
    fileprivate func commonInit() {
        
        button = UIButton(frame: layer.bounds)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(JPSwitchButton.buttonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(JPSwitchButton.unShrink), for: .touchCancel)
        button.addTarget(self, action: #selector(JPSwitchButton.unShrink), for: .touchDragExit)
        button.addTarget(self, action: #selector(JPSwitchButton.shrink), for: .touchDown)
        self.addSubview(button)
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(JPSwitchButton.longPress(sender:)))
        longPressGesture.delegate = self
        self.addGestureRecognizer(longPressGesture)
        
        let rectBounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        startShape = UIBezierPath(roundedRect: rectBounds, cornerRadius: 50).cgPath
        
        let height = layer.bounds.height * 5.0
        let width = height
        let x = height / -2.4 - 20
        let y = x
        let radius = CGFloat(height / 2.0)
        
        endShape = UIBezierPath(roundedRect: CGRect(x: x, y: y, width: width, height: height), cornerRadius: radius).cgPath
        
        rectShape.path = startShape
        rectShape.fillColor = onTintColor.cgColor
        rectShape.bounds = rectBounds
        rectShape.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        rectShape.cornerRadius = rectBounds.width / 2
        
        layer.insertSublayer(rectShape, at: 0)
        layer.masksToBounds = true
        
        if isOn {
            turnOn(animated: false)
        }else {
            turnOff(animated: false)
        }

    }
    
    
    
    // MARK: - Animations
    fileprivate func animateButton(toValue to: CGPath, animated: Bool = true) {
        
        let animation = CABasicAnimation(keyPath: "path")
        
        animation.toValue               = to
        animation.fromValue = rectShape.path
        animation.timingFunction        = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode              = kCAFillModeBoth
        animation.duration              = duration
        animation.delegate              = self
        
        if animated {
            rectShape.add(animation, forKey: animation.keyPath)
        }
        rectShape.path = to
    }
    
    public func turnOn(animated: Bool = true) {
        //If button is off, turn it on
        animateButton(toValue: endShape, animated: animated)
        isOn = true

        UIView.animate(withDuration: 0.5, animations: { 
            self.imageView?.tintColor = self.offColor
            self.labelColor = self.offColor
        })
    }
    
    public func turnOff(animated: Bool = true) {
        animateButton(toValue: startShape, animated: animated)
        isOn = false
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView?.tintColor = self.onTintColor
            self.labelColor = self.onTintColor
        })

    }
    
    public func switchState() {
        isOn ? turnOff() : turnOn()
    }
    
    internal func buttonAction() {
        if isEnabled {
            onClick()
        }
        unShrink()
    }
    
    internal func longPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            onLongPress()
        }
    }
    
    internal func shrink() {
        UIView.animate(withDuration: 0.5) { 
             self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    internal func unShrink() {
        UIView.animate(withDuration: 0.5) { 
            self.transform = CGAffineTransform.identity
        }
    }
}

extension JPSwitchButton: UIGestureRecognizerDelegate {
    
}

extension JPSwitchButton: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        animationDidStartClosure(isOn)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animationDidStopClosure(isOn, flag)
    }
}
