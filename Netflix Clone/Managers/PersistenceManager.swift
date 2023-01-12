//
//  PersistenceManager.swift
//  Netflix Clone
//
//  Created by Umut Barış Çoşkun on 12.01.2023.
//

import Foundation
import UIKit
import CoreData

class PersistenceManager {
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    static let shared = PersistenceManager()
    
    func downloadMovie(model: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        
        item.original_title = model.original_title
        item.id         = Int64(model.id)
        item.original_name  = model.original_name
        item.overview     =  model.overview
        item.media_type    = model.media_type
        item.poster_path   = model.poster_path
        item.release_date   = model.release_date
        item.vote_count    = Int64(model.vote_count)
        item.vote_average  = model.vote_average
        
        do {
            try context.save()
            completion(.success(()))
        }
        catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchDatasFromDatabase(completion: @escaping (Result<[MovieItem],Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieItem>
        
        request = MovieItem.fetchRequest()
        
        do{
         let movies =  try context.fetch(request)
            completion(.success(movies))
            
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteItemWith(model: MovieItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
