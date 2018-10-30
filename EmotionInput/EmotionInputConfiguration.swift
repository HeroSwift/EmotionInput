import UIKit

// 配置
public class EmotionInputConfiguration {
    
    // 背景色
    public var pagerBackgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    
    // 删除图片
    public var deleteButtonImage = UIImage(named: "delete-emotion")
    
    // 表情网格容器的垂直内边距
    public var emotionGridPaddingVertical: CGFloat = 20
    
    // 表情网格容器的水平内边距
    public var emotionGridPaddingHorizontal: CGFloat = 20
    
    // 行间距
    public var emotionGridRowSpacing: CGFloat = 10
    
    // 列间距
    public var emotionGridColumnSpacing: CGFloat = 10
    
    // 表情单元格按下时的背景色
    public var emotionCellBackgroundColorPressed = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
    
    
    // 单元格文本字体
    public var emotionNameTextFont = UIFont.systemFont(ofSize: 12)
    
    // 单元格文本颜色
    public var emotionNameTextColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 1)
    
    // 单元格文本与表情的距离
    public var emotionNameMarginTop: CGFloat = 5
    
    
    
    // 指示器与网格的距离
    public var indicatorMarginTop: CGFloat = 8
    
    // 指示器普通圆点的颜色
    public var indicatorColorNormal = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1)
    
    // 指示器普通圆点的半径
    public var indicatorRadiusNormal: Double = 3
    
    // 指示器当前圆点的颜色
    public var indicatorColorActive = UIColor(red:0.55, green:0.55, blue:0.55, alpha: 1)
    
    // 指示器当前圆点的半径
    public var indicatorRadiusActive: Double = 3.2
    
    // 工具栏与指示器的距离
    public var toolbarMarginTop: CGFloat = 8
    
    // 工具栏背景色
    public var toolbarBackgroundColor = UIColor.white
    
    // 工具栏的高度
    public var toolbarHeight: CGFloat = 44
    
    // 图标单元格宽度
    public var toolbarCellWidth: CGFloat = 44
    
    // 表情单元格分割线颜色
    public var toolbarCellDividerColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    
    // 表情单元格分割线宽度
    public var toolbarCellDividerWidth = 1 / UIScreen.main.scale
    
    // 表情单元格分割线高度
    public var toolbarCellDividerOffset: CGFloat = 6
    
    // 表情单元格按下时的背景色
    public var toolbarCellBackgroundColorPressed = UIColor(red: 244 / 255, green: 242 / 255, blue: 246 / 255, alpha: 1)
    
    // 发送按钮的文本
    public var sendButtonText = "发送"
    
    // 发送按钮的文本字体
    public var sendButtonTextFont = UIFont.systemFont(ofSize: 14)
    
    // 发送按钮的文本颜色
    public var sendButtonTextColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1)
    
    // 发送按钮左边框的大小
    public var sendButtonLeftBorderWidth =  1 / UIScreen.main.scale
    
    // 发送按钮左边框的颜色
    public var sendButtonLeftBorderColor = UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1)
    
    // 发送按钮的背景颜色
    public var sendButtonBackgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
    
    // 发送按钮的左右内间距
    public var sendButtonPaddingHorizontal: CGFloat = 14
    
    
    // 输入框文本字体
    public var textareaTextFont = UIFont.systemFont(ofSize: 15)
    
    // 输入框文本颜色
    public var textareaTextColor = UIColor(red: 60 / 255, green: 60 / 255, blue: 60 / 255, alpha: 1)
    
    // 输入框的垂直内间距
    public var textareaPaddingVertical: CGFloat = 10
    
    // 输入框的水平内间距
    public var textareaPaddingHorizontal: CGFloat = 8
    
    // 输入框自动增高的最大行数
    public var textareaMaxLines: CGFloat = 5
    
    
    public init() { }
    
}
