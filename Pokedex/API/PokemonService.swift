import Foundation

struct Home: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Other: Codable {
    let home: Home?
}

struct Sprite: Codable {
    let backDefault: URL?
    let backFemale: URL?
    let backShiny: URL?
    let backShinyFemale: URL?
    let frontDefault: String?
    let frontFemale: URL?
    let frontShiny: URL?
    let frontShinyFemale: URL?
    let other: Other?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case other = "other"
    }
}

struct TypeSlot: Codable {
    let slot: Int
    let type: TypeData
}

struct TypeData: Codable {
    let name: String
//    let url: URL
}

struct PokemonInitial: Codable {
    let id: Int
    let weight: Int
    let height: Int
    let name: String
    let sprites: Sprite
    let types: [TypeSlot]
    let imgDefault: String?
}

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
    case decodeFail(Error)
}

class PokemonService {
    private let baseURL = "https://pokeapi.co/api/v2"

    // Recupera os dados iniciais para criar a lista de pokemons
    func getPokemonInfo(id: Int, callback: @escaping (Result<PokemonInitial, ServiceError>) -> Void) {
        let path = "/pokemon/\(id)"

        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }

            do {
                let json = try JSONDecoder().decode(PokemonInitial.self, from: data)
                callback(.success(json))
            } catch {
                callback(.failure(.decodeFail(error)))
            }
        }
        task.resume()
    }


}

