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
  private var bottom: SKShapeNode = SKShapeNode(rect: .zero)

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(size: CGSize) {
    super.init(size: size)
    self.setup()
    self.style()
  }

  func setup() {
//    let cityWidth: CGFloat = (self.screenBounds.width - 40.0)
//    let cityHeight: CGFloat = cityWidth * 9.0 / 16.0
//    let cityX: CGFloat = 20
//    let cityY: CGFloat = 0//cityHeight / 2.0
//    let cityRect = CGRect(origin: CGPoint(x: cityX, y: cityY), size: CGSize(width: cityWidth, height: cityHeight))
//
//    self.top = SKShapeNode(ellipseIn: cityRect)
//    self.addChild(self.top)
//
//    self.bottom = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.screenBounds.width, height: cityHeight/2.0))
//    self.addChild(self.bottom)
//
//    self.label = SKLabelNode(text: "Score: \(score)")
//    self.label.position = CGPoint(x: self.screenBounds.width / 2, y: self.screenBounds.height - 20 - 44)
//    self.addChild(self.label)

    self.bottom = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.screenBounds.width, height: self.screenBounds.height/3 * 2))
    self.addChild(self.bottom)

    self.top = SKShapeNode(rect: CGRect(x: 0, y: self.bottom.frame.maxY, width: self.screenBounds.width, height: self.screenBounds.height/3))
    self.addChild(self.top)
  }

  func style() {
    self.backgroundColor = .black
    self.top.fillColor = .blue
    self.bottom.fillColor = .brown
    self.bottom.strokeColor = .brown

  }

  //  func createAsteroid() {
  //    let asteroid = SKShapeNode(circleOfRadius: CGFloat.random(in: 10..<50))
  //    asteroid.fillColor = .gray
  //    asteroid.strokeColor = .gray
  //    asteroid.position = CGPoint(x: CGFloat.random(in: 0..<self.screenBounds.width), y: self.screenBounds.height)
  //    let cityCenter = CGPoint(x: self.frame.width / 2.0, y: self.city.frame.height / 2.0)
  //    let roadToCollisionAction = SKAction.move(to: cityCenter, duration: 4)
  //    self.addChild(asteroid)
  //    self.asteroids.append(asteroid)
  //    asteroid.run(roadToCollisionAction) {
  //      self.removeChildren(in: [asteroid])
  //    }
  //  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
    //    guard let lastAsterodiTime = self.lastAsterodiTime else {
    //      spawnAsteroid(currentTime: currentTime)
    //      return
    //    }
    //
    //    if currentTime - lastAsterodiTime > 1 {
    //      spawnAsteroid(currentTime: currentTime)
    //    }
    //
    //    self.label.text = "Score: \(self.score)"
  }

  //  func spawnAsteroid(currentTime: TimeInterval) {
  //    self.createAsteroid()
  //    self.lastAsterodiTime = currentTime
  //  }
}

