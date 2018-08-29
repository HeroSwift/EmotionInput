
import UIKit

public class EmotionPager: UIView {
    
    public var emotionSetList = [EmotionSet]() {
        didSet {
            emotionSetIndex = 0
            collectionView.reloadData()
        }
    }
    
    public var emotionSetIndex = 0 {
        didSet {
            
            if emotionSetList.count > emotionSetIndex {
                let emotionSet = emotionSetList[ emotionSetIndex ]
                if emotionSet.hasIndicator {
                    indicatorView.isHidden = false
                    indicatorView.count = emotionSet.emotionPageList.count
                    indicatorView.sizeToFit()
                    indicatorView.setNeedsLayout()
                    indicatorView.setNeedsDisplay()
                }
                else {
                    indicatorView.isHidden = true
                }
            }
            else {
                indicatorView.isHidden = true
            }
            
        }
    }
    
    // indicator 与网格的距离
    public var indicatorMarginTop = CGFloat(10)
    
    private var collectionView: UICollectionView!
    private var indicatorView: DotIndicator!
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        
        collectionView.register(EmotionPagerCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        addSubview(collectionView)
        
        indicatorView = DotIndicator(frame: frame)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorView)

        addConstraints([
            
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -(indicatorView.intrinsicContentSize.height + indicatorMarginTop)),
            

            NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: collectionView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: indicatorView, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1.0, constant: indicatorMarginTop),

        ])
        
    }
    
}


extension EmotionPager: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for set in emotionSetList {
            count += set.emotionPageList.count
        }
        return count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EmotionPagerCell
        
        checkRange(index: indexPath.item) { cell.setup(emotionPage: emotionSetList[$0].emotionPageList[$1]) }
        
        return cell
    }
    
}

extension EmotionPager: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}

extension EmotionPager: UICollectionViewDelegate {
    
    // 翻页事件
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
        let width = scrollView.bounds.size.width

        let index = Int(ceil(x / width))
        
        checkRange(index: index) {
            emotionSetIndex = $0
            indicatorView.index = $1
            indicatorView.setNeedsDisplay()
        }
        
    }
}


extension EmotionPager {
    
    /**
     * 绝对 index 到相对 index 的转换
     */
    private func checkRange(index: Int, callback: (_ setIndex: Int, _ pageIndex: Int) -> Void) {
        var from = 0
        for i in 0..<emotionSetList.count {
            let to = from + emotionSetList[i].emotionPageList.count
            if index >= from && index < to {
                callback(i, index - from)
                break
            }
            from = to
        }
    }
    
    class EmotionPagerCell: UICollectionViewCell {
        
        var emotionGrid: EmotionGrid!
        
        func setup(emotionPage: EmotionPage) {
            
            emotionGrid = EmotionGrid(frame: contentView.frame)
            emotionGrid.setup(emotionPage: emotionPage)

            contentView.addSubview(emotionGrid)
            contentView.backgroundColor = UIColor.brown

        }
    
    }
}
