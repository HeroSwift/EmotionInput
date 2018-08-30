
import UIKit

public class EmotionGrid: UIView {
    
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
    
    private let reuseIdentifier = "cell"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        print("创建 EmotionGrid \(frame)")
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
    
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(EmotionGridCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.cyan
        
        addSubview(collectionView)

    }
    
}

extension EmotionGrid: UICollectionViewDataSource {
    
    // 获取表情数量
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionPage.emotionList.count
    }
    
    // 复用 cell 组件
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 其实这里不存在复用
        // 全是新建
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionGridCell
        let emotion = emotionPage.emotionList[indexPath.item]
        
        print("获取第几个单元格视图: \(indexPath.item) \(cell.isEmotion || cell.isDelete)")
        
        if emotionPage.hasDeleteButton && indexPath.item == emotionPage.rows * emotionPage.columns - 1 {
            cell.showDelete()
        }
        else if emotion.isValid() {
            cell.showEmotion(emotion: emotion, emotionWidth: emotionPage.width, emotionHeight: emotionPage.height)
        }
        else {
            cell.showNothing()
        }
        
        return cell
    }
    
}

extension EmotionGrid: UICollectionViewDelegate {
    
    // 点击事件
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.isEmotion {
            let emotion = emotionPage.emotionList[indexPath.item]
        }
        else if cell.isDelete {
            
        }
    }
    
    // 按下事件
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.isEmotion || cell.isDelete {
            cell.backgroundColor = cellBackgroundColorPressed
        }
    }
    
    // 松手事件
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EmotionGridCell
        if cell.isEmotion || cell.isDelete {
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
        print("获取单元格尺寸: \(getCellSize())")
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
    
    class EmotionGridCell: UICollectionViewCell {
        
        var emotionCell: EmotionCell!
        
        var isEmotion = false
        var isDelete = false
        
        public override init(frame: CGRect) {
            
            super.init(frame: frame)
            
            emotionCell = EmotionCell(frame: frame)
            emotionCell.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(emotionCell)
            
            contentView.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
            
            addConstraints([
                
                NSLayoutConstraint(item: emotionCell, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
                NSLayoutConstraint(item: emotionCell, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0),
                
            ])
            
        }
        
        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func showEmotion(emotion: Emotion, emotionWidth: Int, emotionHeight: Int) {
            isDelete = false
            isEmotion = true
            emotionCell.showEmotion(emotion: emotion, emotionWidth: emotionWidth, emotionHeight: emotionHeight)
        }
        
        func showDelete() {
            isDelete = true
            isEmotion = false
            emotionCell.showDelete()
        }
        
        func showNothing() {
            isDelete = false
            isEmotion = false
            emotionCell.showNothing()
        }
        
    }

}
