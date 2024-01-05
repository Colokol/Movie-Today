//
//  CoreData.swift
//  Movie Today
//
//  Created by Anna Zaitsava on 4.01.24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FavoriteMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveToFavorites(from model: Doc) -> Bool {
        let movie = FavoriteMovies(context: viewContext)
        movie.name = model.name
        movie.type = model.type
        movie.poster = model.poster.url
        movie.rating = model.rating.kp
        if let firstGenre = model.genres.first {
                   movie.genre = firstGenre.name
               }
        
        do {
            try viewContext.save()
            return true
        } catch {
            print("Failed to save to favorites: \(error)")
            return false
        }
    }
    
    func deleteFromFavorites(_ movie: FavoriteMovies) -> Bool {
        do {
            viewContext.delete(movie)
            try viewContext.save()
            return true
        } catch {
            print("Failed to delete from favorites: \(error)")
            return false
        }
    }
    
    func loadFavoriteMovies() throws -> [FavoriteMovies] {
           let request: NSFetchRequest<FavoriteMovies> = FavoriteMovies.fetchRequest()
           return try viewContext.fetch(request)
       }
}


