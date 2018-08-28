
import UIKit

public class EmotionGrid: UIView {
    
    public var emotionPage = EmotionPage([:]) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 表情网格容器的左右 padding
    public var paddingHorizontal = CGFloat(10)
    
    // 行间距
    public var rowSpacing = CGFloat(40)
    
    // 列间距
    public var columnSpacing = CGFloat(10)
    
    // 表情单元格按下时的背景色
    public var cellBackgroundColorPressed = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
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
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.cyan
        
        addSubview(collectionView)
        
//        addConstraints([
//
//            NSLayoutConstraint(item: collectionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
//            NSLayoutConstraint(item: collectionView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
//
//        ])

    }
    
}

extension EmotionGrid: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionPage.emotionList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionCell
        cell.setup(emotionWidth: emotionPage.width, emotionHeight: emotionPage.height)
        cell.setEmotion(emotion: emotionPage.emotionList[indexPath.item])
        return cell
    }
    
}

extension EmotionGrid: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
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

        let rowCount = CGFloat(emotionPage.rows)
        let itemHeight = getItemSize().height
        let contentHeight = rowCount * itemHeight + (rowCount - 1) * rowSpacing
        
        let paddingVertical = (collectionView.frame.height - contentHeight) / 2
        
        return UIEdgeInsets(top: paddingVertical, left: paddingHorizontal, bottom: paddingVertical, right: paddingHorizontal)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return rowSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return columnSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getItemSize()
    }
    
}

extension EmotionGrid {
    
    func getItemSize() -> CGSize {
        
        let columnCount = CGFloat(emotionPage.columns)
        let marginsAndInsets = paddingHorizontal * 2 + flowLayout.sectionInset.left + flowLayout.sectionInset.right + columnSpacing * (columnCount - 1)
        let width = ((collectionView.frame.width - marginsAndInsets) / columnCount).rounded(.down)

        // 计算 itemHeight 最大值
        let rowCount = CGFloat(emotionPage.rows)
        let maxHeight = (collectionView.frame.height - (rowCount - 1) * rowSpacing) / rowCount
        
        return CGSize(width: width, height: min(width, maxHeight))
        
    }
    
    class EmotionCell: UICollectionViewCell {
        
        var emotionCell: EmotionGridCell!
        
        func setup(emotionWidth: Int, emotionHeight: Int) {
            
            emotionCell = EmotionGridCell()
            emotionCell.setup(emotionWidth: emotionWidth, emotionHeight: emotionHeight)
            
            emotionCell.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(emotionCell)
            
            contentView.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
            
            addConstraints([
                
                NSLayoutConstraint(item: emotionCell, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: emotionCell, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0),
                
            ])
            
            clipsToBounds = true
            
        }
        
        func setEmotion(emotion: Emotion) {
            emotionCell.setEmotion(emotion: emotion)
        }
        
    }

}
