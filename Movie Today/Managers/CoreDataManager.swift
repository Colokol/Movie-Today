//
//  CoreData.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 4.01.24.
//

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()

    let dataLoader = DataLoader.shared

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteMovies")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private init() {}

        // MARK: - Core Data stack

    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("Failed to save context: \(error)")

            }
        }
    }

    func saveToFavorites(from model: Doc) {
        let movie = FavoriteMovies(context: mainContext)
        configureFavoriteMovie(movie, with: model)
        saveContext()
    }

    private func configureFavoriteMovie(_ movie: FavoriteMovies, with model: Doc) {
        movie.name = model.name
        movie.type = model.type
        movie.poster = model.poster.url
        movie.rating = model.rating.kp

        if let firstGenre = model.genres.first {
            movie.genre = firstGenre.name
        }

        dataLoader.loadData(fromURL: model.poster.url) { imageData in
            if let imageData = imageData {
                movie.image = imageData
                self.saveContext()
            } else {
                print("Failed to load image data for \(model.name)")
            }
        }
    }

    func deleteFromFavorites(_ movie: FavoriteMovies) {
        mainContext.delete(movie)
        saveContext()
    }

    func loadFavoriteMovies(completion: (Result<[FavoriteMovies], Error>) -> Void){
        let request: NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()

        do {
            let movies = try mainContext.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }

    func removeFromFavorites(model: Doc) {
        let fetchRequest = FavoriteMovies.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", model.name)

        do {
            let results = try mainContext.fetch(fetchRequest)
            if let objectToDelete = results.first {
                mainContext.delete(objectToDelete)
                saveContext()
            }
        } catch {
            print("Failed to delete from favorites: \(error)")
        }
    }

    func deleteAllLikes() {
        let fetchRequest = FavoriteMovies.fetchRequest()

        do {
            let allMoviesData = try mainContext.fetch(fetchRequest)
            for data in allMoviesData {
                mainContext.delete(data)
            }
            saveContext()
        } catch let error {
            print("Ошибка при удалении всех данных: \(error)")
        }
    }

}
