import SpriteKit

public class GameScene: SKScene {
    
    let can: WateringCan
    var drops: [WaterDrop] = []
    let grass = SKSpriteNode()
    let ground = SKSpriteNode()
    var groundCollision = false
    var plants: [Plant] = []
    let numDrops = 400
    let numPlants = 5
    var mouseDragged = false
    var mouseX: CGFloat = 0
    var mouseY: CGFloat = 0
    var mouseOnScreen = true
    var collide = false
    var watering: [Bool] = []
    let screenSize: CGSize
    let fence: Fence
    var growing = false
    let title: Title
    let resetBtnSize: CGSize
    let resetBtn: Button
    
    override public init(size: CGSize) {
        //Creating all objects in scene
        resetBtnSize = CGSize(width: 100, height: 50)
        resetBtn = Button(size: resetBtnSize, text: "Reset")
        grass.size = CGSize(width: size.width, height: size.height / 8)
        grass.anchorPoint = CGPoint(x: 0, y: 0)
        grass.color = SKColor(red: 45.0/255.0, green: 143.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        ground.size = CGSize(width: size.width, height: size.height / 4)
        ground.anchorPoint = CGPoint(x: 0, y: 0)
        ground.color = SKColor.brown
        grass.position.y = ground.size.height
        grass.zPosition = -1
        can = WateringCan(xPos: size.width - 80, yPos: ground.position.y + ground.size.height + 40)
        can.node.zPosition = 6
        screenSize = size
        fence = Fence(size: size, groundSize: ground.size)
        title = Title(size: size)
        title.zPosition = 10
        resetBtn.position.x = size.width - 75
        resetBtn.position.y = 50
        
        super.init(size: size)
        self.backgroundColor = SKColor(red: 131.0/255.0, green: 190.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        
        // Adding things to be drawn
        addChild(title)
        addChild(grass)
        addChild(fence)
        addChild(ground)
        addChild(can.node)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func mouseDown(with event: NSEvent) {
        mouseDragged = true
        checkMouse(event: event)
        if (growing) {
            can.updateMouseDown(event: event, collide: groundCollision || !mouseOnScreen)
            
            //checkign reset btn
            if (event.locationInWindow.x >= resetBtn.position.x - resetBtnSize.width / 2 &&
                event.locationInWindow.x <= resetBtn.position.x + resetBtnSize.width / 2 &&
                event.locationInWindow.y >= resetBtn.position.y - resetBtnSize.height / 2 &&
                event.locationInWindow.y <= resetBtn.position.y + resetBtnSize.height / 2) {
                growing = false
                reset()
            }

        } else {
            growing = title.update(event)
            if (growing) {
                resetPlants()
            }
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        if (growing) {
            can.updateMouseUp(event: event)
        }
        mouseDragged = false
        checkMouse(event: event)
    }
    
    public override func mouseDragged(with event: NSEvent) {
        mouseDragged = true
        checkMouse(event: event)
        if (growing) {
            can.updateMouseDragged(event: event, collide: groundCollision || !mouseOnScreen)
        }
    }
    
    public func checkMouse(event: NSEvent) {
        mouseX = event.locationInWindow.x
        mouseY = event.locationInWindow.y
        if (mouseX >= 0 && mouseX <= screenSize.width &&
            mouseY >= 0 && mouseY <= screenSize.height) {
            mouseOnScreen = true
        } else {
            mouseOnScreen = false
        }
        groundCollision = collision(aLoc: CGPoint(x: 0, y: 0) ,
                                    aSize: ground.size,
                                    aAnchored: false,
                                    bLoc: CGPoint(x: mouseX, y: mouseY),
                                    bSize: CGSize(width: can.size.width, height: can.size.height),
                                    bAnchored: true)
    }
    
    //Reset from start
    public func reset() {
        //Removing nodes
        for node in plants {
            node.removeFromParent()
        }
        for node in drops {
            node.getNode().removeFromParent()
        }
        resetBtn.removeFromParent()
        addChild(title)
        growing = false
        can.node.position.x = size.width - 80
        can.node.position.y = ground.position.y + ground.size.height + 40
        
        plants = []
        watering = []
        drops = []
    }
    
    //Must call reset before hand
    public func resetPlants() {
        title.removeFromParent()
        addChild(resetBtn)
        
        //Creating water drop path
        let dropPath = CGMutablePath()
        dropPath.addLines(between: [CGPoint(x: 1, y: 3)])
        dropPath.addArc(center: CGPoint(x: 1, y: 1), radius: 1, startAngle: .pi / 8, endAngle: .pi - (.pi / 8), clockwise: true)
        dropPath.closeSubpath()
        
        //Creating water drop texture
        let dropShape = SKShapeNode(path: dropPath)
        dropShape.setScale(2)
        dropShape.fillColor = SKColor(red: 178.0/255.0, green: 229.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        dropShape.lineWidth = 0
        let dropTex = SKView().texture(from: dropShape)
        
        //Creating drops for water
        for i in 0...numDrops {
            drops.append(WaterDrop(texture: dropTex))
            drops[i].getNode().zPosition = 6
            addChild(drops[i].getNode())
        }
        
        //Creating seed texture
        let seedPath = CGMutablePath()
        seedPath.addLines(between: [CGPoint(x: 8, y: 24)])
        seedPath.addArc(center: CGPoint(x: 8, y: 8), radius: 8, startAngle: 1.5 * .pi, endAngle: .pi - (.pi / 8), clockwise: true)
        seedPath.closeSubpath()
        let seedShape = SKShapeNode(path: seedPath)
        seedShape.fillColor = SKColor(red: 105.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1.0)
        seedShape.lineWidth = 0.5
        seedShape.strokeColor = SKColor(red: 105.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1.0)
        let seedTexture = SKView().texture(from: seedShape)
        
        for i in 0...numPlants {
            //Random x calculation between certain ranges
            //Only overlap will be if randomized at edges of range
            let minRange = (Int((size.width - (size.width / 2.7))) / numPlants) * i
            let maxRange = (Int((size.width - (size.width / 2.7))) / numPlants) * (i + 1)
            var x = maxRange - minRange
            x = Int(arc4random_uniform(UInt32(x))) + minRange
            
            //Creating petal shape
            let scale: CGFloat = CGFloat(arc4random_uniform(40)) + 70
            let petalPath = CGMutablePath()
            petalPath.addArc(center: CGPoint(x: 1 * scale, y: 1  * scale), radius: 1 * scale, startAngle: .pi * 0.9, endAngle: .pi * 1.1, clockwise: false)
            petalPath.addArc(center: CGPoint(x: -0.9 * scale, y: 1  * scale), radius: 1 * scale, startAngle: .pi * 1.9, endAngle: .pi * 0.1, clockwise: false)
            petalPath.closeSubpath()
            let petalShape = SKShapeNode(path: petalPath)
            petalShape.lineWidth = 1
            petalShape.strokeColor = SKColor.gray
            petalShape.fillColor = SKColor.white
            let petalTex = SKView().texture(from: petalShape)
            
            let plant = Plant(size: size, seedTexture: seedTexture, petalTexture: petalTex, randomScale: (scale - 50) / 100)
            plant.position.x = CGFloat(x)
            plant.position.y = 0.25 * size.height - 10
            plant.zPosition = 5
            plants.append(plant)
            watering.append(false)
            addChild(plant)
        }
    }
    
    public func collision(aLoc: CGPoint, aSize: CGSize, aAnchored: Bool, bLoc: CGPoint, bSize: CGSize, bAnchored: Bool) -> Bool {
        //Adjust if anchored
        var newALoc = aLoc
        var newBLoc = bLoc
        if (aAnchored) {
            newALoc.x -= aSize.width / 2
            newALoc.y -= aSize.height / 2
        }
        if (bAnchored) {
            newBLoc.x -= bSize.width / 2
            newBLoc.y -= bSize.height / 2
        }
        
        //Calculating the distances between all points of hte object
        let dx1 = newBLoc.x - (newALoc.x + aSize.width) //bMinX - aMaxX
        let dy1 = newBLoc.y - (newALoc.y + aSize.height) //bMinY - aMaxY
        let dx2 = newALoc.x - (newBLoc.x + bSize.width) //aMinX - bMaxX
        let dy2 = newALoc.y - (newBLoc.y + bSize.height) //aMinY - bMaxY
        
        //Checking collision
        if (dx1 > 0 || dy1 > 0 || dx2 > 0 || dy2 > 0) {
            return false
        }
        return true
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if (growing) {
            //Check mouse and ground collision
            can.update()
            //Update all the water drops, if we need to reset the water drop, reset it
            for i in 0...numDrops {
                //If we are colliding with the ground
                collide = collision(aLoc: ground.position,
                                    aSize: ground.size,
                                    aAnchored: false,
                                    bLoc: drops[i].loc,
                                    bSize: CGSize(width: 1, height: 1),
                                    bAnchored: false)
                if (collide) { drops[i].hide() }
                
                //If we are colliding with a plant
                for j in 0...numPlants {
                    watering[j] = watering[j] || (drops[i].loc.x >= plants[j].position.x &&
                        drops[i].loc.x <= plants[j].position.x + 30 &&
                        drops[i].loc.y <= ground.size.height + 10)
                }
                
                //If we have to reset the drop
                if (!drops[i].update() &&
                    mouseDragged &&
                    can.rotaiton >= 0.25 * .pi) {
                    drops[i].reset(newCan: can.spoutLoc)
                }
            }
            
            //Updating all the plants
            for i in 0...numPlants {
                plants[i].update(isWatering: watering[i])
                watering[i] = false
            }
        }
    }
}
