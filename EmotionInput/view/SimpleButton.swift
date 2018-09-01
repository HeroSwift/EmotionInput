
import UIKit

public class SimpleButton: UIButton {
    
    public var onPress: (() -> Void)?
    
    private var leftBorder: CALayer?
    private var topBorder: CALayer?
    private var rightBorder: CALayer?
    private var bottomBorder: CALayer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addTarget(self, action: #selector(self.touchUpInside), for: .touchUpInside)
    }
    
    public func setBackgroundColor(color: UIColor, for state: UIControlState) {
        if let image = makeImage(color: color) {
            setBackgroundImage(UIImage(cgImage: image), for: state)
        }
    }
    
    public func setLeftBorder(width: CGFloat, color: UIColor) {
        if let border = leftBorder {
            border.removeFromSuperlayer()
        }
        leftBorder = CALayer()
        if let border = leftBorder {
            border.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
            border.backgroundColor = color.cgColor
            layer.addSublayer(border)
        }
    }
    
    public func setTopBorder(width: CGFloat, color: UIColor) {
        if let border = topBorder {
            border.removeFromSuperlayer()
        }
        topBorder = CALayer()
        if let border = topBorder {
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
            border.backgroundColor = color.cgColor
            layer.addSublayer(border)
        }
    }
    
    public func setRightBorder(width: CGFloat, color: UIColor) {
        if let border = rightBorder {
            border.removeFromSuperlayer()
        }
        rightBorder = CALayer()
        if let border = rightBorder {
            border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: frame.size.height)
            border.backgroundColor = color.cgColor
            layer.addSublayer(border)
        }
    }
    
    public func setBottomBorder(width: CGFloat, color: UIColor) {
        if let border = bottomBorder {
            border.removeFromSuperlayer()
        }
        bottomBorder = CALayer()
        if let border = bottomBorder {
            border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
            border.backgroundColor = color.cgColor
            layer.addSublayer(border)
        }
    }
    
    private func makeImage(color: UIColor) -> CGImage? {
        
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = context?.makeImage()
        
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    @objc private func touchUpInside() {
        onPress?()
    }
    
}
