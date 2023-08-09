import Foundation

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
    case decodeFail(Error)
}

class PokemonService {
    private let baseURL = "http://localhost:3334"

    func getPokemonsCached(genIDs: [Int]?, callback: @escaping (Result<[Pokemon], ServiceError>) -> Void) {
        print("get pokemons cached")
        print("genIDs", genIDs)

        var path = "/cached"
        if let genIDs = genIDs {
            let formattedGenIDs = genIDs.map {
                String($0)
            }
                .joined(separator: ",")
            let query = "genIDs=[\(formattedGenIDs)]"
                path = path + "?" + query
        }

        guard let url = URL(string: baseURL + path) else {
            callback(.failure(.invalidURL))
            return
        }
        
        print("url => ", url)

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }

            do {
                let json = try JSONDecoder().decode([Pokemon].self, from: data)
                callback(.success(json))
            } catch {
                callback(.failure(.decodeFail(error)))
            }
        }

        task.resume()
    }
}

