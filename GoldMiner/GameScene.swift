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
  
  private var dude: SKShapeNode = SKShapeNode(rect: .zero)
  private var hand: SKShapeNode = SKShapeNode(rect: .zero)
  
  private var canTouch: Bool = true
  private var catchAction: SKAction?

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
    self.top = SKShapeNode(rect: CGRect(x: 0, y: self.bottom.frame.maxY, width: self.screenBounds.width, height: self.screenBounds.height/3))
    
    let dudeWidth: CGFloat = 50
    self.dude = SKShapeNode(circleOfRadius: dudeWidth)
    self.dude.position = CGPoint(x: (self.screenBounds.width / CGFloat(2)) - dudeWidth / CGFloat(2), y: self.top.frame.minY)
    let dudePhysics = SKPhysicsBody(circleOfRadius: dudeWidth)
    self.dude.physicsBody = dudePhysics
    dudePhysics.affectedByGravity = false
    dudePhysics.isDynamic = false
    
    self.hand = SKShapeNode(circleOfRadius: dudeWidth)
    self.hand.position = CGPoint(x: self.dude.frame.minX - dudeWidth * 2, y: self.dude.frame.minY)
    let handPhysics = SKPhysicsBody(circleOfRadius: dudeWidth)
    self.hand.physicsBody = handPhysics
    handPhysics.affectedByGravity = true
    handPhysics.friction = 0
    handPhysics.angularDamping = 0
    handPhysics.linearDamping = 0
    
    self.addChild(self.bottom)
    self.addChild(self.top)
    self.addChild(self.dude)
    self.addChild(self.hand)
    
    let joint = SKPhysicsJointLimit.joint(withBodyA: dudePhysics, bodyB: handPhysics, anchorA: CGPoint(x: self.dude.frame.midX, y: self.dude.frame.midY), anchorB: CGPoint(x: self.hand.frame.midX, y: self.hand.frame.midY))
    self.scene?.physicsWorld.add(joint)
  }

  func style() {
    self.backgroundColor = .black
    self.top.fillColor = .blue
    self.bottom.fillColor = .brown
    self.bottom.strokeColor = .brown
    
    self.dude.fillColor = .black
    self.hand.fillColor = .green
  }

  override func update(_ currentTime: TimeInterval) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard canTouch else { return }
    self.scene?.physicsWorld.speed = self.scene?.physicsWorld.speed == 0 ? 1 : 0
    
    if self.scene?.physicsWorld.speed == 0 {
      let m = 10 + (self.dude.frame.midY - self.hand.frame.midY) / (self.dude.frame.midX - self.hand.frame.midX)
      let xDiff = (self.hand.frame.midX - self.dude.frame.midX)
      let dx = abs(xDiff) == 0 ? 0 : xDiff > 0 ? m : -m
      catchAction = SKAction.move(by: CGVector(dx: dx, dy: -m), duration: TimeInterval(0.1))
      
      self.canTouch.toggle()
      self.move()
    }
  }
  
  func move(goForward: Bool = true, count: Int = 0) {
    guard let catchAction = catchAction else { return }
    print(self.hand.frame.midY)
    print(count)
    if self.hand.frame.midY < 0 {
      self.hand.run(catchAction.reversed(), completion: { [unowned self] in
        self.move(goForward: false, count: count - 1)
      })
      return
    } else {
    guard count >= 0 else {
      self.canTouch.toggle()
      self.scene?.physicsWorld.speed = 1
      return
    }
    self.hand.run(goForward ? catchAction : catchAction.reversed(), completion: { [unowned self] in
      self.move(goForward: goForward, count: goForward ? count + 1 : count - 1)
    })
    }
  }
}

