
import UIKit

public class EmotionGrid: UIView {
    
    public var emotions = [Emotion]()
    
    // 表情网格容器的左右 padding
    public var emotionGridPaddingHorizontal = CGFloat(10)
    
    // 表情网格容器的上下 padding
    public var emotionGridPaddingVertical = CGFloat(10)
    
    // 行间距
    public var emotionRowSpacing = CGFloat(20)
    
    // 列间距
    public var emotionColumnSpacing = CGFloat(10)
    
    // 表情单元格按下时的背景色
    public var emotionCellBackgroundColorPressed = UIColor(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
    
    
    private let reuseIdentifier = "cell"
    
    override init(frame: CGRect) {
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
        layout.minimumLineSpacing = emotionColumnSpacing
        layout.minimumInteritemSpacing = emotionRowSpacing
        layout.sectionInset = UIEdgeInsetsMake(emotionGridPaddingVertical, emotionGridPaddingHorizontal, emotionGridPaddingVertical, emotionGridPaddingHorizontal)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
    }
    
}


extension EmotionGrid: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionCell
        
        cell.setEmotion(emotion: emotions[indexPath.item])
        
        return cell
    }
}

extension EmotionGrid: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if emotions[indexPath.item].isValid() {
            print("You selected cell #\(indexPath.item)!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if emotions[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = emotionCellBackgroundColorPressed
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if emotions[indexPath.item].isValid() {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = UIColor.clear
        }
    }
    
}
