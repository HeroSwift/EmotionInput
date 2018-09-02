
import Foundation

public class Emotion: NSObject {
    
    // 表情值
    @objc public var code = ""
    
    // 显示在图片下方的文本
    @objc public var name = ""
    
    // 表情对应的本地图片
    @objc public var imageName = ""
    
    // 表情对应的网络图片
    @objc public var imageUrl = ""

    // 是否支持在输入框显示
    @objc public var inline = true
    
    public init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    public override init() {
        
    }
    
}
