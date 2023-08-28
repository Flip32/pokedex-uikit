import UIKit
import SDWebImage


class PokemonView: UIView {
    var imageNotFound: String = "https://cdn.neemo.com.br/uploads/settings_webdelivery/logo/3136/image-not-found.jpg"
    var pokemon: Pokemon?

    private var img: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private var name: UILabel = {
        let n = UILabel()
        n.translatesAutoresizingMaskIntoConstraints = false
        n.textColor = .darkGray
        n.numberOfLines = 1
        n.font = UIFont.boldSystemFont(ofSize: 20)
        n.font = UIFont.systemFont(ofSize: 32)
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
        l.font = UIFont.systemFont(ofSize: 20)
        l.font = UIFont.boldSystemFont(ofSize: 18)
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

    private var abilityView: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.distribution = .fillProportionally
        v.spacing = 5
        return v
    }()

    private var abilityLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .darkGray
        l.text = "Abilities"
        l.font = UIFont.systemFont(ofSize: 20)
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.textAlignment = .left
        return l
    }()

    private var labelForEvolution: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20)
        l.font = UIFont.boldSystemFont(ofSize: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .darkGray
        return l
    }()

    private var evolutionContainer: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.distribution = .fillProportionally
        v.spacing = 10
        return v
    }()

    init(pokemon: Pokemon?) {
        super.init(frame: .zero)
        backgroundColor = .black
        configure(pokemon)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Config
extension PokemonView {

    func configure(_ pokemon: Pokemon?) {
        if let pokemon = pokemon {
            print(pokemon.name)
            print("imagem: ", pokemon.image)
            let imageForced = pokemon.image.isEmpty ? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png" : pokemon.image
            name.text = pokemon.name.capitalized
            if let imageUrl = URL(string: imageForced) {
                img.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
            }
            weight.text = "Weight: \(pokemon.weight)"
            height.text = "Height: \(pokemon.height)"

            addSubview(name)
            addSubview(img)

            cardInfo.addArrangedSubview(weight)
            cardInfo.addArrangedSubview(height)
            addSubview(cardInfo)

            labelForTypes.text = "Types: "
            addSubview(labelForTypes)

            // Imprimir cada tipo de types
            for t in pokemon.types {
                createCardType(for: t)
            }
            addSubview(typesContainer)

            // Create abilities
            abilityLabel.text = "Abilities: "
            addSubview(abilityLabel)

            let abilities = pokemon.abilities
            abilities.forEach { a in
                print("ability: ", a)
                let l = UILabel()
                l.translatesAutoresizingMaskIntoConstraints = false
                l.textColor = .darkGray
                l.text = "Abilities"
                l.font = UIFont.boldSystemFont(ofSize: 18)
                l.textAlignment = .left
                l.text = a.capitalized
                abilityView.addArrangedSubview(l)
            }

            addSubview(abilityView)

            addMyConstraints()

            // Create Evolutions
            if let evolution = pokemon.evolution, evolution.count > 1 {
                labelForEvolution.text = "Evolutions: "
                addSubview(labelForEvolution)
                for e in evolution {
                    print("evolution: ", e)
                    createCardEvolution(for: e)
                }

                addSubview(evolutionContainer)
                addConstraintsForEvolution()
            }
        }
    }

    func addMyConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.widthAnchor.constraint(equalToConstant: 250),
        ])

        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: centerXAnchor),
            img.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0),
            img.widthAnchor.constraint(equalToConstant: 250),
            img.heightAnchor.constraint(equalToConstant: 250)
        ])

        NSLayoutConstraint.activate([
            cardInfo.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardInfo.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            cardInfo.widthAnchor.constraint(equalToConstant: 250),
            cardInfo.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])

        NSLayoutConstraint.activate([
            labelForTypes.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelForTypes.topAnchor.constraint(equalTo: cardInfo.bottomAnchor, constant: 20),
            labelForTypes.widthAnchor.constraint(equalToConstant: 250),
        ])

        NSLayoutConstraint.activate([
            typesContainer.leadingAnchor.constraint(equalTo: labelForTypes.leadingAnchor, constant: 40),
//            typesContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            typesContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            typesContainer.topAnchor.constraint(equalTo: labelForTypes.bottomAnchor, constant: 5),
        ])

        NSLayoutConstraint.activate([
            abilityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            abilityLabel.topAnchor.constraint(equalTo: typesContainer.bottomAnchor, constant: 20),
            abilityLabel.widthAnchor.constraint(equalToConstant: 250),
        ])

        NSLayoutConstraint.activate([
            abilityView.topAnchor.constraint(equalTo: abilityLabel.bottomAnchor, constant: 2),
            abilityView.widthAnchor.constraint(equalToConstant: 250),
            abilityView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            abilityView.leadingAnchor.constraint(equalTo: abilityLabel.leadingAnchor, constant: 20),
        ])
    }

    func addConstraintsForEvolution() {
        NSLayoutConstraint.activate([
            labelForEvolution.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelForEvolution.topAnchor.constraint(equalTo: abilityView.bottomAnchor, constant: 20),
            labelForEvolution.widthAnchor.constraint(equalToConstant: 250),
        ])

        NSLayoutConstraint.activate([
            evolutionContainer.leadingAnchor.constraint(equalTo: labelForEvolution.leadingAnchor, constant: 20),
            evolutionContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            evolutionContainer.topAnchor.constraint(equalTo: labelForEvolution.bottomAnchor, constant: 0),
        ])
    }

    func createCardType(for type: String) {
        let cardTypeView = TypeCardView()

        typesContainer.addArrangedSubview(cardTypeView)

        cardTypeView.type = type
    }

    func createCardEvolution(for evolution: Evolution) {
        let cardEvolutionView = EvolutionCardView()

        evolutionContainer.addArrangedSubview(cardEvolutionView)

        let imageForcedInitial = imageNotFound
        guard let id = evolution.id else {
            cardEvolutionView.img = imageForcedInitial
            return
        }

        // Verificar, pois nem sempre a lista completa ta carregada
        guard let pokemon = pokemon else {
            cardEvolutionView.img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
            return
        }
        let imageForced = pokemon.image.isEmpty ? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png" : pokemon.image

        cardEvolutionView.img = imageForced
    }
}