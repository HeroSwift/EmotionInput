
import UIKit

public class EmotionFilter {
    
    var pattern: NSRegularExpression
    
    var emotions: [String: Emotion] = [:]

    init(pattern: String, emotionList: [Emotion]) {
        self.pattern = try! NSRegularExpression(pattern: pattern)
        emotionList.forEach { emotion in
            emotions[emotion.code] = emotion
        }
    }
    
    func filter(attributedString: NSMutableAttributedString, text: NSString, font: UIFont) {
        var offset = 0
        match(text: text) { (emotionCode, location, length) in
            guard let emotion = emotions[emotionCode] else {
                return
            }
            if let attachment = getEmotionAttachment(emotion: emotion, font: font) {
                attributedString.replaceCharacters(
                    in: NSRange(location: location - offset, length: length),
                    with: NSAttributedString(attachment: attachment)
                )
                offset = offset + (length - 1)
            }
        }
    }
    
    func insert(textInput: UITextView, emotion: Emotion) -> Bool {
        let location = textInput.selectedRange.location
        if let attachment = getEmotionAttachment(emotion: emotion, font: textInput.font!) {
            textInput.textStorage.insert(NSAttributedString(attachment: attachment), at: location)
            textInput.selectedRange = NSRange(location: location + 1, length: 0)
            return true
        }
        return false
    }
    
    /**
     * 用正则匹配字符串中的表情
     */
    private func match(text: NSString, callback: (_ emotionCode: String, _ start: Int, _ end: Int) -> Void) {
        let matches = pattern.matches(in: text as String, options: [], range: NSRange(location: 0, length: text.length))
        for item in matches {
            let startIndex = item.range.lowerBound
            let endIndex = item.range.upperBound
            callback(
                text.substring(with: item.range),
                startIndex,
                endIndex - startIndex
            )
        }
    }
    
    private func getEmotionAttachment(emotion: Emotion, font: UIFont) -> EmotionAttachment? {
        if let imageAsset = emotion.imageAsset {
            
            let attachment = EmotionAttachment(emotion)
            attachment.image = imageAsset
            
            let imageRatio = imageAsset.size.width / imageAsset.size.height
            var imageHeight = font.lineHeight
            var imageWidth = imageHeight * imageRatio
            
            // 宽度不能超过高度
            // 否则当表情是 👈 时，宽度会很大
            
            if imageWidth > imageHeight {
                imageWidth = imageHeight
                imageHeight = imageWidth / imageRatio
            }

            // https://stackoverflow.com/questions/26105803/center-nstextattachment-image-next-to-single-line-uilabel
            attachment.bounds = CGRect(x: 0, y: (font.capHeight - imageHeight).rounded() / 2, width: imageWidth, height: imageHeight)
            
            return attachment
        }
        return nil
    }
    
}


