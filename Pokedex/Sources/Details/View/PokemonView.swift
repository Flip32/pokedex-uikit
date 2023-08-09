import UIKit
import SDWebImage


class PokemonView: UIView {
    var pokemonId: Int?
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

    init(pokemonId: Int?) {
        super.init(frame: .zero)
        self.pokemonId = pokemonId
        backgroundColor = .black

        if let id = pokemonId {
            pokemon = pokemonList.first {
                $0.id == id
            }

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
                typesContainer.addArrangedSubview(labelForTypes)

                // Imprimir cada tipo de types
                for t in pokemon.types {
                    print("aqui o type: \(t)")
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

                // Create Evolutions
                guard let evolution = pokemon.evolution else {
                    addMyConstraints()
                    return
                }
                labelForEvolution.text = "Evolutions: "
                addSubview(labelForEvolution)
                for e in evolution {
                    print("evolution: ", e)
                    createCardEvolution(for: e)
                }

                addSubview(evolutionContainer)

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
            typesContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            typesContainer.topAnchor.constraint(equalTo: cardInfo.bottomAnchor, constant: 20),
            typesContainer.widthAnchor.constraint(equalToConstant: 250),
            typesContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
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

        let pokemon: Pokemon = pokemonList.first { $0.id == evolution.id }!
        let imageForced = pokemon.image.isEmpty ? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemon.id).png" : pokemon.image

        cardEvolutionView.img = imageForced
    }
}
