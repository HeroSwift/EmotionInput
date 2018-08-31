
import UIKit

class EmotionCell: UIView {
    
    //
    // MARK: - 界面元素
    //
    
    // 显示表情图片
    var emotionView: UIImageView!
    
    // 显示表情文字
    var nameView: UILabel!
    
    // 显示删除按钮
    var deleteView: UIImageView!
    
    //
    // MARK: - 界面配置
    //
    
    // 单元格文本字体
    var nameTextFont = UIFont.systemFont(ofSize: 12)
    
    // 单元格文本颜色
    var nameTextColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
    
    // 单元格文本与表情的距离
    var nameMarginTop = CGFloat(10)
    
    // 删除按钮的图片
    var deleteImageName = "delete"
    
    //
    // MARK: - 表情数据
    //
    
    var emotion: Emotion?
    
    //
    // MARK: - 布局约束
    //
    
    private var emotionTopConstraint: NSLayoutConstraint!
    private var emotionCenterXConstraint: NSLayoutConstraint!
    
    private var nameTopConstraint: NSLayoutConstraint!
    private var nameCenterXConstraint: NSLayoutConstraint!
    
    private var deleteCenterXConstraint: NSLayoutConstraint!
    private var deleteCenterYConstraint: NSLayoutConstraint!
    
    private var emotionWidthConstraint: NSLayoutConstraint?
    private var emotionHeightConstraint: NSLayoutConstraint?
    

    //
    // MARK: - 获取 View 的真实尺寸
    //
    
    public override var intrinsicContentSize: CGSize {
        
        var width = CGFloat(0)
        var height = CGFloat(0)
        
        if !deleteView.isHidden {
            width = deleteView.intrinsicContentSize.width
            height = deleteView.intrinsicContentSize.height
        }
        else if !emotionView.isHidden {
            
            if let constraint = emotionWidthConstraint {
                width = constraint.constant
            }
            else {
                width = emotionView.intrinsicContentSize.width
            }
            
            if let constraint = emotionHeightConstraint {
                height = constraint.constant
            }
            else {
                height = emotionView.intrinsicContentSize.height
            }
            
            if !nameView.isHidden {
                let labelSize = nameView.intrinsicContentSize
                height += nameMarginTop + labelSize.height
                if labelSize.width > width {
                    width = labelSize.width
                }
            }
        }

        return CGSize(width: width, height: height)
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化界面元素和约束
    func setup() {
        
        emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        emotionView.translatesAutoresizingMaskIntoConstraints = false
        emotionView.contentMode = UIViewContentMode.scaleAspectFit
        emotionView.isHidden = true
        
        nameView = UILabel()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.font = nameTextFont
        nameView.textColor = nameTextColor
        nameView.isHidden = true
        
        deleteView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        deleteView.image = UIImage(named: deleteImageName)
        deleteView.isHidden = true

        backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)

        emotionTopConstraint = NSLayoutConstraint(item: emotionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        emotionCenterXConstraint = NSLayoutConstraint(item: emotionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        nameTopConstraint = NSLayoutConstraint(item: nameView, attribute: .top, relatedBy: .equal, toItem: emotionView, attribute: .bottom, multiplier: 1.0, constant: nameMarginTop)
        nameCenterXConstraint = NSLayoutConstraint(item: nameView, attribute: .centerX, relatedBy: .equal, toItem: emotionView, attribute: .centerX, multiplier: 1.0, constant: 0)
        
        deleteCenterXConstraint = NSLayoutConstraint(item: deleteView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        deleteCenterYConstraint = NSLayoutConstraint(item: deleteView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        
    }
    
    func showEmotion(emotion: Emotion, emotionWidth: Int, emotionHeight: Int) {

        self.emotion = emotion
        
        showEmotionView(emotionWidth: emotionWidth, emotionHeight: emotionHeight)
        hideDeleteView()
        
        if emotion.imageName != "" {
            emotionView.image = UIImage(named: emotion.imageName)
        }
        
        if emotion.name != "" {
            nameView.text = emotion.name
            nameView.sizeToFit()
            showNameView()
        }
        else {
            hideNameView()
        }
        
        invalidateIntrinsicContentSize()
    }
    
    func showDelete() {
        hideEmotionView()
        hideNameView()
        showDeleteView()
        invalidateIntrinsicContentSize()
    }
    
    func showNothing() {
        hideEmotionView()
        hideNameView()
        hideDeleteView()
        invalidateIntrinsicContentSize()
    }
    
    func hasContent() -> Bool {
        return !emotionView.isHidden || !deleteView.isHidden
    }
    
}

extension EmotionCell {
    
    private func showEmotionView(emotionWidth: Int, emotionHeight: Int) {
        
        let fromHidden = emotionView.isHidden
        
        if fromHidden {
            addSubview(emotionView)
            emotionView.isHidden = false
            addConstraints([ emotionTopConstraint, emotionCenterXConstraint ])
        }
        
        if emotionWidth > 0 && emotionHeight > 0 {
            
            let width = CGFloat(emotionWidth)
            let height = CGFloat(emotionHeight)
            
            if let constraint = emotionWidthConstraint {
                constraint.constant = width
                if fromHidden {
                    addConstraint(constraint)
                }
            }
            else {
                emotionWidthConstraint = NSLayoutConstraint(item: emotionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: width)
                if let constraint = emotionWidthConstraint {
                    addConstraint(constraint)
                }
            }
            
            if let constraint = emotionHeightConstraint {
                constraint.constant = height
                if fromHidden {
                    addConstraint(constraint)
                }
            }
            else {
                emotionHeightConstraint = NSLayoutConstraint(item: emotionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: height)
                if let constraint = emotionHeightConstraint {
                    addConstraint(constraint)
                }
            }
            
        }
        else {
            if let constraint = emotionWidthConstraint {
                if !fromHidden {
                    removeConstraint(constraint)
                }
                emotionWidthConstraint = nil
            }
            if let constraint = emotionHeightConstraint {
                if !fromHidden {
                    removeConstraint(constraint)
                }
                emotionHeightConstraint = nil
            }
        }
        
    }
    
    private func hideEmotionView() {
        
        let fromVisible = !emotionView.isHidden
        
        if fromVisible {
            
            emotion = nil
            
            removeConstraints([ emotionTopConstraint, emotionCenterXConstraint ])
            if let constraint = emotionWidthConstraint {
                removeConstraint(constraint)
            }
            if let constraint = emotionHeightConstraint {
                removeConstraint(constraint)
            }
            
            emotionView.isHidden = true
            emotionView.removeFromSuperview()
            
        }
        
    }
    
    private func showNameView() {
        
        let fromHidden = nameView.isHidden
        
        if fromHidden {
            addSubview(nameView)
            nameView.isHidden = false
            addConstraints([ nameTopConstraint, nameCenterXConstraint ])
        }
        
    }
    
    private func hideNameView() {
        
        let fromVisible = !nameView.isHidden
        
        if fromVisible {
            removeConstraints([ nameTopConstraint, nameCenterXConstraint ])
            nameView.isHidden = true
            nameView.removeFromSuperview()
        }
        
    }
    
    private func showDeleteView() {
        
        let fromHidden = deleteView.isHidden
        
        if fromHidden {
            addSubview(deleteView)
            deleteView.isHidden = false
            addConstraints([ deleteCenterXConstraint, deleteCenterYConstraint ])
        }
        
    }
    
    private func hideDeleteView() {
        
        let fromVisible = !deleteView.isHidden
        
        if fromVisible {
            removeConstraints([ deleteCenterXConstraint, deleteCenterYConstraint ])
            deleteView.isHidden = true
            deleteView.removeFromSuperview()
        }
        
    }
    
}
