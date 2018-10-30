
import UIKit

// https://www.cnblogs.com/yongbufangqi1988/p/8945643.html

public class EmotionTextarea: UITextView {
    
    public var onTextChange: (() -> Void)?
    
    public var plainText: String {
        get {
            // 这里不能用 text.count，因为计算 emoji 的长度有问题
            let str = NSString(string: text)
            return getPlainText(in: NSRange(location: 0, length: str.length))
        }
    }
    
    private var filters = [EmotionFilter]()
    
    private var typingAttrs: [String: Any]!
    
    private var maxHeight: CGFloat = 0
    
    private var configuration: EmotionInputConfiguration!
    
    public override var intrinsicContentSize: CGSize {
        return frame.size
    }
    
    public convenience init(configuration: EmotionInputConfiguration) {
        self.init()
        self.configuration = configuration
        setup()
    }
    
    private override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        typingAttributes[NSAttributedStringKey.foregroundColor.rawValue] = configuration.textareaTextColor
        typingAttributes[NSAttributedStringKey.font.rawValue] = configuration.textareaTextFont
        
        typingAttrs = typingAttributes
        
        // 默认左侧有 5 点
        contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        
        textContainerInset = UIEdgeInsetsMake(
            configuration.textareaPaddingVertical,
            configuration.textareaPaddingHorizontal,
            configuration.textareaPaddingVertical,
            configuration.textareaPaddingHorizontal
        )
        textAlignment = .left
        
        delegate = self
        
        layoutManager.allowsNonContiguousLayout = false
        
        if let font = font {
            maxHeight = configuration.textareaMaxLines * font.lineHeight + 2 * configuration.textareaPaddingVertical
        }
        
        autoHeight()
        
    }
    
    public func addFilter(_ filter: EmotionFilter) {
        filters.append(filter)
    }
    
    public func removeFilter(_ filter: EmotionFilter) {
        filters = filters.filter { $0 !== filter }
    }
    
    public func insertEmotion(_ emotion: Emotion) {
        for filter in filters {
            if filter.insert(textInput: self, emotion: emotion) {
                onTextChange?()
                break
            }
        }
    }
    
    // 清空文本
    public func clear() {
        textStorage.deleteCharacters(in: NSRange(location: 0, length: NSString(string: text).length))
    }

    // 富文本转成普通文本
    func getPlainText(in range: NSRange) -> String {
        
        let fullText = NSString(string: text)
        var plainText = ""

        var effectiveRange = NSRange(location: range.location, length: 0)
        let maxLength = NSMaxRange(range)
        
        while NSMaxRange(effectiveRange) < maxLength {
            if let attachment = attributedText.attribute(NSAttributedStringKey.attachment, at: NSMaxRange(effectiveRange), effectiveRange: &effectiveRange) {
                if (attachment is EmotionAttachment) {
                    plainText += (attachment as! EmotionAttachment).emotion.code
                }
            }
            else {
                plainText += fullText.substring(with: effectiveRange)
            }
        }
        
        return plainText
        
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
        
        let pastedAttributedString = NSMutableAttributedString(string: string, attributes: [
            NSAttributedStringKey.foregroundColor: configuration.textareaTextColor,
            NSAttributedStringKey.font: configuration.textareaTextFont
        ])
        
        let pastedString = NSString(string: string)
        
        for filter in filters {
            filter.filter(attributedString: pastedAttributedString, text: pastedString, font: font!)
        }
        
        let location = selectedRange.location
        
        textStorage.replaceCharacters(in: selectedRange, with: pastedAttributedString)
        selectedRange = NSRange(location: location + pastedString.length, length: 0)
        
        onTextChange?()
        
    }

    private func autoHeight() {
    
        let newSize = sizeThatFits(CGSize(width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        let newHeight = min(maxHeight, newSize.height)

        if frame.height != newHeight {
            frame.size = CGSize(width: frame.width, height: newHeight)
            invalidateIntrinsicContentSize()
            // 滚动到光标处
            scrollRangeToVisible(selectedRange)
        }
        
    }
    
}

extension EmotionTextarea: UITextViewDelegate {
    
    // 文本变化
    public func textViewDidChange(_ textView: UITextView) {
        onTextChange?()
        autoHeight()
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        typingAttributes = typingAttrs
    }
    
    // 避免 ios 10.11+ 长按表情会触发保存图片的系统窗口
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return false
    }
    
}
