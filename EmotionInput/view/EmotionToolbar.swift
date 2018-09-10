
import UIKit
import SimpleButton

class EmotionToolbar: UIView {
    
    var emotionIconList = [EmotionIcon]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 工具栏的高度
    let height = CGFloat(44)
    
    // 图标单元格宽度
    let cellWidth = CGFloat(44)
    
    // 表情单元格分割线颜色
    let cellDividerColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
    
    // 表情单元格按下时的背景色
    let cellBackgroundColorPressed = UIColor(red: 244 / 255, green: 242 / 255, blue: 246 / 255, alpha: 1)
    
    // 发送按钮的文本
    let sendButtonText = "发送"
    
    // 发送按钮的文本字体
    let sendButtonTextFont = UIFont.systemFont(ofSize: 14)
    
    // 发送按钮的文本颜色
    let sendButtonTextColor = UIColor(red: 121 / 255, green: 121 / 255, blue: 121 / 255, alpha: 1)
    
    // 发送按钮左边框
    let sendButtonBorderColor = UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1)
    
    // 发送按钮的背景颜色
    let sendButtonBackgroundColor = UIColor(red: 249 / 255, green: 248 / 255, blue: 249 / 255, alpha: 1)

    // 发送按钮的左右内间距
    let sendButtonPaddingLeft = CGFloat(14)
    let sendButtonPaddingRight = CGFloat(14)
    
    var onIconClick: ((_ icon: EmotionIcon) -> Void)?
    var onSendClick: (() -> Void)?
    
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    // 发送按钮
    private var sendButton: SimpleButton!
    
    private let cellIdentifier = "icon"
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: height)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(EmotionIconCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        
        sendButton = SimpleButton()
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle(sendButtonText, for: .normal)
        sendButton.setTitleColor(sendButtonTextColor, for: .normal)
        sendButton.titleLabel?.font = sendButtonTextFont
        sendButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: sendButtonPaddingLeft, bottom: 0, right: sendButtonPaddingRight)
        sendButton.backgroundColor = sendButtonBackgroundColor
        
        sendButton.layer.shadowColor = UIColor.black.cgColor
        sendButton.layer.shadowOpacity = 0.15
        sendButton.layer.shadowOffset = CGSize(width: -3, height: 0)
        sendButton.layer.shadowRadius = 3
        
        sendButton.setLeftBorder(width: 1 / UIScreen.main.scale, color: sendButtonBorderColor)
        
        sendButton.onClick = {
            self.onSendClick?()
        }

        addSubview(sendButton)

        addConstraints([
            
            NSLayoutConstraint(item: sendButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: sendButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: sendButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0),

            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: sendButton, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            
        ])
        
        clipsToBounds = true

    }
    
}

extension EmotionToolbar: UICollectionViewDelegate {
    
    // 点击事件
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onIconClick?(emotionIconList[indexPath.item])
    }
    
    // 按下事件
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = cellBackgroundColorPressed
    }
    
    // 松手事件
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .clear
    }
    
}

extension EmotionToolbar: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionIconList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmotionIconCell
        let index = indexPath.item
        let icon = emotionIconList[index]
        
        if index > 0 {
            cell.dividerView.isHidden = false
            cell.dividerView.backgroundColor = cellDividerColor
        }
        else {
            cell.dividerView.isHidden = true
        }
        cell.imageView.image = UIImage(named: icon.iconName)
        cell.backgroundColor = icon.selected ? cellBackgroundColorPressed : .clear
        
        return cell
    }
    
}

extension EmotionToolbar: UICollectionViewDelegateFlowLayout {
    
    // 行间距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 列间距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.bounds.size.height)
    }
    
}

extension EmotionToolbar {
    
    class EmotionIconCell: UICollectionViewCell {
        
        var dividerView: UIView!
        var imageView: UIImageView!
        
        var dividerOffset = CGFloat(6)
        var divierWidth = 1 / UIScreen.main.scale
        
        public override init(frame: CGRect) {
            
            super.init(frame: frame)
            
            dividerView = UIView()
            dividerView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(dividerView)
            
            imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .center
            addSubview(imageView)
            
            addConstraints([
                
                NSLayoutConstraint(item: dividerView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: dividerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: dividerOffset),
                NSLayoutConstraint(item: dividerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -dividerOffset),
                NSLayoutConstraint(item: dividerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: divierWidth),
                
                NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),

            ])
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}

