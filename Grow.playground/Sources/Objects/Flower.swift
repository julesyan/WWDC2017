import SpriteKit

public class Flower: SKNode {
    let bud: SKSpriteNode
    let budBottom: SKSpriteNode
    let middle: SKSpriteNode
    var rightTopPetals: [SKSpriteNode] = []
    var leftTopPetals: [SKSpriteNode] = []
    var rightBottomPetals: [SKSpriteNode] = []
    var leftBottomPetals: [SKSpriteNode] = []
    let numPetals = 3 //actual number is numPetals + 1
    let endRotationRight: CGFloat = .pi * -0.1
    let endRotationLeft: CGFloat = .pi * 0.1
    var counter: Double = 0
    let originalHeight: CGFloat
    var growing = true
    let red: CGFloat = CGFloat(arc4random_uniform(100)) + 155
    let blue: CGFloat = CGFloat(arc4random_uniform(100)) + 135
    let green: CGFloat = CGFloat(arc4random_uniform(66)) + 100
    
    
    public init(petalTexture: SKTexture?) {
        //Creating the growing bud, later becomes petal
        bud = SKSpriteNode(texture: petalTexture)
        bud.anchorPoint.x = 0.5
        bud.anchorPoint.y = 0
        bud.color = SKColor(red: 108.0/255.0, green: 182.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        bud.colorBlendFactor = 1
        originalHeight = bud.size.height
        bud.size.height = 0
        
        // Creating the bottom petal which mimics the top
        budBottom = SKSpriteNode(texture: petalTexture)
        budBottom.anchorPoint.x = 0.5
        budBottom.anchorPoint.y = 0
        budBottom.color = SKColor(red: red/255.0, green: (green + CGFloat(numPetals * 13))/255.0, blue: blue/255.0, alpha: 1.0)
        budBottom.colorBlendFactor = 1
        
        middle = SKSpriteNode(texture: petalTexture)
        middle.anchorPoint.x = 0.5
        middle.anchorPoint.y = 0.5
        middle.size.height = middle.size.height / 4
        middle.color = SKColor.yellow
        middle.alpha = 0
        middle.colorBlendFactor = 1
        middle.zRotation = .pi / 2
        
        super.init()
        addChild(bud)
        
        //Creating 3 petals on the right top
        for i in 0...numPetals {
            rightTopPetals.append(SKSpriteNode(texture: petalTexture))
            rightTopPetals[i].anchorPoint.x = 0.5
            rightTopPetals[i].anchorPoint.y = 0
            rightTopPetals[i].color = SKColor(red: red/255.0, green: (green - CGFloat(numPetals * 13) + CGFloat(i * 13))/255.0, blue: blue/255.0, alpha: 1.0)
            rightTopPetals[i].colorBlendFactor = 1
        }
        
        //Creating 3 petals on the right bottom
        for i in 0...numPetals {
            rightBottomPetals.append(SKSpriteNode(texture: petalTexture))
            rightBottomPetals[i].anchorPoint.x = 0.5
            rightBottomPetals[i].anchorPoint.y = 0
            rightBottomPetals[i].color = SKColor(red: red/255.0, green: (green + CGFloat((numPetals - i) * 13))/255.0, blue: blue/255.0, alpha: 1.0)
            rightBottomPetals[i].colorBlendFactor = 1
        }
        
        //Creating 3 petals on the left top
        for i in 0...numPetals {
            leftTopPetals.append(SKSpriteNode(texture: petalTexture))
            leftTopPetals[i].anchorPoint.x = 0.5
            leftTopPetals[i].anchorPoint.y = 0
            leftTopPetals[i].color = SKColor(red: red/255.0, green: (green - CGFloat(numPetals * 13) + CGFloat(i * 13))/255.0, blue: blue/255.0, alpha: 1.0)
            leftTopPetals[i].colorBlendFactor = 1
        }
        
        //Creating 3 petals on the left bottom
        for i in 0...numPetals {
            leftBottomPetals.append(SKSpriteNode(texture: petalTexture))
            leftBottomPetals[i].anchorPoint.x = 0.5
            leftBottomPetals[i].anchorPoint.y = 0
            leftBottomPetals[i].color = SKColor(red: red/255.0, green: (green + CGFloat((numPetals - i) * 13))/255.0, blue: blue/255.0, alpha: 1.0)
            leftBottomPetals[i].colorBlendFactor = 1
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(){
        // Grow the bud
        if (bud.size.height < originalHeight && growing) {
            bud.size.height += 0.2
            counter += 1
        } else if (bud.size.height >= originalHeight && growing){
            // We finished growing
            bud.size.height = originalHeight
            bud.color = SKColor(red: red/255.0, green: (green - CGFloat(numPetals * 11) )/255.0, blue: blue/255.0, alpha: 1.0)
            growing = false
            for i in 0...numPetals {
                addChild(rightTopPetals[i])
                addChild(leftTopPetals[i])
            }
            addChild(middle)
            for i in 0...numPetals {
                addChild(rightBottomPetals[numPetals - i])
                addChild(leftBottomPetals[numPetals - i])
            }
            addChild(budBottom)
        } else if (!growing) {
            //Slowly rotate each right top petal
            for i in 0...numPetals {
                if (rightTopPetals[i].zRotation > endRotationRight - (.pi * 0.1 * CGFloat(i))) {
                    rightTopPetals[i].zRotation -= 0.003 + (0.001 * CGFloat(i))
                    rightTopPetals[numPetals - i].size.height -= CGFloat(Double(i) * 0.04)
                    rightTopPetals[i].size.width += CGFloat(Double(i) * 0.02)
                }
            }
            
            //Slowly rotate each right bottom petal
            for i in 0...numPetals {
                if (rightBottomPetals[i].zRotation < endRotationLeft  + (.pi * 0.12 * CGFloat(i)) + (.pi * 0.18 * CGFloat(numPetals - i))) {
                    rightBottomPetals[i].zRotation += 0.0056 + (0.001 * CGFloat(i))
                    rightBottomPetals[i].size.height -= CGFloat(Double(numPetals - i) * 0.03)
                    rightBottomPetals[numPetals - i].size.width += CGFloat(Double(numPetals - i) * 0.02)
                }
            }
            
            //Slowly rotate each left top petal
            for i in 0...numPetals {
                if (leftTopPetals[i].zRotation < endRotationLeft + (.pi * 0.1 * CGFloat(i))) {
                    leftTopPetals[i].zRotation += 0.003 + (0.001 * CGFloat(i))
                    leftTopPetals[numPetals - i].size.height -= CGFloat(Double(i) * 0.04)
                    leftTopPetals[i].size.width += CGFloat(Double(i) * 0.02)
                }
            }
            
            //Slowly rotate each left bottom petal
            for i in 0...numPetals {
                if (leftBottomPetals[i].zRotation > endRotationRight - (.pi * 0.12 * CGFloat(i)) - (.pi * 0.18 * CGFloat(numPetals - i))) {
                    leftBottomPetals[i].zRotation -= 0.0056 + (0.001 * CGFloat(i))
                    leftBottomPetals[i].size.height -= CGFloat(Double(numPetals - i) * 0.03)
                    leftBottomPetals[numPetals - i].size.width += CGFloat(Double(numPetals - i) * 0.02)
                }
            }
            
            //Use the bud as a petal
            if (bud.size.height > originalHeight * 0.6) {
                bud.size.height -= 0.15
            }
            
            // The other middle petal
            if (budBottom.size.height > originalHeight * -0.2) {
                budBottom.size.height -= 0.15 * 1.5
            }
            
            // Setting the middle
            if (budBottom.size.height <= middle.size.width * -0.15) {
                middle.alpha += 0.1
            }
        }
    }
}
