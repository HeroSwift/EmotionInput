
import UIKit

public class EmotionGrid: UIView {
    
    public var emotionPage = EmotionPage([:]) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 表情网格容器的左右 padding
    public var paddingHorizontal = CGFloat(10)
    
    // 表情网格容器的上下 padding
    public var paddingVertical = CGFloat(10)
    
    // 行间距
    public var rowSpacing = CGFloat(20)
    
    // 列间距
    public var columnSpacing = CGFloat(10)
    
    
    
    // 表情单元格按下时的背景色
    public var cellBackgroundColorPressed = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
    
    private var collectionView: UICollectionView!
    private let reuseIdentifier = "cell"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
    
        clipsToBounds = true
        backgroundColor = UIColor.clear
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
    }
    
}


extension EmotionGrid: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionPage.emotionList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionCell
        
        cell.setEmotion(emotion: emotionPage.emotionList[indexPath.item], emotionWidth: emotionPage.width, emotionHeight: emotionPage.height)

        return cell
    }
    
}

extension EmotionGrid: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if emotionPage.emotionList[indexPath.item].isValid() {
            print("You selected cell #\(indexPath.item)!")
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if emotionPage.emotionList[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = cellBackgroundColorPressed
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if emotionPage.emotionList[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.clear
        }
    }
    
}

extension EmotionGrid: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: paddingVertical, left: paddingHorizontal, bottom: paddingVertical, right: paddingHorizontal)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return rowSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return columnSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let marginsAndInsets = paddingHorizontal * 2 + flowLayout.sectionInset.left + flowLayout.sectionInset.right + columnSpacing * CGFloat(emotionPage.columns - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(emotionPage.columns)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
}

extension EmotionGrid {
    
    class EmotionCell: UICollectionViewCell {
        
        var emotionView: UIImageView!
        
        var nameLabel: UILabel!
        
        var deleteView: UIImageView!
        
        // 单元格文本字体
        public var labelTextFont = UIFont.systemFont(ofSize: 12)
        
        // 单元格文本颜色
        public var labelTextColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
        
        // 单元格文本与表情的距离
        public var labelMarginTop = CGFloat(10)
        
        private var hasSetEmotionSize = false
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        private func setup() {
            
            emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            // 按比例缩放
            emotionView.contentMode = UIViewContentMode.scaleAspectFit
            
            emotionView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(emotionView)
            
            nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.font = labelTextFont
            nameLabel.textColor = labelTextColor
            
            contentView.addSubview(nameLabel)
            
            deleteView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            deleteView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(deleteView)
            
            contentView.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
            
            addConstraints([
                
                NSLayoutConstraint(item: emotionView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: emotionView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0),
                
                NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: emotionView, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: emotionView, attribute: .bottom, multiplier: 1.0, constant: labelMarginTop),
                
            ])
            
            clipsToBounds = true
            
        }
        
        func setEmotion(emotion: Emotion, emotionWidth: Int, emotionHeight: Int) {
            
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
            
            let width = Int(emotionView.frame.size.width)
            let height = Int(emotionView.frame.size.height)

            if !hasSetEmotionSize && emotionWidth > 0 && emotionHeight > 0 {

                addConstraints([
                    
                    NSLayoutConstraint(item: emotionView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: CGFloat(emotionWidth)),
                    NSLayoutConstraint(item: emotionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: CGFloat(emotionHeight)),
                
                ])
                
                hasSetEmotionSize = true
                
            }
            
        }
        
    }

}
