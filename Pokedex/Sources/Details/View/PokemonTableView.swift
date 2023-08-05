
import UIKit

class PokemonTableView: UITableView {
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Teste comp"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addMyContraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure() {
        backgroundColor = .purple
        separatorStyle = .none

        addSubview(titleLabel)
        addMyContraints()

        print("chegou aqui no final do configure table view")

        delegate = self
        dataSource = self
        register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
    }
}


extension PokemonTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ta chegando aqui na teble view func")
        print("ta chegando aqui na teble view func")
        print("ta chegando aqui na teble view func")
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PokemonTableViewCell.reuseIdentifier,
                for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }

        let pokemon = pokemonList[indexPath.row]
        cell.configure(with: pokemon)
        return cell
    }
}

extension PokemonTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Chegou no delegate", pokemonList.count)
        return pokemonList.count
    }
}
