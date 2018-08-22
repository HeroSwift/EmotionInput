
import UIKit

public class EmotionGrid: UIView {
    
    public var emotionList = [Emotion]() {
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
    
    public var cellLabelTextFont = UIFont.systemFont(ofSize: 14)
    public var cellLabelTextColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)
    
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
        
        let layout = UICollectionViewFlowLayout()
        
//        layout.itemSize = CGSize.init(width: 80, height: 80)
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = columnSpacing
        layout.minimumInteritemSpacing = rowSpacing
        layout.sectionInset = UIEdgeInsetsMake(paddingVertical, paddingHorizontal, paddingVertical, paddingHorizontal)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
    }
    
}


extension EmotionGrid: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionCell
        
        cell.setEmotion(emotion: emotionList[indexPath.item])
        
        return cell
    }
}

extension EmotionGrid: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if emotionList[indexPath.item].isValid() {
            print("You selected cell #\(indexPath.item)!")
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if emotionList[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = cellBackgroundColorPressed
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if emotionList[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.clear
        }
    }
    
}
