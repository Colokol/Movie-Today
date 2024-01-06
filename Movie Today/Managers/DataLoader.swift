//
//  DataLoader.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 24.12.23.
//

import Foundation

final class DataLoader {

    static let shared = DataLoader()

    func loadData(fromURL urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }.resume()
    }

}
