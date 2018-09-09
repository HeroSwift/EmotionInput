
import UIKit

// https://www.cnblogs.com/yongbufangqi1988/p/8945643.html

public class EmotionTextarea: UITextView {
    
    // 文本字体
    let inputTextFont = UIFont.systemFont(ofSize: 16)
    
    // 文本颜色
    let inputTextColor = UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
    
    var onTextChange: (() -> Void)?
    
    private var filters = [EmotionFilter]()
    
    private var typingAttrs: [String: Any]!
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        font = inputTextFont
        textColor = inputTextColor
        
        typingAttrs = typingAttributes
        
        self.delegate = self
        
    }
    
    public func addFilter(_ filter: EmotionFilter) {
        filters.append(filter)
    }
    
    public func removeFilter(_ filter: EmotionFilter) {
        filters = filters.filter { $0 !== filter }
    }
    
    public func insertEmotion(_ emotion: Emotion) {
        if let attachment = EmotionFilter.getEmotionAttachment(emotion: emotion, font: inputTextFont) {
            let location = selectedRange.location
            textStorage.insert(NSAttributedString(attachment: attachment), at: location)
            selectedRange = NSRange(location: location + 1, length: 0)
            textViewDidChange(self)
        }
    }
    
    public func getPlainText() -> String {
        return getPlainText(in: NSRange(location: 0, length: text.count))
    }
    
    func getPlainText(in range: NSRange) -> String {
        
        var string = ""
        
        var effectiveRange = NSRange(location: range.location, length: 0)
        let maxLength = NSMaxRange(range)
        
        while NSMaxRange(effectiveRange) < maxLength {
            if let attachment = attributedText.attribute(NSAttributedStringKey.attachment, at: NSMaxRange(effectiveRange), effectiveRange: &effectiveRange) {
                if (attachment is EmotionAttachment) {
                    string = string + (attachment as! EmotionAttachment).emotion.code
                }
            }
            else {
                string = string + EmotionFilter.subString(text: text, startIndex: effectiveRange.location, endIndex: effectiveRange.location + effectiveRange.length)
            }
        }
        
        return string
        
    }
    
    public override func cut(_ sender: Any?) {
        let string = getPlainText(in: selectedRange)
        super.cut(sender)
        UIPasteboard.general.string = string
    }
    
    public override func copy(_ sender: Any?) {
        UIPasteboard.general.string = getPlainText(in: selectedRange)
    }

    public override func paste(_ sender: Any?) {
        
        guard let string = UIPasteboard.general.string, string.count > 0 else {
            return
        }
        
        let pastedString = NSMutableAttributedString(string: string, attributes: [
            NSAttributedStringKey.foregroundColor: inputTextColor,
            NSAttributedStringKey.font: inputTextFont
        ])
        for filter in filters {
            filter.filter(attributedString: pastedString, font: font)
        }
        
        let location = selectedRange.location
        
        textStorage.replaceCharacters(in: selectedRange, with: pastedString)
        selectedRange = NSRange(location: location + pastedString.string.count, length: 0)
        
        textViewDidChange(self)
        
    }
    
    func autoHeight() {
        let fixedWidth = frame.size.width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
    
}

extension EmotionTextarea: UITextViewDelegate {
    
    // 文本变化
    public func textViewDidChange(_ textView: UITextView) {
        onTextChange?()
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        typingAttributes = typingAttrs
    }
    
    // 避免 ios 10.11+ 长按表情会触发保存图片的系统窗口
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return false
    }
    
}
