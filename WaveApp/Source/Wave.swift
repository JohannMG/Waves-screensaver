
import Cocoa
import ScreenSaver

@objc
class Wave: ScreenSaverView {
    
    let kPaddingLeftRightPercent: CGFloat = 0.1
    let kPaddingTopBottomPercent: CGFloat = 0.05
    
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
        self.animationTimeInterval = 1.0 / 10.0
        
        artBoxView = ArtBox(frame: CGRect.zero)
        artBoxView.isPreview = self.isPreview
        addSubview(artBoxView)
        needsDisplay = true
    }

//    override func startAnimation() {
//        super.startAnimation()
//    }
//
//    override func stopAnimation() {
//      super.stopAnimation()
//    }

	override func draw(_ rect: NSRect) {
        super.draw(rect)
        self.window?.backgroundColor = NSColor.black

        if !artBoxView.isSetup { artBoxSetup() }
	}
    
    func artBoxSetup(){
        let offset = floor((frame.width * kPaddingLeftRightPercent))
        artBoxView.frame = CGRect(x: offset,
                                  y: frame.height * kPaddingTopBottomPercent,
                                  width:floor(frame.width - offset - offset ),
                                  height:floor(frame.height - (2 * frame.height * kPaddingTopBottomPercent)))
        artBoxView.setup()
    }
    
    override func animateOneFrame(){
        artBoxView.animateOneFrame()
        needsDisplay = true
    }
	
	override var hasConfigureSheet: Bool {
		return false
	}

	
	override var configureSheet: NSWindow? {
		return nil
	}

}

