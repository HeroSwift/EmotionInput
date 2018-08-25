
import Foundation

public class EmotionPage: NSObject {
    
    // 每页的图标列表
    @objc public var emotionList = [Emotion]()
    
    // 每页有多少列
    @objc public var columns = 0
    
    // 每页有多少行
    @objc public var rows = 0
    
    // 显示宽度
    @objc public var width = 0
    
    // 显示高度
    @objc public var height = 0
    
    // 是否显示删除按钮
    @objc public var hasDeleteButton = false
    
    public init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}

