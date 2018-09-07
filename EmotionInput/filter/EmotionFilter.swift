
import UIKit

public class EmotionFilter {
    
    let patternString: String
    
    lazy var pattern: NSRegularExpression = {
        try! NSRegularExpression(pattern: patternString)
    }()
    
    init(_ patternString: String) {
        self.patternString = patternString
    }
    
    func filter(textView: UILabel, text: String) {
        textView.attributedText = getAttributeString(text: text, font: textView.font, editable: false)
    }
    
    private func getAttributeString(text: String, font: UIFont?, editable: Bool) -> NSAttributedString {
        
        let attributeString = NSMutableAttributedString(string: "")
        
        var startIndex = 0
        
        // 0 表示文本 1 表示图片
        // 懒得用常量了
        var lastStatus = -1
        
        func appendString(string: String) {
            // 上一个是图片，加个空白符
            if lastStatus > 0 {
                attributeString.append(
                    NSAttributedString(string: " " + string)
                )
            }
            else {
                attributeString.append(
                    NSAttributedString(string: string)
                )
            }
            lastStatus = 0
        }
        
        func appendImage(imageName: String) {
//            let attachment = EmotionFilter.getEmotionAttachment(imageName: imageName, font: font)
//            if let attachment = attachment {
//                // 前面有内容，需要加个空白符
//                if lastStatus >= 0 {
//                    appendString(string: " ")
//                }
//                attributeString.append(
//                    NSAttributedString(attachment: attachment)
//                )
//                lastStatus = 1
//            }
        }
        
        match(text: text) { (emotion, start, end) in
            
            let string = subString(text: text, startIndex: startIndex, endIndex: start)
            if string != "" {
                appendString(string: string)
            }
            
            appendImage(imageName: "delete-emotion.png")
            
            startIndex = end
            
        }
        
        let suffix = subString(text: text, startIndex: startIndex, endIndex: text.count)
        if suffix != "" {
            appendString(string: suffix)
        }
        else if editable {
            appendString(string: " ")
        }
        
        
        return attributeString
        
    }
    
    private func subString(text: String, startIndex: Int, endIndex: Int) -> String {
        return EmotionFilter.subString(text: text, startIndex: startIndex, endIndex: endIndex)
    }
    
    /**
     * 用正则匹配字符串中的表情
     */
    private func match(text: String, callback: (_ emotion: String, _ start: Int, _ end: Int) -> Void) {
        let matches = pattern.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        for item in matches {
            let startIndex = item.range.lowerBound
            let endIndex = item.range.upperBound
            callback(
                subString(text: text, startIndex: item.range.lowerBound, endIndex: item.range.upperBound),
                startIndex,
                endIndex
            )
        }
    }
    
    static func getEmotionAttachment(emotion: Emotion, font: UIFont?) -> EmotionAttachment? {
        let image = UIImage(named: emotion.imageName)
        if let image = image {
            
            let attachment = EmotionAttachment(emotion)
            attachment.image = image
            
            if let font = font {
                let imageRatio = image.size.width / image.size.height
                let lineHeight = font.lineHeight
                
                // https://stackoverflow.com/questions/26105803/center-nstextattachment-image-next-to-single-line-uilabel
                attachment.bounds = CGRect(x: 0, y: (font.capHeight - lineHeight).rounded() / 2, width: lineHeight * imageRatio, height: lineHeight)
            }
            
            return attachment
        }
        return nil
    }
    
    static func subString(text: String, startIndex: Int, endIndex: Int) -> String {
        let start = text.index(text.startIndex, offsetBy: startIndex)
        let end = text.index(text.startIndex, offsetBy: endIndex)
        return String(text[start..<end])
    }
    
}


