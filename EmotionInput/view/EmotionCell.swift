
import UIKit

class EmotionCell: UICollectionViewCell {
    
    var emotionView: UIImageView!
    
    var nameLabel: UILabel!
    
    var deleteView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        emotionView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        emotionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emotionView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        deleteView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        deleteView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(deleteView)
        
        addConstraints([
            NSLayoutConstraint(item: emotionView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: emotionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0),
            
            NSLayoutConstraint(item: deleteView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: deleteView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0),
        ])

        clipsToBounds = true
        
    }
    
    func setEmotion(emotion: Emotion) {
        
        if !emotion.isValid() {
            return
        }

        if emotion.label != "" {
            nameLabel.text = emotion.label
            nameLabel.sizeToFit()
            nameLabel.isHidden = false
        }
        else {
            nameLabel.isHidden = true
        }
        
        if emotion.resName != "" {
            emotionView.image = UIImage(named: emotion.resName)
            emotionView.sizeToFit()
        }
        
        var isChange = false
        
        var width = Int(emotionView.frame.size.width)
        var height = Int(emotionView.frame.size.height)
        
        if emotion.width > 0 && emotion.width != width {
            isChange = true
            width = emotion.width
        }
        if emotion.height > 0 && emotion.height != height {
            isChange = true
            height = emotion.height
        }
        
        if isChange {
            emotionView.frame = CGRect(origin: emotionView.frame.origin, size: CGSize(width: width, height: height))
        }
        
    }
    
}

