
import Cocoa
import ScreenSaver

@objc
class Wave: ScreenSaverView {
    
	var image: NSImage?

	override init?(frame: NSRect, isPreview: Bool) {
		super.init(frame: frame, isPreview: isPreview)
		loadImage()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		loadImage()
		fatalError("init(coder:) has not been implemented")
	}

	override func startAnimation() {
	  super.startAnimation()
	}

	override func stopAnimation() {
	  super.stopAnimation()
	}

	override func draw(_ rect: NSRect) {
//        super.draw(rect)
		/*
		[[NSColor redColor] set];
		NSRectFill([self bounds]);
		*/
//        NSColor.red.set()
//        self.window?.backgroundColor = NSColor.gray
		
//        if let image = image {
//          let point = CGPoint(x: (frame.size.width - image.size.width) / 2, y: (frame.size.height - image.size.height) / 2)
//          image.draw(at: point, from: NSZeroRect, operation: .sourceOver, fraction: 1)
//        }
        if let context = NSGraphicsContext.current?.cgContext {
            drawLine(inContext: context, inRect: rect)
        }
        
	}
    
    func drawLine(inContext context: CGContext, inRect rect: CGRect){
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: 40, y: 40))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 50, y: 50))
        
        path.closeSubpath()
        
        context.setLineWidth(2.0)
        context.setFillColor(CGColor.white)
        context.setStrokeColor(CGColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0))
        
        context.addPath(path)
        context.drawPath(using: .stroke)
        
    }

	func loadImage() {
		DispatchQueue.global(qos: .default).async {
		  let url = URL(string: "https://raw.githubusercontent.com/yomajkel/ImageStream/added-swift-image/assets/swift.png")
		  let data = try? Data(contentsOf: url! as URL)
		  if let data = data {
            self.image = NSImage(data: data)
            DispatchQueue.main.async { self.needsDisplay = true }
		  }
		}
	}
	
	override var hasConfigureSheet: Bool {
		return false
	}

	override func animateOneFrame() {

	}
	
	override var configureSheet: NSWindow? {
		return nil
	}

}

