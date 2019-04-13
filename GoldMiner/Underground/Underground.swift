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

class Underground: SKShapeNode {

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

    //create the objects
    //align them randomly but evenly distributed

    let horizontalSpaces: CGFloat = 2
    let verticalSpaces: CGFloat = 2
    let maxSize = CGSize(width: UIScreen.main.bounds.width/horizontalSpaces, height: UIScreen.main.bounds.height/verticalSpaces * (2/3))

    self.objects.append(UndergroundObjectModel(type: .gold, size: .medium, maxSize: maxSize))
    self.objects.append(UndergroundObjectModel(type: .gold, size: .small, maxSize: maxSize))
    self.objects.append(UndergroundObjectModel(type: .stone, size: .medium, maxSize: maxSize))
    self.objects.append(UndergroundObjectModel(type: .gold, size: .large, maxSize: maxSize))


    for var object in self.objects.enumerated() {
      // get the size of the object and calculate the difference from the space it can occupy
      let startingPoint = CGPoint(x: CGFloat(object.offset).truncatingRemainder(dividingBy: 2) * maxSize.width, y: CGFloat(Int(object.offset)/2) * maxSize.height)
      let endingPoint = CGPoint(x: startingPoint.x + maxSize.width, y: startingPoint.y + maxSize.height)

      let width = object.element.view.frame.width
      let height = object.element.view.frame.height

      //check range
      let randomX = Int.random(in: Int(startingPoint.x + (width / 2))...Int(endingPoint.x - (width / 2)))
      let randomY = Int.random(in: Int(startingPoint.y + (width / 2))...Int(endingPoint.y - (width / 2)))

      object.element.view.position = CGPoint(x: randomX, y: randomY)
      self.addChild(object.element.view)
    }
  }

  func style() {
    self.fillColor = .brown
    self.strokeColor = .brown
  }

  func update() {

  }
}
