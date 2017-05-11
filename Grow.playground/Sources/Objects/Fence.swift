import SpriteKit

public class Fence: SKNode {
    var postNodes: [SKSpriteNode] = []
    var topPostNodes: [SKSpriteNode] = []
    var postNodesShade: [SKSpriteNode] = []
    var topPostNodesShade: [SKSpriteNode] = []
    
    var barSetOne: [SKSpriteNode] = [] //Bottom bar
    var barSetTwo: [SKSpriteNode] = []
    var barSetThree: [SKSpriteNode] = []
    var barSetFour: [SKSpriteNode] = [] //Top bar
    
    var barSetOneShade: [SKSpriteNode] = [] //Bottom bar
    var barSetTwoShade: [SKSpriteNode] = []
    var barSetThreeShade: [SKSpriteNode] = []
    var barSetFourShade: [SKSpriteNode] = [] //Top bar
    var temp = SKSpriteNode()
    let numPosts = 2
    
    
    public init(size: CGSize, groundSize: CGSize) {
        super.init()
        
        //Creating the posts
        for i in 0...numPosts {
            postNodesShade.append(SKSpriteNode())
            postNodesShade[i].anchorPoint.x = 0
            postNodesShade[i].anchorPoint.y = 0
            postNodesShade[i].position.x = ((size.width + 100) / CGFloat(numPosts)) * CGFloat(i)
            postNodesShade[i].position.y = groundSize.height
            postNodesShade[i].color = SKColor(red: 77.0/255.0, green: 50.0/255.0, blue: 16.0/255.0, alpha: 1.0)
            postNodesShade[i].size.height = size.height * 0.7
            postNodesShade[i].size.width = 50
            addChild(postNodesShade[i])
            
            postNodes.append(SKSpriteNode())
            postNodes[i].anchorPoint = postNodesShade[i].anchorPoint
            postNodes[i].position.x = postNodesShade[i].position.x
            postNodes[i].position.y = postNodesShade[i].position.y
            postNodes[i].color = SKColor(red: 108.0/255.0, green: 64.0/255.0, blue: 5.0/255.0, alpha: 1.0)
            postNodes[i].size.height = postNodesShade[i].size.height
            postNodes[i].size.width = 40
            postNodes[i].zPosition = 1
            addChild(postNodes[i])
            
            topPostNodes.append(SKSpriteNode())
            topPostNodes[i].color = postNodes[i].color
            topPostNodes[i].size.height = sqrt(pow(postNodes[i].size.width, 2) / 2)
            topPostNodes[i].size.width = topPostNodes[i].size.height
            topPostNodes[i].position.x = postNodes[i].position.x + postNodes[i].size.width / 2
            topPostNodes[i].position.y = postNodes[i].position.y + postNodes[i].size.height
            topPostNodes[i].zRotation = .pi / 4
            addChild(topPostNodes[i])
            
            topPostNodesShade.append(SKSpriteNode())
            topPostNodesShade[i].color = postNodesShade[i].color
            topPostNodesShade[i].size.height = sqrt(pow(postNodesShade[i].size.width, 2) / 2)
            topPostNodesShade[i].size.width = topPostNodesShade[i].size.height
            topPostNodesShade[i].position.x = postNodesShade[i].position.x + postNodesShade[i].size.width / 2
            topPostNodesShade[i].position.y = postNodes[i].position.y + postNodes[i].size.height
            topPostNodesShade[i].zRotation = .pi / 4
            topPostNodesShade[i].zPosition = -1
            addChild(topPostNodesShade[i])
        }
        
        for i in 0...numPosts - 1 {
            barSetOne.append(SKSpriteNode())
            barSetOne[i].size.width = (postNodes[i].position.x - postNodes[i + 1].position.x)
            barSetOne[i].size.height = 30
            barSetOne[i].position.x = postNodes[i + 1].position.x + (barSetOne[i].size.width / 2) + postNodes[i].size.width
            barSetOne[i].position.y = groundSize.height + 50
            barSetOne[i].color = SKColor(red: 136.0/255.0, green: 88.0/255.0, blue: 29.0/255.0, alpha: 1.0)
            //barSetOne[i].zPosition = -1
            addChild(barSetOne[i])
            
            barSetTwo.append(SKSpriteNode())
            barSetTwo[i].size.width = barSetOne[i].size.width
            barSetTwo[i].size.height = barSetOne[i].size.height
            barSetTwo[i].position.x = barSetOne[i].position.x
            barSetTwo[i].position.y = barSetOne[i].position.y + 100
            barSetTwo[i].color = barSetOne[i].color
            barSetTwo[i].zPosition = barSetOne[i].zPosition
            addChild(barSetTwo[i])
            
            barSetThree.append(SKSpriteNode())
            barSetThree[i].size.width = barSetOne[i].size.width
            barSetThree[i].size.height = barSetOne[i].size.height
            barSetThree[i].position.x = barSetOne[i].position.x
            barSetThree[i].position.y = barSetTwo[i].position.y + 100
            barSetThree[i].color = barSetOne[i].color
            barSetThree[i].zPosition = barSetOne[i].zPosition
            addChild(barSetThree[i])
            
            barSetFour.append(SKSpriteNode())
            barSetFour[i].size.width = barSetOne[i].size.width
            barSetFour[i].size.height = barSetOne[i].size.height
            barSetFour[i].position.x = barSetOne[i].position.x
            barSetFour[i].position.y = barSetThree[i].position.y + 100
            barSetFour[i].color = barSetOne[i].color
            barSetFour[i].zPosition = barSetOne[i].zPosition
            addChild(barSetFour[i])
        }
        
        for i in 0...numPosts - 1 {
            barSetOneShade.append(SKSpriteNode())
            barSetOneShade[i].size.width = (postNodes[i].position.x - postNodes[i + 1].position.x)
            barSetOneShade[i].size.height = 30
            barSetOneShade[i].position.x = postNodes[i + 1].position.x + (barSetOneShade[i].size.width / 2) + postNodes[i].size.width
            barSetOneShade[i].position.y = barSetOne[i].position.y + 7
            barSetOneShade[i].color = postNodesShade[i].color
            barSetOneShade[i].zPosition = -1
            addChild(barSetOneShade[i])
            
            barSetTwoShade.append(SKSpriteNode())
            barSetTwoShade[i].size.width = barSetOneShade[i].size.width
            barSetTwoShade[i].size.height = barSetOneShade[i].size.height
            barSetTwoShade[i].position.x = barSetOneShade[i].position.x
            barSetTwoShade[i].position.y = barSetOneShade[i].position.y + 100
            barSetTwoShade[i].color = barSetOneShade[i].color
            barSetTwoShade[i].zPosition = barSetOneShade[i].zPosition
            addChild(barSetTwoShade[i])
            
            barSetThreeShade.append(SKSpriteNode())
            barSetThreeShade[i].size.width = barSetOneShade[i].size.width
            barSetThreeShade[i].size.height = barSetOneShade[i].size.height
            barSetThreeShade[i].position.x = barSetOneShade[i].position.x
            barSetThreeShade[i].position.y = barSetTwoShade[i].position.y + 100
            barSetThreeShade[i].color = barSetOneShade[i].color
            barSetThreeShade[i].zPosition = barSetOneShade[i].zPosition
            addChild(barSetThreeShade[i])
            
            barSetFourShade.append(SKSpriteNode())
            barSetFourShade[i].size.width = barSetOneShade[i].size.width
            barSetFourShade[i].size.height = barSetOneShade[i].size.height
            barSetFourShade[i].position.x = barSetOneShade[i].position.x
            barSetFourShade[i].position.y = barSetThreeShade[i].position.y + 100
            barSetFourShade[i].color = barSetOneShade[i].color
            barSetFourShade[i].zPosition = barSetOneShade[i].zPosition
            addChild(barSetFourShade[i])
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

