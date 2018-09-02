
import UIKit

public class EmotionInput: UIView {
    
    public var emotionSetList = [EmotionSet]() {
        didSet {
            emotionPager.emotionSetList = emotionSetList
        }
    }
    
    public var delegate: EmotionInputDelegate?

    private var emotionPager: EmotionPager!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        emotionPager = EmotionPager(frame: frame)
        emotionPager.translatesAutoresizingMaskIntoConstraints = false
        emotionPager.onSendClick = {
            self.delegate?.emotionInputDidSendClick(self)
        }
        emotionPager.onEmotionClick = { emotion in
            self.delegate?.emotionInputDidEmotionClick(self, emotion)
        }
        emotionPager.onDeleteClick = {
            self.delegate?.emotionInputDidDeleteClick(self)
        }
        addSubview(emotionPager)
        addConstraints([
            
            NSLayoutConstraint(item: emotionPager, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionPager, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            
        ])
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
