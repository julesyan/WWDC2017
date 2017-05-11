import SpriteKit

public class WaterDrop{
    let drop: SKSpriteNode
    var delay: Int
    var randomX: Int
    var randomY: Int
    var randomYSpeed: Int
    var counter = 0
    
    var loc: CGPoint {
        get {
            return drop.position
        }
    }
    
    init(texture: SKTexture?) {
        drop = SKSpriteNode(texture: texture)
        delay = Int(arc4random_uniform(60))
        randomX = Int(arc4random_uniform(10))
        randomYSpeed = Int(arc4random_uniform(4))
        randomY = Int(arc4random_uniform(20))
        drop.position.x = -800
        drop.position.y = -800
        drop.isHidden = true
    }
    
    //Getting the drop node (for adding and such)
    public func getNode() -> SKSpriteNode{
        return drop
    }
    
    //If we collide with soemthing (size of drop is small enough that we don't take into account the size of the drop)
    public func collide(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> Bool {
        if (x <= drop.position.x &&
            y <= drop.position.y &&
            x + width >= drop.position.x &&
            y + height >= drop.position.y) {
            return true
        }
        return false
    }
    
    public func hide(){
        drop.position.x = -800
        drop.position.y = -800
    }
    
    //Resetting the drop to be at the new can location
    public func reset(newCan: CGPoint){
        guard delay == 0 else {
            delay -= 1
            return
        }
        randomX = Int(arc4random_uniform(10))
        drop.position.x = newCan.x - CGFloat(randomX)
        drop.position.y = newCan.y + CGFloat(randomY)
        delay = Int(arc4random_uniform(60))
        counter = 0
        drop.isHidden = true
    }
    
    //Called in the scene update, returns if hit end of screen
    public func update() -> Bool{
        //Stop moving if at the bottom of the scene
        if (drop.position.y > drop.frame.height * -1) {
            drop.isHidden = false
            drop.position.y -= 0.05 * CGFloat(randomYSpeed) * CGFloat(counter) + 0.1 * CGFloat(counter)
            drop.position.x -= 1.75
            counter += 1
            return true
        } else {
            drop.isHidden = true
            return false
        }
    }
}
