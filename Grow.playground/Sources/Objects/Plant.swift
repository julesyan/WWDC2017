import SpriteKit

public class Plant: SKNode {
    let stem: SKSpriteNode
    let leftSeed: SKSpriteNode
    let rightSeed: SKSpriteNode
    let root: SKSpriteNode
    var rootBranches: [SKSpriteNode]
    let growSpeed: CGFloat
    let flower: Flower
    var blooming = false
    
    init(size: CGSize, seedTexture: SKTexture?, petalTexture: SKTexture?, randomScale: CGFloat) {
        growSpeed = 0.002 + CGFloat(arc4random_uniform(100)) / 100 * 0.0005
        
        //Creating stem
        stem = SKSpriteNode()
        stem.size.width = 4
        stem.size.height = CGFloat(arc4random_uniform(UInt32(size.height / 2))) + CGFloat(size.height / 8)
        stem.size.height = (randomScale * size.height) //- CGFloat(size.height / 8)
        stem.color = SKColor(red: 108.0/255.0, green: 182.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        stem.anchorPoint = CGPoint(x: 0.5, y: 0)
        stem.yScale = 0
        
        //Creating root
        let rootLength = CGFloat(arc4random_uniform(UInt32(size.height / 9))) + CGFloat(size.height / 9)
        root = SKSpriteNode()
        root.size.width = 1
        root.size.height = rootLength
        root.yScale = 0
        root.anchorPoint = CGPoint(x: 0.5, y: 1)
        root.color = SKColor(red: 105.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1.0)
        
        rootBranches = [SKSpriteNode]()
        let minLength = size.height / 25
        let maxLength = size.height / 18
        for i in 0..<4 {
            rootBranches.append(SKSpriteNode())
            rootBranches[i].size.width = 1
            rootBranches[i].size.height = minLength + CGFloat(arc4random_uniform(100)) / 100 * (maxLength - minLength)
            rootBranches[i].yScale = 0
            rootBranches[i].anchorPoint = CGPoint(x: 0.5, y: 1)
            rootBranches[i].color = SKColor(red: 105.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1.0)
            rootBranches[i].position.y = (0.1 + 0.2 * CGFloat(i) + 0.2 * CGFloat(arc4random_uniform(100)) / 100) * -rootLength
            rootBranches[i].zRotation = (0.2 * .pi + 0.2 * .pi * CGFloat(arc4random_uniform(100)) / 100) * (i % 2 == 0 ? -1 : 1)
        }
        
        
        // Seed
        leftSeed = SKSpriteNode(texture: seedTexture)
        leftSeed.anchorPoint = CGPoint(x: 0.9, y: 1)
        leftSeed.alpha = 0
        
        rightSeed = SKSpriteNode(texture: seedTexture)
        rightSeed.anchorPoint = CGPoint(x: 0.9, y: 1)
        rightSeed.alpha = 0
        rightSeed.xScale = -1
        
        //Flower
        flower = Flower(petalTexture: petalTexture)
        flower.position = stem.position
        flower.position.y = stem.position.y + stem.size.height - 5
        let randomDirection: CGFloat = CGFloat(arc4random_uniform(3)) - 1 //from -1 to 1
        flower.zRotation = CGFloat(arc4random_uniform(20)) * 0.01 * .pi * randomDirection
        
        super.init()
        
        addChild(leftSeed)
        addChild(rightSeed)
        addChild(root)
        addChild(stem)
        addChild(flower)
        for branch in rootBranches {
            addChild(branch)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Returns true if we entered new stage
    public func update(isWatering: Bool) {
        // When we have watered the seed, every 10 seconds go to next stage
        if (isWatering) {
            
            if (rightSeed.zRotation == 0 && leftSeed.alpha != 1) {
                //We are starting to show the seed
                leftSeed.alpha += growSpeed + 0.01
                if leftSeed.alpha > 1 {
                    leftSeed.alpha = 1
                }
                rightSeed.alpha = leftSeed.alpha
            } else if rightSeed.zRotation < 0.15 * .pi {
                //We are starting to open the seed
                leftSeed.zRotation -= 0.0005 * .pi
                rightSeed.zRotation += 0.0005 * .pi
            } else if rightSeed.alpha >= 0.005 {
                // We are hiding the open seed
                leftSeed.alpha -= growSpeed
                rightSeed.alpha -= growSpeed
            } else if rightSeed.alpha < 0.005 && rightSeed.parent == self {
                // We are done with the seed
                leftSeed.alpha = 0
                rightSeed.alpha = 0
                leftSeed.removeFromParent()
                rightSeed.removeFromParent()
            }
            // We are now drawing the root
            if rightSeed.zRotation > 0.1 * .pi {
                if root.yScale < 1 {
                    root.yScale += growSpeed + 0.001
                    if root.yScale > 1 {
                        root.yScale = 1
                    }
                }
                for rootBranch in rootBranches {
                    if rootBranch.yScale < 1 && rootBranch.position.y > -root.size.height {
                        rootBranch.yScale += 1.5 * growSpeed
                    }
                }
            }
            
            //If we are now drawing the stem
            if (rightSeed.alpha <= 0.7 && root.yScale == 1 && stem.yScale < 1) {
                stem.yScale += growSpeed
                flower.position.y = stem.position.y + stem.size.height - 5
                if stem.yScale >= 1 {
                    stem.yScale = 1
                    blooming = true
                    flower.update()
                } else if (stem.yScale > 0.35) {
                    flower.update()
                }
            }
            
            // We are now blooming the flower
            if (blooming){
                flower.update()
            }
        }
    }
}
