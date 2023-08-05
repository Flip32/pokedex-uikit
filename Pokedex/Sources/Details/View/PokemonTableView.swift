import UIKit

class PokemonTableView: UITableView {

    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configure() {
        backgroundColor = .black
        separatorStyle = .none


        delegate = self
        dataSource = self
        register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.reuseIdentifier)
    }

    @objc func menuButtonTapped() {
        print("clicou no menu button TableView")
    }
}


extension PokemonTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PokemonTableViewCell.reuseIdentifier,
                for: indexPath) as? PokemonTableViewCell
        else {
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
