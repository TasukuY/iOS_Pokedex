//
//  PokemonController.swift
//  PokedexiOS
//
//  Created by Tasuku Yamamoto on 4/26/22.
//

import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    static let pokemonEndpoint = "pokemon"
    
    static func fetchPokemon(searchterm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        //1. URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint)
        let searchtermURL = pokemonURL.appendingPathComponent(searchterm.lowercased())
        print(searchtermURL)
        
        //2. contact server/ data task
        let dataTask = URLSession.shared.dataTask(with: searchtermURL) { data, response, error in
            //3. handle errors
            if let error = error {
                print("Error while accessing the server: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            //4. check for data
            guard let data = data else { return completion(.failure(.noData)) }
            //5. decode data
            do{
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                return completion(.success(pokemon))
            }catch{
                print("Error while decoding the data: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
        }
        dataTask.resume()
    }//End of function
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void){
        //1. URL
        let spriteURL = pokemon.sprites.classicSpriteURL
        
        //2. datatask
        let dataTask = URLSession.shared.dataTask(with: spriteURL) { data, response, error in
            //3. error
            if let error = error {
                print("Error while accessing the server: \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            //4. check data
            guard let data = data else { return completion(.failure(.noData)) }
            //5. decode data
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(sprite))
        }
        dataTask.resume()
        
    }
    
}//End of class

