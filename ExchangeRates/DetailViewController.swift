//
//  DetailViewController.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 01.12.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private var presenter: DetailPresenter!
    var data : BaseModelInterface = BaseModel() as BaseModelInterface
    var filter: String!
    var _view: DetailView { return self.view as! DetailView }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = DetailPresenter(view: _view, model: data)
        presenter.delegate = self
        presenter.requestData(filter)
    }
}

extension DetailViewController: DetailPresenterDelegate {
    func something() {
        // something
    }
}
