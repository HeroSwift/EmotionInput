
import UIKit

public class EmotionTextarea: UITextView {
    
    private var filters = [EmotionFilter]()
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.delegate = self
    }
    
    public func addFilter(_ filter: EmotionFilter) {
        filters.append(filter)
    }
    
    public func removeFilter(_ filter: EmotionFilter) {
        filters = filters.filter { $0 !== filter }
    }
    
}

extension EmotionTextarea: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        let text = textView.text
        for filter in filters {
            filter.filterTextInput(textInput: self, text: text!)
        }
    }
    
}
