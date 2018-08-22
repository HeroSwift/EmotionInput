
import UIKit

class EmotionCell: UICollectionViewCell {
    
    var emotionView: UIImageView!
    
    var nameLabel: UILabel!
    
    var deleteView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        
        clipsToBounds = true
        
    }
    
    private func assertEmotionView() {
        if emotionView == nil {
            emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            addSubview(emotionView)
        }
    }
    
    private func assertNameLabel() {
        if nameLabel == nil {
            nameLabel = UILabel()
            addSubview(nameLabel)
        }
    }
    
    public func setEmotion(emotion: Emotion) {
        
        if !emotion.isValid() {
            return
        }
        
        assertNameLabel()
        assertEmotionView()
        
        nameLabel.text = emotion.label
        nameLabel.sizeToFit()
        
        emotionView.image = UIImage(named: emotion.resName)
        emotionView.sizeToFit()
        
        var isChange = false
        
        var width = Int(emotionView.frame.size.width)
        var height = Int(emotionView.frame.size.height)
        
        if emotion.width > 0 && emotion.width != width {
            isChange = true
            width = emotion.width
        }
        if emotion.height > 0 && emotion.height != height {
            isChange = true
            height = emotion.height
        }
        
        if isChange {
            emotionView.frame = CGRect(origin: emotionView.frame.origin, size: CGSize(width: width, height: height))
        }
        
    }
    
}

