
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
                    showIndicatorView()
                    indicatorView.count = emotionSet.emotionPageList.count
                    indicatorView.sizeToFit()
                    indicatorView.setNeedsLayout()
                    indicatorView.setNeedsDisplay()
                }
                else {
                    hideIndicatorView()
                }
            }
            else {
                hideIndicatorView()
            }
            
        }
    }
    
    // indicator 与网格的距离
    public var indicatorMarginTop = CGFloat(10)
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    private var indicatorView: DotIndicator!
    
    private let cellIdentifier = "grid"
    
    private var collectionBottomConstraint: NSLayoutConstraint!
    private var indicatorCenterXConstraint: NSLayoutConstraint!
    private var indicatorTopConstraint: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(EmotionGrid.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        
        indicatorView = DotIndicator(frame: frame)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true

        indicatorCenterXConstraint = NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: collectionView, attribute: .centerX, multiplier: 1.0, constant: 0)
        indicatorTopConstraint = NSLayoutConstraint(item: indicatorView, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1.0, constant: indicatorMarginTop)
        collectionBottomConstraint = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        addConstraints([
            
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            collectionBottomConstraint,
            
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmotionGrid

        checkRange(index: indexPath.item) {
            cell.emotionPage = emotionSetList[$0].emotionPageList[$1]
        }
        
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
    
    private func showIndicatorView() {
        
        let fromHidden = indicatorView.isHidden
        
        if fromHidden {
            addSubview(indicatorView)
            indicatorView.isHidden = false
            addConstraints([indicatorTopConstraint, indicatorCenterXConstraint])
            collectionBottomConstraint.constant = -(indicatorView.intrinsicContentSize.height + indicatorMarginTop)
            flowLayout.invalidateLayout()
        }
        
    }
    
    private func hideIndicatorView() {
        
        let fromVisible = !indicatorView.isHidden
        
        if fromVisible {
            collectionBottomConstraint.constant = 0
            removeConstraints([indicatorTopConstraint, indicatorCenterXConstraint])
            indicatorView.isHidden = true
            indicatorView.removeFromSuperview()
            flowLayout.invalidateLayout()
        }
        
    }
    
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
    
}
