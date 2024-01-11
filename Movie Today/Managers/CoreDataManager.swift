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
        movie.poster = model.poster?.url
        movie.rating = model.rating?.kp ?? 0
        guard let id = model.id else { return }
        movie.id = Int64(id)
        
        if let firstGenre = model.genres?.first {
            movie.genre = firstGenre.name
        }
        guard let url =  model.poster?.url else {return}
        
        dataLoader.loadData(fromURL: url) { imageData in
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
        guard let name = model.name else {return}
        let fetchRequest = FavoriteMovies.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
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
    
    func saveUser(username: String, email: String, password: String, image: Data?) {
        let authorization = User(context: mainContext)
        authorization.userimage = image
        authorization.username = username
        authorization.password = password
        authorization.email = email
        
        saveContext()
    }
    
    //MARK: - RecentMovies
    
    func saveToRecent(from model: Doc) {
        configRecentMovie(with: model)
        saveContext()
    }
    
            
    private func configRecentMovie(with model: Doc) {
        guard let id = model.id else { return }

        let request: NSFetchRequest<RecentMovie> = RecentMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let existingMovies = try mainContext.fetch(request)
            if let existingMovie = existingMovies.first {
                // Удаление существующего фильма
                mainContext.delete(existingMovie)
                saveContext()
            }

            // Создание нового фильма
            let movie = RecentMovie(context: mainContext)
            movie.id = Int64(id)
            movie.name = model.name
            movie.genre = model.genres?.first?.name
            movie.poster = model.poster?.url
            guard let lenght = model.movieLength else { return }
            movie.lenght = Int64(lenght)
            guard let rait = model.ageRating else { return }
            movie.raitPG = Int64(rait)
            movie.type = model.type
            guard let year = model.year else { return }
            movie.year = Int64(year)
            guard let raiting = model.rating?.kp else { return }
            movie.raiting = raiting
            guard let url =  model.poster?.url else { return }
            dataLoader.loadData(fromURL: url) { imageData in
                if let imageData = imageData {
                    movie.image = imageData
                    self.saveContext() 
                } else {
                    print("Failed to load image data for \(String(describing: model.name))")
                }
            }
        } catch {
            print("Error fetching movie from Core Data: \(error)")
        }
    }

    
    func loadRecentMovies(complition: (Result<[RecentMovie], Error>) -> Void) {
        let request: NSFetchRequest<RecentMovie> = RecentMovie.fetchRequest()
        
        do {
            let movies = try mainContext.fetch(request)
            complition(.success(movies))
        } catch {
            complition(.failure(error))
        }
    }

}
