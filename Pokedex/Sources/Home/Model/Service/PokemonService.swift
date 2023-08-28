import Foundation

enum ServiceError: Error {
    case invalidURL
    case network(Error?)
    case decodeFail(Error)
}

class PokemonService {
    private let baseURL = "https://flip-pokemon-api.azurewebsites.net"
//    private let baseURL = "http://localhost:3334"


    func fetchPokemonCachedList(genIDs: [Int]?) async throws -> [Pokemon] {
        var path = "/cached"
        /*if let genIDs = genIDs {
            let formattedGenIDs = genIDs.map {
                        String($0)
                    }
                    .joined(separator: ",")
            let query = "genIDs=[\(formattedGenIDs)]".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            path = path + "?" + query
        }*/

        guard let url = URL(string: baseURL + path) else {
            throw ServiceError.invalidURL
        }

        print("url: ", url)

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([Pokemon].self, from: data)
            return response
        } catch {
            throw ServiceError.decodeFail(error)
        }
    }
}

