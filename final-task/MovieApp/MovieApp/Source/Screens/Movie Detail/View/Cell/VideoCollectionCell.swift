//
//  VideoCollectionCell.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit
import youtube_ios_player_helper

class VideoCollectionCell: BaseCollectionViewCell {
  
  private var playerView = YTPlayerView()
  
  override func addSubViews() {
    setupViews()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    playerView.removeWebView()
  }
  
  func configure(model: MovieVideo) {
    playerView.load(withVideoId: model.key)
  }
}

private extension VideoCollectionCell {
  func setupViews() {
    backgroundColor = .cellBackgroundColor
    layer.cornerRadius = .spacingSM
    clipsToBounds = true
    addShadow()
    
    playerView.layer.cornerRadius = .spacingS
    playerView.clipsToBounds = true
    
    addSubview(playerView)
    
    playerView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(7)
    }
  }
}
