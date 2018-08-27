
import UIKit

class EmotionGridCell: UIView {
    
    // 显示表情图片
    var emotionView: UIImageView!
    
    // 显示表情文字
    var nameLabel: UILabel!
    
    // 显示删除按钮
    var deleteView: UIImageView!
    
    // 单元格文本字体
    public var labelTextFont = UIFont.systemFont(ofSize: 12)
    
    // 单元格文本颜色
    public var labelTextColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
    
    // 单元格文本与表情的距离
    public var labelMarginTop = CGFloat(10)
    
    public override var intrinsicContentSize: CGSize {
        
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        if emotionView.isHidden {
            width = deleteView.intrinsicContentSize.width
            height = deleteView.intrinsicContentSize.height
        }
        else {
            width = emotionView.frame.width
            height = emotionView.frame.height + labelMarginTop + nameLabel.intrinsicContentSize.height
            if nameLabel.intrinsicContentSize.width > width {
                width = nameLabel.intrinsicContentSize.width
            }
        }

        return CGSize(width: width, height: height)
        
    }
    
    func setup(emotionWidth: Int, emotionHeight: Int) {
        
        emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        // 按比例缩放
        emotionView.contentMode = UIViewContentMode.scaleAspectFit
        emotionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emotionView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = labelTextFont
        nameLabel.textColor = labelTextColor
        
        addSubview(nameLabel)
        
        deleteView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteView)
        
        backgroundColor = UIColor.blue
        
        
        
        addConstraints([
            
            NSLayoutConstraint(item: emotionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: emotionView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: emotionView, attribute: .bottom, multiplier: 1.0, constant: labelMarginTop),
            
        ])
        
        if emotionWidth > 0 && emotionHeight > 0 {
            
            addConstraints([
                
                NSLayoutConstraint(item: emotionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: CGFloat(emotionWidth)),
                NSLayoutConstraint(item: emotionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: CGFloat(emotionHeight)),
                
            ])
            
            emotionView.setNeedsLayout()
            emotionView.layoutIfNeeded()
            
        }
        
    }
    
    func setEmotion(emotion: Emotion) {
        
        if !emotion.isValid() {
            return
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
    
}
