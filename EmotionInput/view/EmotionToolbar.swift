
import UIKit

class EmotionToolbar: UIView {

    public override var intrinsicContentSize: CGSize {
        

        return CGSize(width: 100, height: 40)
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        backgroundColor = .red
        
    }
    
}
