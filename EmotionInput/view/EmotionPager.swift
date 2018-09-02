
import UIKit
import DotIndicator

class EmotionPager: UIView {
    
    var emotionSetList = [EmotionSet]() {
        didSet {
            emotionSetIndex = 0
            collectionView.reloadData()
        }
    }
    
    var emotionSetIndex = 0 {
        didSet {
            
            if emotionSetList.count > emotionSetIndex {
                let emotionSet = emotionSetList[ emotionSetIndex ]
                if emotionSet.hasIndicator {
                    showIndicatorView()
                    indicatorView.index = 0
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
            
            var index = 0
            toolbarView.emotionIconList = emotionSetList.map {
                
                let currentIndex = index
                index = index + 1
                
                return EmotionIcon([
                    "index": currentIndex,
                    "iconName": $0.iconName,
                    "selected": currentIndex == emotionSetIndex,
                ])
                
            }
            
        }
    }
    
    // indicator 与网格的距离
    var indicatorMarginTop = CGFloat(8)
    
    // toolbar 与 indicator 的距离
    var toolbarMarginTop = CGFloat(8)
    
    var onEmotionClick: ((_ emotion: Emotion) -> Void)?
    var onDeleteClick: (() -> Void)?
    var onSendClick: (() -> Void)?
    
    private var collectionView: UICollectionView!
    private var flowLayout: UICollectionViewFlowLayout!
    
    private var indicatorView: DotIndicator!
    private var toolbarView: EmotionToolbar!
    
    private let cellIdentifier = "grid"
    
    private var collectionBottomConstraint: NSLayoutConstraint!
    private var indicatorBottomConstraint: NSLayoutConstraint!
    private var indicatorHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(EmotionGrid.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        addSubview(collectionView)
        
        indicatorView = DotIndicator(frame: frame)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.isHidden = true
        
        addSubview(indicatorView)
        
        toolbarView = EmotionToolbar(frame: frame)
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.backgroundColor = .white
        toolbarView.onIconClick = { icon in
            var count = 0
            for i in 0..<self.emotionSetList.count {
                if i == icon.index {
                    self.collectionView.scrollToItem(at: IndexPath(item: count, section: 0), at: .centeredHorizontally, animated: false)
                    self.emotionSetIndex = i
                    break
                }
                count += self.emotionSetList[i].emotionPageList.count
            }
        }
        toolbarView.onSendClick = {
            self.onSendClick?()
        }
        
        addSubview(toolbarView)

        collectionBottomConstraint = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: indicatorView, attribute: .top, multiplier: 1.0, constant: 0)
        indicatorBottomConstraint = NSLayoutConstraint(item: indicatorView, attribute: .bottom, relatedBy: .equal, toItem: toolbarView, attribute: .top, multiplier: 1.0, constant: 0)
        indicatorHeightConstraint = NSLayoutConstraint(item: indicatorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        
        addConstraints([
            
            NSLayoutConstraint(item: toolbarView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: toolbarView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: toolbarView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: indicatorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            indicatorBottomConstraint,
            indicatorHeightConstraint,
            
            NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            collectionBottomConstraint,
            
        ])
        
    }
    
}


extension EmotionPager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for set in emotionSetList {
            count += set.emotionPageList.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EmotionGrid

        checkRange(index: indexPath.item) {
            cell.emotionPage = emotionSetList[$0].emotionPageList[$1]
        }
        
        cell.onEmotionClick = onEmotionClick
        cell.onDeleteClick = onDeleteClick
        
        return cell
    }
    
}

extension EmotionPager: UICollectionViewDelegateFlowLayout {
    
    // 行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}

extension EmotionPager: UICollectionViewDelegate {
    
    // 翻页事件
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        updateScrollX(x: scrollView.contentOffset.x, width: scrollView.bounds.size.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateScrollX(x: scrollView.contentOffset.x, width: scrollView.bounds.size.width)
    }
    
}


extension EmotionPager {
    
    private func showIndicatorView() {
        
        let fromHidden = indicatorView.isHidden
        
        if fromHidden {
            indicatorView.isHidden = false
            collectionBottomConstraint.constant = -indicatorMarginTop
            indicatorBottomConstraint.constant = -toolbarMarginTop
            removeConstraint(indicatorHeightConstraint)
        }
        
    }
    
    private func hideIndicatorView() {
        
        let fromVisible = !indicatorView.isHidden
        
        if fromVisible {
            addConstraint(indicatorHeightConstraint)
            collectionBottomConstraint.constant = 0
            indicatorBottomConstraint.constant = 0
            indicatorView.isHidden = true
        }
        
    }
    
    private func updateScrollX(x: CGFloat, width: CGFloat) {
        
        let index = Int(ceil(x / width))

        checkRange(index: index) {
            emotionSetIndex = $0
            indicatorView.index = $1
            indicatorView.setNeedsDisplay()
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
