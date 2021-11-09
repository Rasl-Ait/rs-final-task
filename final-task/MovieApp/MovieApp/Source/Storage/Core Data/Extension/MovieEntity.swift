//
//  MovieEntity.swift
//  MovieApp
//
//  Created by rasul on 11/9/21.
//

import CoreData

extension MovieEntity {
  static func find(byID id: Int, context: NSManagedObjectContext) -> MovieEntity {
    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %d", id)
    
    guard let result = try? context.fetch(request)
      else {
      return MovieEntity(context: context)
      
    }
    return result.first ?? MovieEntity(context: context)
  }
}
