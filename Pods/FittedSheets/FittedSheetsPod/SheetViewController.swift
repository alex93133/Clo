//
//  SheetViewController.swift
//  FittedSheets
//
//  Created by Gordon Tucker on 8/23/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

open class SheetViewController: UIViewController {
    // MARK: - Public Properties

    public private(set) var childViewController: UIViewController!

    public let containerView = UIView()
    /// The view that can be pulled to resize a sheeet. This includes the background. To change the color of the bar, use `handleView` instead
    public let pullBarView = UIView()
    public let handleView = UIView()
    public var handleColor: UIColor = UIColor(white: 0.868, alpha: 1) {
        didSet {
            handleView.backgroundColor = handleColor
        }
    }

    public var handleSize: CGSize = CGSize(width: 50, height: 6)
    public var handleTopEdgeInset: CGFloat = 9
    public var handleBottomEdgeInset: CGFloat = 9

    /// If true, tapping on the overlay above the sheet will dismiss the sheet view controller
    public var dismissOnBackgroundTap: Bool = true

    /// If true, sheet may be dismissed by panning down
    public var dismissOnPan: Bool = true

    /// If false, the pan gesture to dismiss the sheet will not be recognized when it conflicts with a UIControl
    public var shouldRecognizePanGestureWithUIControls: Bool = false

    /// If true, sheet's dismiss view will be generated, otherwise sheet remains fixed and will need to be dismissed programatically
    public var dismissable: Bool = true

    public var extendBackgroundBehindHandle: Bool = false {
        didSet {
            guard isViewLoaded else { return }
            pullBarView.backgroundColor = extendBackgroundBehindHandle ? childViewController.view.backgroundColor : UIColor.clear
            updateRoundedCorners()
        }
    }

    private var firstPanPoint: CGPoint = CGPoint.zero

    /// If true, the child view controller will be inset to account for the bottom safe area. This must be set before the sheet view controller loads for it to function properly
    public var adjustForBottomSafeArea: Bool = false

    /// If true, the bottom safe area will have a blur effect over it. This must be set before the sheet view controller loads for it to function properly
    public var blurBottomSafeArea: Bool = true

    /// Adjust corner radius for the top corners. Only available for iOS 11 and above
    public var topCornersRadius: CGFloat = 3 {
        didSet {
            guard isViewLoaded else { return }
            self.updateRoundedCorners()
        }
    }

    /// The color of the overlay above the sheet. Default is a transparent black.
    public var overlay: UIColor = UIColor(white: 0, alpha: 0.7) {
        didSet {
            if isViewLoaded, view?.window != nil {
                view.backgroundColor = overlay
            }
        }
    }

    public var willDismiss: ((SheetViewController) -> Void)?
    public var didDismiss: ((SheetViewController) -> Void)?

    // MARK: - Private properties

    /// The current preferred container size
    private var containerSize: SheetSize = .fixed(300)
    /// The current actual container size
    private var actualContainerSize: SheetSize = .fixed(300)
    /// The array of sizes we are trying to pin to when resizing the sheet. To set, use `setSizes` function
    private var orderedSheetSizes: [SheetSize] = [.fixed(300), .fullScreen]

    private var panGestureRecognizer: InitialTouchPanGestureRecognizer!
    /// The child view controller's scroll view we are watching so we can override the pull down/up to work on the sheet when needed
    private weak var childScrollView: UIScrollView?

    private var containerHeightConstraint: NSLayoutConstraint!
    private var containerBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0

    private var safeAreaInsets: UIEdgeInsets {
        var inserts = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            inserts = UIApplication.shared.keyWindow?.safeAreaInsets ?? inserts
        }
        inserts.top = max(inserts.top, 20)
        return inserts
    }

    // MARK: - Functions

    @available(*, deprecated, message: "Use the init(controller:, sizes:) initializer")
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    /// Initialize the sheet view controller with a child. This is the only initializer that will function properly.
    public convenience init(controller: UIViewController, sizes: [SheetSize] = []) {
        self.init(nibName: nil, bundle: nil)
        childViewController = controller
        if sizes.count > 0 {
            setSizes(sizes, animated: false)
        }
        modalPresentationStyle = .overFullScreen
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        if childViewController == nil {
            fatalError("SheetViewController requires a child view controller")
        }

        view.backgroundColor = UIColor.clear
        setUpContainerView()

        if dismissable {
            setUpDismissView()
        }

        let panGestureRecognizer = InitialTouchPanGestureRecognizer(target: self, action: #selector(panned(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        self.panGestureRecognizer = panGestureRecognizer

        setUpPullBarView()
        setUpChildViewController()
        updateRoundedCorners()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShown(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDismissed(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let self = self else { return }
            self.view.backgroundColor = self.overlay
            self.containerView.transform = CGAffineTransform.identity
            self.actualContainerSize = .fixed(self.containerView.frame.height)
        }, completion: nil)
    }

    /// Change the sizes the sheet should try to pin to
    public func setSizes(_ sizes: [SheetSize], animated: Bool = true) {
        guard sizes.count > 0 else {
            return
        }
        orderedSheetSizes = sizes.sorted(by: { self.height(for: $0) < self.height(for: $1) })

        resize(to: sizes[0], animated: animated)
    }

    public func resize(to size: SheetSize, animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
                guard let self = self, let constraint = self.containerHeightConstraint else { return }
                constraint.constant = self.height(for: size)
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            containerHeightConstraint?.constant = height(for: size)
        }
        containerSize = size
        actualContainerSize = size
    }

    /// Because iOS 10 doesn't support the better rounded corners implementation, we need to fake it here. This can be deleted once iOS 10 support is dropped.
    private func updateLegacyRoundedCorners() {
        if #available(iOS 11.0, *) {
            self.childViewController.view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // iOS 10 doesn't have the better rounded corner feature so we need to fake it
            let path = UIBezierPath(roundedRect: childViewController.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            childViewController.view.layer.mask = maskLayer
        }
    }

    private func setUpOverlay() {
        let overlay = UIView(frame: CGRect.zero)
        overlay.backgroundColor = self.overlay
        view.addSubview(overlay) { subview in
            subview.edges.pinToSuperview()
        }
    }

    private func setUpContainerView() {
        view.addSubview(containerView) { subview in
            subview.edges(.left, .right).pinToSuperview()
            self.containerBottomConstraint = subview.bottom.pinToSuperview()
            subview.top.pinToSuperview(inset: self.safeAreaInsets.top + 20, relation: .greaterThanOrEqual)
            self.containerHeightConstraint = subview.height.set(self.height(for: self.containerSize))
            self.containerHeightConstraint.priority = UILayoutPriority(900)
        }
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor.clear
        containerView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)

        view.addSubview(UIView(frame: CGRect.zero)) { subview in
            subview.edges(.left, .right, .bottom).pinToSuperview()
            subview.height.set(0).priority = UILayoutPriority(100)
            subview.top.align(with: self.containerView.al.bottom)
            subview.base.backgroundColor = UIColor.white
        }
    }

    private func setUpChildViewController() {
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        let bottomInset = safeAreaInsets.bottom
        containerView.addSubview(childViewController.view) { subview in
            subview.edges(.left, .right).pinToSuperview()
            if self.adjustForBottomSafeArea {
                subview.bottom.pinToSuperview(inset: bottomInset, relation: .equal)
            } else {
                subview.bottom.pinToSuperview()
            }
            subview.top.align(with: self.pullBarView.al.bottom)
        }

        childViewController.view.layer.masksToBounds = true

        childViewController.didMove(toParent: self)

        if adjustForBottomSafeArea, bottomInset > 0 {
            // Add white background over bottom bar
            containerView.addSubview(UIView(frame: CGRect.zero)) { subview in
                subview.base.backgroundColor = UIColor.white
                subview.edges(.bottom, .left, .right).pinToSuperview()
                subview.height.set(bottomInset)
            }
        }

        if blurBottomSafeArea, bottomInset > 0 {
            view.addSubview(UIVisualEffectView(effect: UIBlurEffect(style: .light))) { subview in
                subview.edges(.bottom, .left, .right).pinToSuperview()
                subview.height.set(bottomInset)
            }
        }
    }

    /// Updates which view has rounded corners (only supported on iOS 11)
    private func updateRoundedCorners() {
        if #available(iOS 11.0, *) {
            let controllerWithRoundedCorners = extendBackgroundBehindHandle ? self.containerView : self.childViewController.view
            let controllerWithoutRoundedCorners = extendBackgroundBehindHandle ? self.childViewController.view : self.containerView
            controllerWithRoundedCorners?.layer.maskedCorners = self.topCornersRadius > 0 ? [.layerMaxXMinYCorner, .layerMinXMinYCorner] : []
            controllerWithRoundedCorners?.layer.cornerRadius = self.topCornersRadius
            controllerWithoutRoundedCorners?.layer.maskedCorners = []
            controllerWithoutRoundedCorners?.layer.cornerRadius = 0
        }
    }

    private func setUpDismissView() {
        let dismissAreaView = UIView(frame: CGRect.zero)
        view.addSubview(dismissAreaView, containerView) { dismissAreaView, containerView in
            dismissAreaView.edges(.top, .left, .right).pinToSuperview()
            dismissAreaView.bottom.align(with: containerView.top)
        }
        dismissAreaView.backgroundColor = UIColor.clear
        dismissAreaView.isUserInteractionEnabled = true

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissTapped))
        dismissAreaView.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setUpPullBarView() {
        containerView.addSubview(pullBarView) { subview in
            subview.edges(.top, .left, .right).pinToSuperview()
        }

        pullBarView.addSubview(handleView) { subview in
            subview.top.pinToSuperview(inset: handleTopEdgeInset, relation: .equal)
            subview.bottom.pinToSuperview(inset: handleBottomEdgeInset, relation: .equal)
            subview.centerX.alignWithSuperview()
            subview.size.set(handleSize)
        }
        pullBarView.layer.masksToBounds = true
        pullBarView.backgroundColor = extendBackgroundBehindHandle ? childViewController.view.backgroundColor : UIColor.clear

        handleView.layer.cornerRadius = handleSize.height / 2.0
        handleView.layer.masksToBounds = true
        handleView.backgroundColor = handleColor

        pullBarView.isAccessibilityElement = true
        pullBarView.accessibilityLabel = "Overlay controller"
        pullBarView.accessibilityHint = "Double tap to dismiss card overlay"
        pullBarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissTapped)))
    }

    @objc func dismissTapped() {
        guard dismissOnBackgroundTap else { return }
        closeSheet()
    }

    /// Animates the sheet to the closed state and then dismisses the view controller
    public func closeSheet(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: { [weak self] in
            self?.containerView.transform = CGAffineTransform(translationX: 0, y: self?.containerView.frame.height ?? 0)
            self?.view.backgroundColor = UIColor.clear
        }, completion: { [weak self] _ in
            self?.dismiss(animated: false, completion: completion)
        })
    }

    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        willDismiss?(self)
        super.dismiss(animated: flag) {
            self.didDismiss?(self)
            completion?()
        }
    }

    @objc func panned(_ gesture: UIPanGestureRecognizer) {
        let point = gesture.translation(in: gesture.view?.superview)
        if gesture.state == .began {
            firstPanPoint = point
            actualContainerSize = .fixed(containerView.frame.height)
        }

        let minHeight = min(height(for: actualContainerSize), height(for: orderedSheetSizes.first))
        let maxHeight = max(height(for: actualContainerSize), height(for: orderedSheetSizes.last))

        var newHeight = max(0, height(for: actualContainerSize) + (firstPanPoint.y - point.y))
        var offset: CGFloat = 0
        if newHeight < minHeight {
            offset = minHeight - newHeight
            newHeight = minHeight
        }
        if newHeight > maxHeight {
            newHeight = maxHeight
        }

        if gesture.state == .cancelled || gesture.state == .failed {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.containerView.transform = CGAffineTransform.identity
                self.containerHeightConstraint.constant = self.height(for: self.containerSize)
            }, completion: nil)
        } else if gesture.state == .ended {
            let velocity = (0.2 * gesture.velocity(in: view).y)
            var finalHeight = newHeight - offset - velocity
            if velocity > 500 {
                // They swiped hard, always just close the sheet when they do
                finalHeight = -1
            }

            let animationDuration = TimeInterval(abs(velocity * 0.0002) + 0.2)

            guard finalHeight >= (minHeight / 2) || !dismissOnPan || !dismissable else {
                // Dismiss
                UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
                    self?.containerView.transform = CGAffineTransform(translationX: 0, y: self?.containerView.frame.height ?? 0)
                    self?.view.backgroundColor = UIColor.clear
                }, completion: { [weak self] _ in
                    self?.dismiss(animated: false, completion: nil)
                })
                return
            }

            var newSize = containerSize
            if point.y < 0 {
                // We need to move to the next larger one
                newSize = orderedSheetSizes.last ?? containerSize
                for size in orderedSheetSizes.reversed() {
                    if finalHeight < height(for: size) {
                        newSize = size
                    } else {
                        break
                    }
                }
            } else {
                // We need to move to the next smaller one
                newSize = orderedSheetSizes.first ?? containerSize
                for size in orderedSheetSizes {
                    if finalHeight > height(for: size) {
                        newSize = size
                    } else {
                        break
                    }
                }
            }
            containerSize = newSize

            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: {
                self.containerView.transform = CGAffineTransform.identity
                self.containerHeightConstraint.constant = self.height(for: newSize)
                self.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.actualContainerSize = .fixed(self.containerView.frame.height)
            })
        } else {
            Constraints(for: containerView) { _ in
                self.containerHeightConstraint.constant = newHeight
            }

            if offset > 0 {
                containerView.transform = CGAffineTransform(translationX: 0, y: offset)
            } else {
                containerView.transform = CGAffineTransform.identity
            }
        }
    }

    @objc func keyboardShown(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo, let keyboardRect: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        let windowRect = view.convert(view.bounds, to: nil)
        let actualHeight = windowRect.maxY - keyboardRect.origin.y
        adjustForKeyboard(height: actualHeight, from: notification)
    }

    @objc func keyboardDismissed(_ notification: Notification) {
        adjustForKeyboard(height: 0, from: notification)
    }

    private func adjustForKeyboard(height: CGFloat, from notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo else { return }
        keyboardHeight = height

        let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

        UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
            self.containerBottomConstraint.constant = min(0, -height + (self.adjustForBottomSafeArea ? self.safeAreaInsets.bottom : 0))
            // Tell our child view it needs to layout again to prevent the navigation bar from moving to the wrong spot if in a UINavigationController
            self.childViewController.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    /// Handle a scroll view in the child view controller by watching for the offset for the scrollview and taking priority when at the top (so pulling up/down can grow/shrink the sheet instead of bouncing the child's scroll view)
    public func handleScrollView(_ scrollView: UIScrollView) {
        scrollView.panGestureRecognizer.require(toFail: panGestureRecognizer)
        childScrollView = scrollView
    }

    private func height(for size: SheetSize?) -> CGFloat {
        guard let size = size else { return 0 }
        switch size {
        case let .fixed(height):
            return height
        case .fullScreen:
            let insets = safeAreaInsets
            return UIScreen.main.bounds.height - insets.top - 20
        case .halfScreen:
            return (UIScreen.main.bounds.height) / 2 + 24
        }
    }
}

extension SheetViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Allowing gesture recognition on a UIControl seems to prevent its events from firing properly sometimes
        if !shouldRecognizePanGestureWithUIControls {
            if let view = touch.view {
                return !(view is UIControl)
            }
        }
        return true
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? InitialTouchPanGestureRecognizer, let childScrollView = self.childScrollView, let point = panGestureRecognizer.initialTouchLocation else { return true }

        let pointInChildScrollView = view.convert(point, to: childScrollView).y - childScrollView.contentOffset.y

        let velocity = panGestureRecognizer.velocity(in: panGestureRecognizer.view?.superview)
        guard pointInChildScrollView > 0, pointInChildScrollView < childScrollView.bounds.height else {
            if keyboardHeight > 0 {
                childScrollView.endEditing(true)
            }
            return true
        }
        let topInset = childScrollView.contentInset.top
        guard abs(velocity.y) > abs(velocity.x), childScrollView.contentOffset.y == -topInset else { return false }

        if velocity.y < 0 {
            let containerHeight = height(for: containerSize)
            return height(for: orderedSheetSizes.last) > containerHeight && containerHeight < height(for: SheetSize.fullScreen)
        } else {
            return true
        }
    }
}
