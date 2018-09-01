
import UIKit

public protocol EmotionInputDelegate {
    
    // 点击表情
    func emotionInputDidEmotionClick(_ emotionInput: EmotionInput, _ emotion: Emotion)
    
    // 点击删除按钮
    func emotionInputDidDeleteClick(_ emotionInput: EmotionInput)
    
    // 点击发送按钮
    func emotionInputDidSendClick(_ emotionInput: EmotionInput)

}

public extension EmotionInputDelegate {
    
    func emotionInputDidEmotionClick(_ emotionInput: EmotionInput, _ emotion: Emotion) { }
    
    func emotionInputDidDeleteClick(_ emotionInput: EmotionInput) { }
    
    func emotionInputDidSendClick(_ emotionInput: EmotionInput) { }
    
}
