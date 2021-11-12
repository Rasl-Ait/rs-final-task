//
//  MoviePersistenceTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/6/21.
//

import XCTest
import CoreData
@testable import MovieApp

class MoviePersistenceTest: XCTestCase {
  var coredataStack: CoreDataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
  var persistence: StorageProtocol!
  var list: ListModel!
  
  override func setUpWithError() throws {
    coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    persistence = MoviePersistence(context: coredataStack.managedContext,
                                   backgroundContext: coredataStack.managedContext)
    list = ListModel(description: "text",
                     favoriteCount: 1,
                     id: 1, itemCount: 2,
                     listType: "movie",
                     name: "One",
                     posterPath: nil)
  }
  
  func test_addIListNotNil() throws {
    persistence.addList(list)
    let item = persistence.fetchItem(.uid(list.id))
    XCTAssertNotNil(item)
  }
  
  func test_addIListNil() throws {
    let item = persistence.fetchItem(.uid(list.id))
    XCTAssertNil(item)
  }
  
  func test_addIListDuplication() throws {
    persistence.addList(list)
    persistence.addList(list)
    persistence.fetch(nil)
    XCTAssertEqual(persistence.items.count, 1)
  }
  
  func test_movieAddNil() throws {
    persistence.addList(list)
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    let item = persistence.fetchMovie(.uid(movie.id))
    XCTAssertNil(item)
  }
  
  func test_addMovieDuplication() throws {
    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    let context = coredataStack.managedContext
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    let movie2 = MovieModel(id: 1,
                            originalTitle: "title",
                            originalName: nil,
                            overview: "overview",
                            releaseDate: "2015-05-12",
                            posterPath: "image",
                            popularity: 2.0,
                            title: "Venom",
                            voteAverage: 10.0)
    
    persistence.addMovie(movie, listID: list.id)
    persistence.addMovie(movie2, listID: list.id)
    let count = try context.count(for: request)
    XCTAssertEqual(count, 1)
  }
  
  func test_listMoviesAdd() throws {
    persistence.addList(list)
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    persistence.addMovie(movie, listID: list.id)
    let listModel = persistence.fetchItem(.uid(list.id))
    XCTAssertEqual(listModel?.movies?.count, 1)
  }
  
  func test_fetchItems() throws {
    let item = ListModel(description: "text",
                         favoriteCount: 1,
                         id: 2, itemCount: 2,
                         listType: "movie",
                         name: "One",
                         posterPath: nil)
    
    persistence.addList(list)
    persistence.addList(item)
    persistence.fetch(nil)
    
    XCTAssertEqual(persistence.items.count, 2)
  }

  func test_fetchPredicateItem() throws {
    persistence.addList(list)
    let item = self.persistence.fetchItem(.uid(list.id))
    XCTAssertNotNil(item)
  }

  func test_fetchPredicateItemNil() throws {

    persistence.addList(list)
    let item = self.persistence.fetchItem(.uid(2))
    XCTAssertNil(item)
  }

  func test_removeListNil() throws {
    
    let item = ListModel(description: "text",
                         favoriteCount: 1,
                         id: 2, itemCount: 2,
                         listType: "movie",
                         name: "One",
                         posterPath: nil)
    
    let item2 = ListModel(description: "text",
                          favoriteCount: 1,
                          id: 3, itemCount: 2,
                          listType: "movie",
                          name: "One",
                          posterPath: nil)
    persistence.addList(list)
    persistence.addList(item)
    persistence.addList(item2)

    persistence.remove(with: item.id)
    let model = persistence.fetchItem(.uid(item.id))

    XCTAssertNil(model)
  }
  
  func test_removeMovieNil() throws {
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    let movie2 = MovieModel(id: 10,
                            originalTitle: "title",
                            originalName: nil,
                            overview: "overview",
                            releaseDate: "2015-05-12",
                            posterPath: "image",
                            popularity: 2.0,
                            title: "Venom",
                            voteAverage: 10.0)
    
    persistence.addList(list)
    persistence.addMovie(movie, listID: list.id)
    persistence.addMovie(movie2, listID: list.id)

    persistence.removeMovie(with: movie.id)
    let model = persistence.fetchMovie(.uid(movie.id))

    XCTAssertNil(model)
  }
  
  func test_addFavoriteMovieNotNil() throws {
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    let item = persistence.fetchFavoriteMovie(.uid(movie.id))
    XCTAssertNotNil(item)
  }
  
  func test_addFavoriteMovieNil() throws {
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    let item = persistence.fetchFavoriteMovie(.uid(2))
    XCTAssertNil(item)
  }
  
  func test_addFavoriteMovieDuplication() throws {
    let request: NSFetchRequest<FavoriteMovieEntity> = FavoriteMovieEntity.fetchRequest()
    let context = coredataStack.managedContext
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    let movie2 = MovieModel(id: 1,
                            originalTitle: "title",
                            originalName: nil,
                            overview: "overview",
                            releaseDate: "2015-05-12",
                            posterPath: "image",
                            popularity: 2.0,
                            title: "Venom",
                            voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    persistence.addFavoriteMovie(movie2)
    let count = try context.count(for: request)
    XCTAssertEqual(count, 1)
  }
  
  func test_fetchFavoriteMovieItemNotNil() throws {
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    let item = self.persistence.fetchFavoriteMovie(.uid(movie.id))
    XCTAssertNotNil(item)
  }
  
  func test_fetchFavoriteMovieItemNil() throws {
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    let item = self.persistence.fetchFavoriteMovie(.uid(2))
    XCTAssertNil(item)
  }
  
  func test_removeFavoriteMovieNil() throws {
    
    let movie = MovieModel(id: 1,
                           originalTitle: "title",
                           originalName: nil,
                           overview: "overview",
                           releaseDate: "2015-05-12",
                           posterPath: "image",
                           popularity: 2.0,
                           title: "Venom",
                           voteAverage: 10.0)
    
    let movie2 = MovieModel(id: 10,
                            originalTitle: "title",
                            originalName: nil,
                            overview: "overview",
                            releaseDate: "2015-05-12",
                            posterPath: "image",
                            popularity: 2.0,
                            title: "Venom",
                            voteAverage: 10.0)
    
    persistence.addFavoriteMovie(movie)
    persistence.addFavoriteMovie(movie2)

    persistence.removeFavoriteMovie(with: movie.id)
    let model = persistence.fetchFavoriteMovie(.uid(movie.id))
    XCTAssertNil(model)
  }
}
