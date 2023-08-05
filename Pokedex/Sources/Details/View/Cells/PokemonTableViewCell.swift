import UIKit

class PokemonTableViewCell: UITableViewCell {

    static var reuseIdentifier: String = "PokemonTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()

    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()

    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.layer.cornerRadius = 10
//        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("chega aqui no override init da cell")
        self.configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with pokemon: Pokemon) {
        idLabel.text = String(format: "%03d", pokemon.id)
        nameLabel.text = pokemon.name.capitalized

        if let imageUrl = URL(string: pokemon.image) {
            imgView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        }
    }
}

extension PokemonTableViewCell {
    func configureView() {
        self.contentView.addSubview(idLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(imgView)
        self.backgroundColor = .black


        NSLayoutConstraint.activate([
            idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imgView.heightAnchor.constraint(equalToConstant: 50),
            imgView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
