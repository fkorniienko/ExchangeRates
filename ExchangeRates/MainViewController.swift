//
//  MainViewController.swift
//  ExchangeRates
//
//  Created by Fedir Korniienko on 29.11.17.
//  Copyright © 2017 Fedir. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NavigationTitleDelegate {
    
    private var presenter: MainPresenter!
    var _view: MainViewInterface { return self.view as! MainViewInterface }
    let model: BaseModelInterface = BaseModel() as BaseModelInterface
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainPresenter.init(view: _view, model: model)
        presenter.delegate = self
        presenter.model.navigationDelegate = self
        presenter.requestData()
    }
    
    func changeTitle(title: String){
        self.title = title
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

// MARK: - PresenterDelegate
extension MainViewController: MainPresenterDelegate {
    func pushExchangeView(filterStr: String) {
    if let destinationVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIds.DetailViewController) as? DetailViewController {
        destinationVC.filter = filterStr
        self.navigationController?.pushViewController(destinationVC, animated: true)
        }
        return
    }
}
