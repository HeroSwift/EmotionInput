
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
        emotionPager.onSendPress = {
            self.delegate?.emotionInputDidSendClick(self)
        }
        emotionPager.onEmotionPress = { emotion in
            self.delegate?.emotionInputDidEmotionClick(self, emotion)
        }
        emotionPager.onDeletePress = {
            self.delegate?.emotionInputDidDeleteClick(self)
        }
        addSubview(emotionPager)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
