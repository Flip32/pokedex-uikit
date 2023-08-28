import UIKit


class HomeViewController: UIViewController {
    var viewModel: ListViewModelProtocol

    var sortedList: String = "up"

    private let logo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Logo")
        return image
    }()

    private let sortButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.isEnabled = true
        return button
    }()

    private let customView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()

    private let tableView: PokemonTableView = {
        let tableView = PokemonTableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .black
        return tableView
    }()

    private var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        return activityIndicator
    }()

    private var imgSort: UIImage = {
        let sortImage = UIImage(named: "icon_sort")
//        sortImage?.withTintColor(.blue)
        return sortImage!
    }()

    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Search Pokémon by name", attributes: placeholderAttributes)

        let searchIconImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIconImageView.tintColor = .white
        searchIconImageView.contentMode = .center

        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        leftViewContainer.contentMode = .left
        leftViewContainer.addSubview(searchIconImageView)

        textField.leftView = leftViewContainer
        textField.leftViewMode = .always

        searchIconImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leftViewContainer.widthAnchor.constraint(equalToConstant: 40),
            searchIconImageView.leadingAnchor.constraint(equalTo: leftViewContainer.leadingAnchor, constant: 10),
            searchIconImageView.centerYAnchor.constraint(equalTo: leftViewContainer.centerYAnchor)
        ])

        return textField
    }()

    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindingViewModel()
        showLoadingIndicator()
        viewModel.requestPokemons()
    }

    private func showLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }

    private func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }

    private func bindingViewModel() {
        viewModel.listDidChange = { viewModel in
            self.viewModel = viewModel
            DispatchQueue.main.async { [weak self] in
                self?.tableView.update(with: viewModel)
                self?.hideLoadingIndicator()
            }
        }
    }
}

// MARK: - UI Methods
extension HomeViewController {
    private func configureView() {
        configureCustomView()
        configureTableView()
        loadingIndicator.center = view.center
    }

    private func configureCustomView() {
        // Search
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // sortButton
        sortButton.setImage(imgSort, for: .normal)
        sortButton.addTarget(self, action: #selector(sortPokemons), for: .touchUpInside)

        customView.addSubview(logo)
        customView.addSubview(searchTextField)
        customView.addSubview(sortButton)
        view.addSubview(customView)

        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: customView.topAnchor, constant: 30)
        ])

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 5),
            searchTextField.trailingAnchor.constraint(equalTo: sortButton.leadingAnchor, constant: -5),
            searchTextField.heightAnchor.constraint(equalToConstant: 35)
        ])

        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            sortButton.widthAnchor.constraint(equalToConstant: 35),
            sortButton.heightAnchor.constraint(equalToConstant: 35),
            sortButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -5)
        ])

    }

    private func configureTableView() {
        customView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Navigation
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonController" {
            if let destinationVC = segue.destination as? PokemonController,
               let pokemon = sender as? Pokemon {
                destinationVC.pokemon = pokemon
            }
        }
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc func sortPokemons() {
        viewModel.sortPokemons(sortDirection: sortedList)
        sortedList = sortedList == "up" ? "down" : "up"
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.findPokemon(textField: textField.text ?? "", sortDirection: sortedList)
        tableView.reloadData()
    }
}