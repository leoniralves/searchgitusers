//
//  HomeViewController.swift
//  SearchGitUsersMVC
//
//  Created by Leonir Alves Deolindo on 07/03/20.
//  Copyright © 2020 Leonir Deolindo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

