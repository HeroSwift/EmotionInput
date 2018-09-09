
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
    
    func filter(attributedString: NSMutableAttributedString, font: UIFont?) {
        var offset = 0
        match(text: attributedString.string) { (emotionCode, location, length) in
            guard let emotion = emotions[emotionCode] else {
                return
            }
            if let attachment = EmotionFilter.getEmotionAttachment(emotion: emotion, font: font) {
                attributedString.replaceCharacters(in: NSRange(location: location - offset, length: length), with: NSAttributedString(attachment: attachment))
                offset = offset + (length - 1)
            }
        }
    }
    
    /**
     * 用正则匹配字符串中的表情
     */
    private func match(text: String, callback: (_ emotionCode: String, _ start: Int, _ end: Int) -> Void) {
        let matches = pattern.matches(in: text, options: [], range: NSRange(location: 0, length: text.utf16.count))
        for item in matches {
            let startIndex = item.range.lowerBound
            let endIndex = item.range.upperBound
            callback(
                EmotionFilter.subString(text: text, startIndex: startIndex, endIndex: endIndex),
                startIndex,
                endIndex - startIndex
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
                // 两行之间稍微留点间距
                let imageHeight = font.lineHeight - 4
                // https://stackoverflow.com/questions/26105803/center-nstextattachment-image-next-to-single-line-uilabel
                attachment.bounds = CGRect(x: 0, y: (font.capHeight - imageHeight).rounded() / 2, width: imageHeight * imageRatio, height: imageHeight)
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


