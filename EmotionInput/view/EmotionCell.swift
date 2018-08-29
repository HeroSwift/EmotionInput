
import UIKit

class EmotionCell: UIView {
    
    // 显示表情图片
    var emotionView: UIImageView!
    
    // 显示表情文字
    var nameLabel: UILabel!
    
    // 显示删除按钮
    var deleteView: UIImageView!
    
    // 其实我是不想存这几个属性的，但是要用在 intrinsicContentSize 计算中
    private var emotionWidth = CGFloat(0)
    private var emotionHeight = CGFloat(0)
    private var labelMarginTop = CGFloat(0)
    
    public override var intrinsicContentSize: CGSize {
        
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        if emotionView == nil {
            width = deleteView.intrinsicContentSize.width
            height = deleteView.intrinsicContentSize.height
        }
        else {
            width = emotionWidth > 0 ? emotionWidth : emotionView.intrinsicContentSize.width
            height = emotionHeight > 0 ? emotionHeight : emotionView.intrinsicContentSize.height
            
            if !nameLabel.isHidden {
                let labelSize = nameLabel.intrinsicContentSize
                height += labelMarginTop + labelSize.height
                if labelSize.width > width {
                    width = labelSize.width
                }
            }
            
        }
        
        return CGSize(width: width, height: height)
        
    }
    
    func setup(emotion: Emotion, labelTextFont: UIFont, labelTextColor: UIColor, labelMarginTop: CGFloat, emotionWidth: Int, emotionHeight: Int) {

        emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        emotionView.translatesAutoresizingMaskIntoConstraints = false
        emotionView.contentMode = UIViewContentMode.scaleAspectFit
        addSubview(emotionView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = labelTextFont
        nameLabel.textColor = labelTextColor
        addSubview(nameLabel)
        
        backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)

        self.labelMarginTop = labelMarginTop
        
        addConstraints([
            
            NSLayoutConstraint(item: emotionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: emotionView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: emotionView, attribute: .bottom, multiplier: 1.0, constant: labelMarginTop),
            
        ])
        
        if emotionWidth > 0 && emotionHeight > 0 {

            self.emotionWidth = CGFloat(emotionWidth)
            self.emotionHeight = CGFloat(emotionHeight)
            
            addConstraints([
                
                NSLayoutConstraint(item: emotionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: self.emotionWidth),
                NSLayoutConstraint(item: emotionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.emotionHeight),
                
            ])
            
        }
        
        if emotion.imageName != "" {
            emotionView.image = UIImage(named: emotion.imageName)
        }
        
        if emotion.name != "" {
            nameLabel.text = emotion.name
            nameLabel.sizeToFit()
            nameLabel.isHidden = false
        }
        else {
            nameLabel.isHidden = true
        }
        
    }
    
    func setup(deleteImageName: String) {
        
        deleteView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        deleteView.image = UIImage(named: deleteImageName)
        addSubview(deleteView)
        
        addConstraints([
            
            NSLayoutConstraint(item: deleteView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: deleteView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            
        ])
        
    }
    
}
