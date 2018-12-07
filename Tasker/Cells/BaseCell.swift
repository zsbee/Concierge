import Foundation
import UIKit

public class BaseCell: UICollectionViewCell {
    private var widthConstraint: NSLayoutConstraint!

    var width: CGFloat = 0 {
        didSet {
            widthConstraint.constant = width
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        widthConstraint = contentView.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
