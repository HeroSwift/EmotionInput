
import UIKit

// https://www.cnblogs.com/yongbufangqi1988/p/8945643.html

public class EmotionTextarea: UITextView {
    
    // 文本字体
    var inputTextFont = UIFont.systemFont(ofSize: 16)
    
    // 文本颜色
    var inputTextColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
    
    // 行高
    var inputLineHeight = 22
    
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

    public func insertEmotion(_ emotion: Emotion) {
        let attachment = EmotionFilter.getEmotionAttachment(emotion: emotion, font: inputTextFont)
        if let attachment = attachment {
            let location = selectedRange.location
            textStorage.insert(NSAttributedString(attachment: attachment), at: location)
            selectedRange = NSRange(location: location + 1, length: 0)
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
            if let attachment = attributedText.attribute(NSAttributedStringKey("NSAttachment"), at: NSMaxRange(effectiveRange), effectiveRange: &effectiveRange) {
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
        guard let string = UIPasteboard.general.string else {
            return
        }
        print(string)
    }
    
    
    
}

extension EmotionTextarea: UITextViewDelegate {
    
    // 文本变化
    public func textViewDidChange(_ textView: UITextView) {
        typingAttributes = typingAttrs
    }
    
    // 避免 ios 10.11+ 长按表情会触发保存图片的系统窗口
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return false
    }
    
}
