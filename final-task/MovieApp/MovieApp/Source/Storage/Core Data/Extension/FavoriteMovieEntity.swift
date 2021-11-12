//
//  FavoriteFavoriteMovieEntity.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import CoreData

extension FavoriteMovieEntity {
  static func find(byID id: Int, context: NSManagedObjectContext) -> FavoriteMovieEntity {
    let request: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %d", id)
    
    guard let result = try? context.fetch(request)
      else {
      return FavoriteMovieEntity(context: context)
      
    }
    return result.first ?? FavoriteMovieEntity(context: context)
  }
}
