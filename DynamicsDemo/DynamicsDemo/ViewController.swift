//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Дмитрий Константинов on 07.04.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Init
    private var square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    private let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))

    lazy private var animator: UIDynamicAnimator = { return UIDynamicAnimator(referenceView: view) }()
    lazy private var gravity: UIGravityBehavior = { return UIGravityBehavior(items: [square]) }()
    lazy private var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior(items: [square])
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, for: UIBezierPath(rect: barrier.frame))

//        // print method
//        collision.action = {
//            print("\(NSCoder.string(for: self.square.transform)) \(NSCoder.string(for: self.square.center))")
//        }

//        // produced image with trails
//        var updateCount = 0
//        collision.action = {
//            if (updateCount % 3 == 0 ) {
//                let outline = UIView (frame: self.square.bounds)
//                outline.transform = self.square.transform
//                outline.center = self.square.center
//
//                outline.alpha = 0.5
//                outline.backgroundColor = .clear
//                outline.layer.borderColor = self.square.layer.presentation()?.backgroundColor
//                outline.layer.borderWidth = 1.0
//                self.view.addSubview(outline)
//            }
//            updateCount += 1
//        }

        return collision
    }()

//    private var firstContact = false

    var snap: UISnapBehavior!


    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAnimator()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }

        guard let touch = touches.first else { return }
        snap = UISnapBehavior(item: square, snapTo: touch.location(in: view))
        animator.addBehavior(snap)

        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            DispatchQueue.main.async {
                self.animator.removeBehavior(self.snap)
            }
        }
    }

    private func setupViews() {
        square.backgroundColor = .gray
        square.layer.cornerRadius = 5
        square.layer.masksToBounds = true
        view.addSubview(square)

        barrier.backgroundColor = .red
        barrier.layer.cornerRadius = 5
        barrier.layer.masksToBounds = true
        view.addSubview(barrier)
    }

    private func setupAnimator() {
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        collision.collisionDelegate = self

        setupItemBehaivor(item: square, 0.6)
    }

    private func setupItemBehaivor(item: UIDynamicItem, _ elasticity: CGFloat) {
        let itemBehaviour = UIDynamicItemBehavior(items: [item])

        var localElasticity: CGFloat = 0
        elasticity > 1 ? localElasticity = 1 : nil
        elasticity < 0 ? localElasticity = 0 : nil

        itemBehaviour.elasticity = localElasticity
//        itemBehaviour.friction = 0.4
//        itemBehaviour.resistance = 10
//        itemBehaviour.angularResistance = 3
//        itemBehaviour.allowsRotation = false
        animator.addBehavior(itemBehaviour)
    }
}

extension ViewController: UICollisionBehaviorDelegate {

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("Boundary contact occurred - \(String(describing: identifier))")

        guard let collidingView = item as? UIView else { return }
        collidingView.backgroundColor = .yellow
        UIView.animate(withDuration: 0.3) {
            collidingView.backgroundColor = .gray
        }

//        //add second square with connection to first square
//        if (!firstContact) {
//            firstContact = true

//            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
//            square.backgroundColor = .gray
//            view.addSubview(square)
//
//            collision.addItem(square)
//            gravity.addItem(square)
//
//            let attach = UIAttachmentBehavior(item: collidingView, attachedTo:square)
//            animator.addBehavior(attach)
//        }
    }
}
