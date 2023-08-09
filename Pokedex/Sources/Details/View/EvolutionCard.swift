import UIKit
import SDWebImage

class EvolutionCardView: UIView {
    var img: String? {
        didSet {
            if let img = img {
                configure(with: img)
            }
        }
    }

    private var imgView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(imgView)

        NSLayoutConstraint.activate([
            imgView.heightAnchor.constraint(equalToConstant: 50),
            imgView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

    func configure(with img: String) {
        if let imageUrl = URL(string: img) {
            imgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        }
    }
}