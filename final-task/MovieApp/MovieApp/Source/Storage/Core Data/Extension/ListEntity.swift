//
//  ListEntity.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import Foundation
import CoreData

extension ListEntity {
  static func find(byID id: Int, context: NSManagedObjectContext) -> ListEntity {
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %d", id)
    
    guard let result = try? context.fetch(request)
      else {
      return ListEntity(context: context)
      
    }
    return result.first ?? ListEntity(context: context)
  }
}
