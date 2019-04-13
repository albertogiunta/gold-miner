//
//  Object.swift
//  GoldMiner
//
//  Created by Bilyana Georgieva on 13/04/2019.
//  Copyright © 2019 BG&AG. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

struct UndergroundObjectModel {

  static var maxWeight: Float =  100
  static var maxValue: Float = 500

  enum ObjectType {
    case gold
    case stone
  }

  enum ObjectSize {
    case small
    case medium
    case large
  }

  var objectType: ObjectType
  var objectSize: ObjectSize
  var availableSpace: CGSize

  lazy var value: Float = {
    let multiplicand: Float
    switch (self.objectType, self.objectSize) {
    case (.gold, .small):
      multiplicand = Float.random(in: 0.05..<0.2)
    case (.gold, .medium):
      multiplicand = Float.random(in: 0.2..<0.5)
    case (.gold, .large):
      multiplicand = Float.random(in: 0.5...1)
    case (.stone, _):
      multiplicand = 0.05
    }
    return multiplicand * UndergroundObjectModel.maxValue
  }()

  lazy var weight: Float = {
    let multiplicand: Float
    switch (self.objectType, self.objectSize) {
    case (.gold, _):
      multiplicand = self.value/UndergroundObjectModel.maxValue
    case (.stone, .small):
      multiplicand = Float.random(in: 0.2..<0.3)
    case (.stone, .medium):
      multiplicand = Float.random(in: 0.3..<0.7)
    case (.stone, .large):
      multiplicand = Float.random(in: 0.7..<1)
    }
    return multiplicand * UndergroundObjectModel.maxWeight
  }()

  lazy var size: CGSize = {
    let ratio = CGFloat(self.weight / UndergroundObjectModel.maxWeight)
    return CGSize(width: ratio * self.availableSpace.width, height: ratio * self.availableSpace.height)
  }()

  var image: UIColor {
    switch objectType {
    case .gold:
      return .yellow
    case .stone:
      return .gray
    }
  }

  lazy var view: SKShapeNode = {
    let view = SKShapeNode(circleOfRadius: min(self.size.width, self.size.height)/2)
    view.fillColor = self.image
    return view
  }()
}

extension UndergroundObjectModel {
  init(type: ObjectType, size: ObjectSize, maxSize: CGSize) {
    self.objectType = type
    self.objectSize = size
    self.availableSpace = maxSize
  }
}
