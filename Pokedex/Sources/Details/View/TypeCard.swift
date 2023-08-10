import UIKit


class TypeCardView: UIView {
    var type: String? {
        didSet {
            if let type = type {
                configure(with: type)
            }
        }
    }

    private var typeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.7
        l.lineBreakMode = .byTruncatingTail
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initIU()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initIU()
    }

    func initIU() {

        addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])

        typeLabel.numberOfLines = 1
    }

    func findColor(type: String) -> UIColor {
        switch type {
        case "normal":
            return UIColor(red: 0.6, green: 0.6, blue: 0.5, alpha: 1)
        case "fighting":
            return UIColor(red: 0.7, green: 0.4, blue: 0.4, alpha: 1)
        case "flying":
            return UIColor(red: 0.6, green: 0.5, blue: 1, alpha: 1)
        case "poison":
            return UIColor(red: 0.6, green: 0.2, blue: 0.6, alpha: 1)
        case "ground":
            return UIColor(red: 0.8, green: 0.7, blue: 0.4, alpha: 1)
        case "rock":
            return UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        case "bug":
            return UIColor(red: 0.6, green: 0.7, blue: 0.2, alpha: 1)
        case "ghost":
            return UIColor(red: 0.5, green: 0.4, blue: 0.6, alpha: 1)
        case "steel":
            return UIColor(red: 0.6, green: 0.6, blue: 0.7, alpha: 1)
        case "fire":
            return UIColor(red: 0.9, green: 0.5, blue: 0.3, alpha: 1)
        case "water":
            return UIColor(red: 0.3, green: 0.5, blue: 0.9, alpha: 1)
        case "grass":
            return UIColor(red: 0.4, green: 0.8, blue: 0.4, alpha: 1)
        case "electric":
            return UIColor(red: 0.9, green: 0.8, blue: 0.2, alpha: 1)
        case "psychic":
            return UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 1)
        case "fairy":
            return UIColor(red: 0.9, green: 0.6, blue: 0.7, alpha: 1)
        case "dragon":
            return UIColor(red: 0.5, green: 0.3, blue: 0.9, alpha: 1)
        case "dark":
            return UIColor(red: 0.5, green: 0.4, blue: 0.3, alpha: 1)
        default:
            return UIColor.systemGray
        }
    }

    func configure(with type: String) {
        typeLabel.text = type.uppercased()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = findColor(type: type)
        layer.cornerRadius = 4
        layer.cornerCurve = .continuous
    }
}