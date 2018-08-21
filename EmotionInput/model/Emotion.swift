
import Foundation

class Emotion: NSObject {
    
    // 表情值
    var code = ""
    
    // 显示在图片下方的文本
    var label = ""
    
    // 表情对应的本地图片
    var resId = 0
    
    // 表情对应的网络图片
    var url = ""
    
    // 显示宽度
    var width = 0
    
    // 显示高度
    var height = 0
    
    // 是否支持在输入框显示
    var inline = true
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
}
