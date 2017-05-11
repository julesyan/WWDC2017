import SpriteKit

public class Title: SKNode {
    let background = SKSpriteNode()
    let btnLoc: CGPoint
    let btnSize = CGSize(width: 200, height: 100)
    var start = false
    
    init(size: CGSize) {
        btnLoc = CGPoint(x: size.width / 2, y: size.height / 4)
        let startBtn = Button(size: btnSize, text: "Start")
        startBtn.zPosition = 1
        startBtn.position = btnLoc
        super.init()
        
        //Adding font
        let fontURL = Bundle.main.url(forResource: "CFPlantsandFlowers-Regular", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        
        //Creating background
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        background.color = SKColor(red: 58.0/255.0, green: 109.0/255.0, blue: 43.0/255.0, alpha: 1.0)
        background.alpha = 0.8
        
        //Creating title
        let titleText = SKLabelNode(text: "GROW")
        titleText.fontName = "CFPlantsandFlowers-Regular"
        titleText.position.x = size.width / 2
        titleText.position.y = ((size.height / 3) * 2)
        titleText.fontSize = 200
        titleText.fontColor = SKColor.white
        
        //Creating description
        var description = SKLabelNode(fontNamed: "AmericanTypewriter")
        description.text = "Drag the watering can around your garden"
        description.position.x = size.width / 2
        description.position.y = size.height / 2
        description.fontSize = 20
        background.addChild(description)
        description = SKLabelNode(fontNamed: "AmericanTypewriter")
        description.text = "and watch the magic happen."
        description.position.x = size.width / 2
        description.position.y = size.height / 2 - 30
        description.fontSize = 20
        background.addChild(description)
        description = SKLabelNode(fontNamed: "AmericanTypewriter")
        description.text = "By Julia Yan"
        description.position.x = size.width / 2
        description.position.y = 25
        description.fontSize = 15
        background.addChild(description)
        description = SKLabelNode(fontNamed: "AmericanTypewriter")
        description.text = "WWDC 2017"
        description.position.x = size.width / 2
        description.position.y = 5
        description.fontSize = 15
        background.addChild(description)
        
        
        addChild(background)
        background.addChild(titleText)
        background.addChild(startBtn)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ event: NSEvent) -> Bool{
        if (event.locationInWindow.x >= btnLoc.x - btnSize.width / 2 &&
            event.locationInWindow.x <= btnLoc.x + btnSize.width / 2 &&
            event.locationInWindow.y >= btnLoc.y - btnSize.height / 2 &&
            event.locationInWindow.y <= btnLoc.y + btnSize.height / 2) {
            start = true
        } else {
            start = false
        }
        return start
    }
}
