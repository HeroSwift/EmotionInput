
import UIKit

// https://www.cnblogs.com/yongbufangqi1988/p/8945643.html

public class EmotionTextarea: UITextView {
    
    // 文本字体
    var inputTextFont = UIFont.systemFont(ofSize: 16)
    
    // 文本颜色
    var inputTextColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
    
    // 行高
    var inputLineHeight = 22
    
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
        let attachment = EmotionFilter.getEmotionAttachment(emotion: emotion, font: inputTextFont)
        if let attachment = attachment {
            let location = selectedRange.location
            textStorage.insert(NSAttributedString(attachment: attachment), at: location)
            selectedRange = NSRange(location: location + 1, length: 0)
        }
    }
    
    public func getPlainText() -> String {
        let string = NSMutableAttributedString(attributedString: attributedText)
        attributedText.enumerateAttributes(in: NSRange(location: 0, length: attributedText.length), options: [], using: { (attrs, range, stop) in
            guard let index = attrs.keys.index(of: NSAttributedStringKey("NSAttachment")), let attachment = attrs[index].value as? EmotionAttachment else {
                return
            }
            string.replaceCharacters(in: range, with: attachment.emotion.code)
        })
        return string.string
    }
    
    public override func cut(_ sender: Any?) {
        copy()
        let string = NSMutableAttributedString(attributedString: attributedText)
        
        print("\(selectedRange.location) \(selectedRange.length)")

    }
    
    public override func copy(_ sender: Any?) {
        
        let plainText = getPlainText()
        let string = EmotionFilter.subString(text: text, startIndex: selectedRange.location, endIndex: selectedRange.location + selectedRange.length)
        print("copy: \(text) \(selectedRange) => \(string)")
        
        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.replaceCharacters(in: selectedRange, with: "")
        
        attributedText = attributedString

    }

    public override func paste(_ sender: Any?) {
        let string = UIPasteboard.general.string
        print(string)
    }
    
    func getPlainText(in range: NSRange) -> String {
    
        let string = ""
        
        let effectiveRange = NSRange(location: range.location, length: 0)
        let maxLength = NSMaxRange(range)
        
        while NSMaxRange(effectiveRange) < maxLength {
            let attachment = attributedText.attribute(at: NSMaxRange(effectiveRange), effectiveRange: effectiveRange)
            
        }
    }
    
}

extension EmotionTextarea: UITextViewDelegate {
    
    // 文本变化
    public func textViewDidChange(_ textView: UITextView) {
        print(getPlainText())
        typingAttributes = typingAttrs
    }
    
    // 避免 ios 10.11+ 长按表情会触发保存图片的系统窗口
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return false
    }
    
}
