import ZoomTransitioning

class NavigationController: UINavigationController {
    
    private let zoomNavigationControllerDelegate = ZoomNavigationControllerDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = zoomNavigationControllerDelegate
    }
}
