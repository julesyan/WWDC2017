import SpriteKit

public class WateringCan {
    let can: SKSpriteNode
    var mouseDragged = false
    var mouseUp = false
    let rotationSpeed: CGFloat = 0.01 * .pi
    
    var node: SKSpriteNode {
        get{
            return can
        }
    }
    
    var size: CGSize {
        get {
            return can.size
        }
    }
    
    var loc: CGPoint {
        get {
            return can.position
        }
    }
    
    var spoutLoc: CGPoint {
        get {
            return CGPoint(x: loc.x - (size.width / 2) + 13, y: loc.y - (size.height / 2) + 5)
        }
    }
    
    var rotaiton: CGFloat{
        get{
            return can.zRotation
        }
    }
    
    init(xPos: CGFloat, yPos: CGFloat) {
        self.can = SKSpriteNode(imageNamed: "can.png")
        self.can.setScale(0.5)
        self.can.position.x = xPos
        self.can.position.y = yPos
    }
    
    public func updateMouseDown(event: NSEvent, collide: Bool) {
        //If we are not colliding, update
        if (!collide) {
            self.can.position.x = event.locationInWindow.x
            self.can.position.y = event.locationInWindow.y
            self.mouseDragged = true
            self.mouseUp = false
        }
    }
    
    public func updateMouseUp(event: NSEvent) {
        self.mouseUp = true
        self.mouseDragged = false
    }
    
    public func updateMouseDragged(event: NSEvent, collide: Bool) {
        //If we are not colliding, update
        if (!collide) {
            self.can.position.x = event.locationInWindow.x
            self.can.position.y = event.locationInWindow.y
            self.mouseDragged = true
            self.mouseUp = false
        }
    }
    
    public func update() {
        if (mouseDragged && can.zRotation < 0.25 * .pi) {
            can.zRotation += rotationSpeed
        } else if (mouseUp && can.zRotation > 0) {
            can.zRotation -= rotationSpeed
        }
    }
}

