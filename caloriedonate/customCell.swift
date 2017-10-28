import UIKit

class customCell: UITableViewCell {
    var name: UILabel!
    var calorie: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name = UILabel(frame: CGRect.zero)
        name.textAlignment = .left
        contentView.addSubview(name)
        
        calorie = UILabel(frame: CGRect.zero)
        calorie.textAlignment = .right
        contentView.addSubview(calorie)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        name.frame = CGRect(x: 15, y: 0, width: frame.width * 0.7 - 15, height: frame.height)
        calorie.frame = CGRect(x: frame.width * 0.7, y: 0, width: frame.width * 0.3 - 15, height: frame.height)
    }
    
}
