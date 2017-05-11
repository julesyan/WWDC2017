import SpriteKit

public class Button: SKNode {
    let btn: SKSpriteNode
    let btnText: SKLabelNode
    
    init(size: CGSize, text: String) {
        //Creating the button
        let rec = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let buttonShape = SKShapeNode(rect: rec, cornerRadius: size.height / 4)
        buttonShape.lineWidth = 3
        buttonShape.fillColor = SKColor(red: 36.0/255.0, green: 94.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        buttonShape.strokeColor = SKColor(red: 160.0/255.0, green: 255.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        let btnTex = SKView().texture(from: buttonShape)
        btn = SKSpriteNode(texture: btnTex)
        
        //Button text
        btnText = SKLabelNode(text: text)
        btnText.fontName = "AmericanTypewriter-Bold"
        btnText.fontSize = size.height / 2
        btnText.fontColor = SKColor(red: 125.0/255.0, green: 200.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        btnText.position.y -= size.height / 7
        btnText.zPosition = 2
        btn.addChild(btnText)
        
        super.init()
        addChild(btn)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
