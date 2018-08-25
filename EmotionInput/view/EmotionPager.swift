
import UIKit

public class EmotionPager: UIView {
    
    public var emotionSet = EmotionSet([:]) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // 列间距
    public var columnSpacing = CGFloat(10)
    
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
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = bounds.size
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(EmotionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
    }
    
}


extension EmotionPager: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionSet.emotionPageList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionCell
        cell.setEmotionPage(emotionPage: emotionSet.emotionPageList[indexPath.item])
        return cell
    }
    
}


extension EmotionPager {
    
    class EmotionCell: UICollectionViewCell {
        
        var emotionGrid: EmotionGrid!
        

        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        private func setup() {
            
            emotionGrid = EmotionGrid(frame: contentView.frame)
            
            contentView.addSubview(emotionGrid)
            contentView.backgroundColor = UIColor.brown
            
        }
        
        func setEmotionPage(emotionPage: EmotionPage) {
            
            emotionGrid.emotionPage = emotionPage
            
        }
    
    }
}
