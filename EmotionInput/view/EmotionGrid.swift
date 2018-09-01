
import UIKit

public class EmotionGrid: UICollectionViewCell {
    
    var emotionPage = EmotionPage([:]) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 表情网格容器的上下 padding
    public var paddingVertical = CGFloat(10)
    
    // 表情网格容器的左右 padding
    public var paddingHorizontal = CGFloat(10)
    
    // 行间距
    public var rowSpacing = CGFloat(15)
    
    // 列间距
    public var columnSpacing = CGFloat(10)
    
    // 表情单元格按下时的背景色
    public var cellBackgroundColorPressed = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    private let cellIdentifier = "cell"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
    
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(EmotionGridCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        
        addConstraints([
            
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            
        ])

    }
    
}

extension EmotionGrid: UICollectionViewDataSource {
    
    // 获取表情数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionPage.emotionList.count
    }
    
    // 复用 cell 组件
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmotionGridCell
        let index = indexPath.item
        let emotion = emotionPage.emotionList[index]
        
        if emotionPage.hasDeleteButton && index == emotionPage.rows * emotionPage.columns - 1 {
            cell.emotionCell.showDelete()
        }
        else if emotion.isValid() {
            cell.emotionCell.showEmotion(emotion: emotion, emotionWidth: emotionPage.width, emotionHeight: emotionPage.height)
        }
        else {
            cell.emotionCell.showNothing()
        }
        
        return cell
    }
    
}

extension EmotionGrid: UICollectionViewDelegate {
    
    // 点击事件
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.emotionCell.hasContent() {
            if let emotion = cell.emotionCell.emotion {
                print(emotion.name)
            }
            else {
                print("delete")
            }
        }
    }
    
    // 按下事件
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.emotionCell.hasContent() {
            cell.backgroundColor = cellBackgroundColorPressed
        }
    }
    
    // 松手事件
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.emotionCell.hasContent() {
            cell.backgroundColor = .clear
        }
    }
    
}

extension EmotionGrid: UICollectionViewDelegateFlowLayout {
    
    // 设置内边距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let rowCount = CGFloat(emotionPage.rows)
        let rowHeight = getCellSize().height
        let contentHeight = rowCount * rowHeight + (rowCount - 1) * rowSpacing
        
        let paddingVertical = (collectionView.frame.height - contentHeight) / 2
        
        return UIEdgeInsets(top: paddingVertical, left: paddingHorizontal, bottom: paddingVertical, right: paddingHorizontal)
    
    }
    
    // 行间距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return rowSpacing
    }
    
    // 列间距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return columnSpacing
    }
    
    // 设置单元格尺寸
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getCellSize()
    }
    
}

extension EmotionGrid {
    
    // 实时计算单元格尺寸
    func getCellSize() -> CGSize {
        
        let columnCount = CGFloat(emotionPage.columns)
        let marginsAndInsets = paddingHorizontal * 2 + flowLayout.sectionInset.left + flowLayout.sectionInset.right + columnSpacing * (columnCount - 1)
        let width = ((collectionView.frame.width - marginsAndInsets) / columnCount).rounded(.down)

        // 计算 itemHeight 最大值
        let rowCount = CGFloat(emotionPage.rows)
        let maxHeight = ((collectionView.frame.height - 2 * paddingVertical - (rowCount - 1) * rowSpacing) / rowCount).rounded(.down)
        
        return CGSize(width: width, height: min(width, maxHeight))
        
    }
    
    // 为了让 View 垂直居中搞的这么麻烦...
    class EmotionGridCell: UICollectionViewCell {
        
        var emotionCell: EmotionCell!
        
        public override init(frame: CGRect) {
            
            super.init(frame: frame)
            
            emotionCell = EmotionCell(frame: frame)
            emotionCell.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(emotionCell)
            
            addConstraints([
                NSLayoutConstraint(item: emotionCell, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: emotionCell, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
            ])
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

}
