//
//  GetFollowersViewController.swift
//  GitHub
//
//  Created by José Victor Pereira Costa on 26/02/20.
//  Copyright © 2020 José Victor Pereira Costa. All rights reserved.
//

import UIKit
import Commons

protocol GetFollowersService {
    func singUp(with user: String)
}

class GetFollowersViewController: UIViewController {
    
    // MARK: - Properties
    
    var service: GetFollowersService?
    
    lazy var onGetFollowersButtonTapped: ((String) -> Void) = { [unowned self] userName in
        self.service?.singUp(with: userName)
    }
    
    lazy var getFollowersView: GetFollowersView = {
        let view = GetFollowersView()
        view.getFollowersButtonTapped = onGetFollowersButtonTapped
        return view
    }()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = getFollowersView
    }
    
}

