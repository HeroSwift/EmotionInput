
import Foundation

public class Emotion: NSObject {
    
    // 表情值
    @objc public var code = ""
    
    // 显示在图片下方的文本
    @objc public var label = ""
    
    // 表情对应的本地图片
    @objc public var resName = ""
    
    // 表情对应的网络图片
    @objc public var url = ""
    
    // 显示宽度
    @objc public var width = 0
    
    // 显示高度
    @objc public var height = 0
    
    // 是否支持在输入框显示
    @objc public var inline = true
    
    public init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    public func isValid() -> Bool {
        return code != ""
    }
    
}
