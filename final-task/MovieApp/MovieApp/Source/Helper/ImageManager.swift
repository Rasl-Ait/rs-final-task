//
//  ImageManager.swift
//  MovieApp
//
//  Created by rasul on 11/9/21.
//

import Foundation
import CocoaLumberjackSwift

class ImageManager {
  // Функция для создания уменьшенной версии image
  func resize(image: UIImage, to width: CGFloat) -> UIImage? {
    let scale = width / image.size.width
    let height = image.size.height * scale
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
    image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  // Функция для сохранения image в FileManager
  func saveNewMemory(imageString: String, key: String) -> String {
    let url = URL(string: imageString)
    let memoryName = "\(key)"
   let thumbnailName = memoryName
      
    downloadImage(from: url) { [weak self] image in
      guard let self = self else { return }
      do {
        if let thumbnail = self.resize(image: image, to: 250) {
          let imagePath = FileManager.getDocumentsDirectoryURL().appendingPathComponent(thumbnailName)
          
          if let jpegData = thumbnail.jpegData(compressionQuality: 0.8) {
            try jpegData.write(to: imagePath, options: [.atomicWrite])
          }
        }
      } catch {
        DDLogError("Failed to save to disk.")
      }
    }
    return thumbnailName
  }
  
  func load(filename: String) -> URL {
    return FileManager.getDocumentsDirectoryURL().appendingPathComponent(filename)
  }
  
  func remove(filename: String) {
    do {
      let url = FileManager.getDocumentsDirectoryURL().appendingPathComponent(filename)
      try FileManager.default.removeItem(at: url)
    } catch let error as NSError {
        print("Error: \(error.domain)")
    }
  }
  
  func downloadImage(from imageURL: URL?, completion: @escaping ItemClosure<UIImage>) {
    guard let url = imageURL else {
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
    
      if error != nil { return }
      guard
        let response = response as? HTTPURLResponse,
        response.statusCode == 200
      else { return }
      
      guard let data = data else { return }
      guard let image = UIImage(data: data) else { return }
      completion(image)
    }.resume()
  }
}
