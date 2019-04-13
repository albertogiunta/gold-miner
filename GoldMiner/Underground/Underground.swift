//
//  Gold.swift
//  GoldMiner
//
//  Created by Bilyana Georgieva on 13/04/2019.
//  Copyright © 2019 BG&AG. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

enum Categories: UInt32 {
  case hand = 0b0001
  case object = 0b0010
}

class Underground: SKShapeNode {

  var rows: Int = 4 {
    didSet {
      self.update()
    }
  }

  var objects: [UndergroundObjectModel] = []

  override init() {
    super.init()
    self.setup()
    self.style()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup() {

    let maxSize = CGSize(width: UIScreen.main.bounds.width/CGFloat(rows), height: UIScreen.main.bounds.height/CGFloat(rows) * (2/3))

    for i in 0..<(rows*rows) {
      self.objects.append(UndergroundObjectModel(type: UndergroundObjectModel.ObjectType.random, size: UndergroundObjectModel.ObjectSize.random, maxSize: maxSize))
    }


    for var object in self.objects.enumerated() {
      // get the size of the object and calculate the difference from the space it can occupy
      let startingPoint = CGPoint(x: CGFloat(Int(object.offset % rows)) * maxSize.width, y: CGFloat(Int(object.offset/rows)) * maxSize.height)
      let endingPoint = CGPoint(x: startingPoint.x + maxSize.width, y: startingPoint.y + maxSize.height)

      let width = object.element.view.frame.width
      let height = object.element.view.frame.height

      //check range
      let randomX = Int.random(in: Int(startingPoint.x + (width / 2))...Int(endingPoint.x - (width / 2)))
      let randomY = Int.random(in: Int(startingPoint.y + (width / 2))...Int(endingPoint.y - (width / 2)))

      object.element.view.position = CGPoint(x: randomX, y: randomY)
      
      let physicsBody = SKPhysicsBody(circleOfRadius: width / 2)
      physicsBody.categoryBitMask = Categories.object.rawValue
      physicsBody.affectedByGravity = false
      physicsBody.isDynamic = false
      
      self.addChild(object.element.view)
    }
  }

  func style() {
    self.fillColor = .brown
    self.strokeColor = .brown
  }

  func update() {
    self.objects = []
    self.removeAllChildren()
    self.setup()
  }
}
