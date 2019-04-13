//
//  GameScene.swift
//  SaveThePlanetAsteroids
//
//  Created by Riccardo Cipolleschi on 11/03/2019.
//  Copyright © 2019 Bending Spoons S.p.a. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

  private var screenBounds: CGRect = UIScreen.main.bounds
  private var top: SKShapeNode = SKShapeNode(rect: .zero)
  private var bottom: Underground = Underground(rect: .zero)

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(size: CGSize) {
    super.init(size: size)
    self.setup()
    self.style()
  }

  func setup() {
    self.bottom = Underground(rect: CGRect(x: 0, y: 0, width: self.screenBounds.width, height: self.screenBounds.height/3 * 2))
    self.addChild(self.bottom)

    self.top = SKShapeNode(rect: CGRect(x: 0, y: self.bottom.frame.maxY, width: self.screenBounds.width, height: self.screenBounds.height/3))
    self.addChild(self.top)
  }

  func style() {
    self.backgroundColor = .black
    self.top.fillColor = .blue
  }

  override func update(_ currentTime: TimeInterval) {
  }
}

