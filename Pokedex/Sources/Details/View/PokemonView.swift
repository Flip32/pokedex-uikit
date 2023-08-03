import UIKit


class PokemonView: UIView {
    var pokemonId: Int?
    var pokemon: Pokemon?

    private var img: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

//    private var bioDescription: UILabel = {
//        let bio = UILabel()
//        bio.translatesAutoresizingMaskIntoConstraints = false
//        bio.textColor = .darkGray
//        bio.numberOfLines = 0
//        return bio
//    } ()

    private var name: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.textColor = .darkGray
        n.numberOfLines = 1
        n.font = UIFont.boldSystemFont(ofSize: 18)
        n.font = UIFont.systemFont(ofSize: 20)
        n.textAlignment = .center
        return n
    }()

    private var weight: UILabel = {
        let w = UILabel()
        w.translatesAutoresizingMaskIntoConstraints = false
        w.textColor = .darkGray
        w.numberOfLines = 1
        w.font = UIFont.systemFont(ofSize: 20)
        w.font = UIFont.boldSystemFont(ofSize: 18)
        w.textAlignment = .center
        return w
    }()

    private var height: UILabel = {
        let h = UILabel()
        h.translatesAutoresizingMaskIntoConstraints = false
        h.textColor = .darkGray
        h.numberOfLines = 1
        h.font = UIFont.systemFont(ofSize: 20)
        h.font = UIFont.boldSystemFont(ofSize: 18)
        h.textAlignment = .center
        return h
    }()

    private var cardInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.layer.borderWidth = 1.0
        stackView.layer.borderColor = UIColor.white.cgColor
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private var labelForTypes: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .darkGray
        return l
    }()

    private var typesContainer: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .fillProportionally
        v.spacing = 10
        return v
    }()

    init(pokemonId: Int?) {
        super.init(frame: .zero)
        self.pokemonId = pokemonId
        backgroundColor = .black

        if let id = pokemonId {
            pokemon = pokemonList.first {
                $0.id == id
            }
            print("aqui o types pokemon: \(pokemon?.types)")

            if let pokemon = pokemon {
                print(pokemon.name)
                name.text = pokemon.name.capitalized
                if let imageUrl = URL(string: pokemon.image) {
                    img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
                }
//                bioDescription.text = pokemon.bioDescription
                weight.text = "Weight: \(pokemon.weight)"
                height.text = "Height: \(pokemon.height)"

                addSubview(name)
                addSubview(img)
//                addSubview(bioDescription)

                cardInfo.addArrangedSubview(weight)
                cardInfo.addArrangedSubview(height)
                addSubview(cardInfo)

                labelForTypes.text = "Types: "
                typesContainer.addArrangedSubview(labelForTypes)

                // Imprimir cada tipo de types
                for t in pokemon.types {
                    print("aqui o type: \(t.type.name)")
                    createCardType(for: t.type.name)
                }
                addSubview(typesContainer)

                addMyConstraints()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func addMyConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.widthAnchor.constraint(equalToConstant: 250),
        ])

        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: centerXAnchor),
            img.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            img.widthAnchor.constraint(equalToConstant: 250),
            img.heightAnchor.constraint(equalToConstant: 250)
        ])

        /*NSLayoutConstraint.activate([
            bioDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            bioDescription.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 10),
            bioDescription.widthAnchor.constraint(equalToConstant: 250),
        ])*/

        NSLayoutConstraint.activate([
            cardInfo.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardInfo.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            cardInfo.widthAnchor.constraint(equalToConstant: 250), // Como faço para deixar a altura automática?
//            cardInfo.heightAnchor.constraint(equalToConstant: 100)
            cardInfo.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])

        NSLayoutConstraint.activate([
            typesContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            typesContainer.topAnchor.constraint(equalTo: cardInfo.bottomAnchor, constant: 20),
            typesContainer.widthAnchor.constraint(equalToConstant: 250),
            typesContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }

    func createCardType(for type: String) {
        let cardTypeView = TypeCardView()

        typesContainer.addArrangedSubview(cardTypeView)

        cardTypeView.type = type
    }
}
