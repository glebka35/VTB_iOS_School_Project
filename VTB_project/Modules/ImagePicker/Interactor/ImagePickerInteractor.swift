//
//  ImagePickerInteractor.swift
//  VTB_project
//
//  Created by Gleb Uvarkin on 18.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerInteractor: ImagePickerInteractorInput {
    weak var presenter: ImagePickerInteractorOutput?

    private let imageWorker: ObjectDetectorAndTranslator = ImageHandlerAndTranslationWorker()
    private var dataStore: DataStoreProtocol = CoreDataStore(nativeLanguage: .ru, foreignLanguage: .en)

    func handle(image: UIImage) {
        imageWorker.performHandling(image: image) { (objects) in
            DispatchQueue.main.async { [weak self] in
                self?.dataStore.loadMoreImages()
                self?.presenter?.imageDidRecieved(objects: objects)
                self?.dataStore.save(imageWithObjects: objects)

            }

//            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            }
        }
    }
}
