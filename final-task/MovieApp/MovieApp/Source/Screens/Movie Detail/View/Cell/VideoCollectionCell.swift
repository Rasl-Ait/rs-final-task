//
//  VideoCollectionCell.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit
import YouTubePlayer

class VideoCollectionCell: BaseCollectionViewCell {
  
  private var playerView = YouTubePlayerView()
  
  override func addSubViews() {
    setupViews()
  }
  
  func configure(model: MovieVideo) {
    playerView.loadVideoID(model.key)
  }
}

private extension VideoCollectionCell {
  func setupViews() {
    backgroundColor = .red
    addSubview(playerView)
    
    playerView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}