
public class Emotion {
    
    // 表情值
    public var code: String
    
    // 显示在图片下方的文本
    public var name: String
    
    // 表情对应的本地图片
    public var imageName: String
    
    // 表情对应的网络图片
    public var imageUrl: String

    // 是否支持在输入框显示
    public var inline: Bool
    
    public init(code: String, name: String, imageName: String, imageUrl: String, inline: Bool) {
        self.code = code
        self.name = name
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.inline = inline
    }
    
    public convenience init() {
        self.init(code: "", name: "", imageName: "", imageUrl: "", inline: true)
    }
    
}
