//
//  DetailSettingsPresenter.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 30.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation

class DetailSettingsPresenter: DetailSettingsViewOutput {
    var interactor: DetailSettingsInteractorInput?
    weak var view: DetailSettingsViewInput?
    var router: DetailSettingsRouterInput?

    private var title: String
    var data: [LanguageCellViewModel] = [] {
        didSet {
            view?.updateTable(with: data)
        }
    }

    required init(with title: String) {
        self.title = title
    }

    func viewDidLoad() {
        view?.set(title: title)
        interactor?.viewDidLoad()
    }

    func languageChoosen(at indexPath: IndexPath) {
        data = data.map {
            LanguageCellViewModel(main: $0.main, additional: $0.additional, isChosen: false)
        }
        data[indexPath.row].isChosen = true
    }

    func backButtonPressed() {
        router?.closeModule()
    }
}

extension DetailSettingsPresenter: DetailSettingsInteractorOutput {
    func display(languages: [Language]) {
        var languagesCellModel: [LanguageCellViewModel] = []

        languages.forEach() {
            languagesCellModel.append(LanguageCellViewModel(main: $0.humanRepresentingNative, additional: $0.humanRepresentingEnglish, isChosen: false))
        }

        data = languagesCellModel
    }
}
