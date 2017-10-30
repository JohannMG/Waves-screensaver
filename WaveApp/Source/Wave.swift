
import Cocoa
import ScreenSaver

@objc
class Wave: ScreenSaverView {
    
    let kPaddingLeftRightPercent: CGFloat = 0.1
    
    var artBoxView: ArtBox!
    
	override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
        setUp()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		fatalError("init(coder:) has not been implemented")
	}
    
    func setUp(){
        
        self.animationTimeInterval = 1.0 / 30.0
        
        artBoxView = ArtBox(frame: CGRect.zero)
        addSubview(artBoxView)
        needsDisplay = true
    }

	override func startAnimation() {
        super.startAnimation()
        
	}

	override func stopAnimation() {
	  super.stopAnimation()
	}

	override func draw(_ rect: NSRect) {
        super.draw(rect)
        self.window?.backgroundColor = NSColor.black

        if let context = NSGraphicsContext.current?.cgContext {
            context.saveGState()
            drawLine(inContext: context, inRect: frame)
        }
        
        let offset = floor((frame.width * kPaddingLeftRightPercent))
        artBoxView.frame = CGRect(x: offset,
                                  y: 0,
                                  width: floor(frame.width - offset - offset ),
                                  height: frame.height)
        artBoxView.setup()
   
	}
    
    override func animateOneFrame(){

        artBoxView.animateOneFrame()
        needsDisplay = true
    }
    
    func drawLine(inContext context: CGContext, inRect rect: CGRect){
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 40, y: 40))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.closeSubpath()
        
        context.setLineWidth(2.0)
        context.setFillColor(CGColor.white)
        context.setStrokeColor(CGColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0))
        
        context.addPath(path)
        context.drawPath(using: .stroke)
        
    }
	
	override var hasConfigureSheet: Bool {
		return false
	}

	
	override var configureSheet: NSWindow? {
		return nil
	}

}

