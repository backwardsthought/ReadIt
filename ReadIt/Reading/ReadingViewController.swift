//
//  ReadingViewController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 26/08/19.
//  Copyright © 2019 Copyisright. All rights reserved.
//

import UIKit
import Combine

protocol ReadingNavigationDelegate: AnyObject {

    func present(content: URL, fromContext: Presentable)

}

class ReadingViewController: UIViewController {
    
    let useCase: ReadingUseCase
    let viewModel: ReadingViewModel

    weak var navigationDelegate: ReadingNavigationDelegate?

    private var readingView: ReadingView { view as! ReadingView }

    private var imagesCache: [UIImage] = []

    private let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "CloseIcon"), for: .normal)
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        closeButton.layer.shadowRadius = 3
        closeButton.layer.shadowOpacity = 0.2
        
        return closeButton
    }()

    private var cancellables = [AnyCancellable]()

    init(useCase: ReadingUseCase, viewModel: ReadingViewModel) {
        self.useCase = useCase
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should not use init?(coder:), ever!")
    }
    
    override func loadView() {
        let readingView = ReadingView()
        readingView.imagesView.dataSource = self
        readingView.imagesView.delegate = self

        view = readingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupActions()
        setupLayout()
        
		viewModel.$reading
			.compactMap { $0 }
            .sink { [weak self] reading in self?.update(reading: reading) }
            .store(in: &cancellables)

        viewModel.$images
            .sink { [weak self] imagesData in self?.update(downloadedImages: imagesData) }
            .store(in: &cancellables)

        useCase.loadContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.isNavigationBarHidden = false
    }

    // MARK: Setup

    private func setupActions() {
        closeButton.tapPublisher
            .sink { [weak self] in self?.navigationController?.popViewController(animated: true) }
            .store(in: &cancellables)

        readingView.buttonsContainer.readItButton.tapPublisher
            .sink { [unowned self, reading = viewModel.reading] in
                if let url = reading?.source {
                    navigationDelegate?.present(content: url, fromContext: self)
                }
            }
            .store(in: &cancellables)
    }

    private func setupLayout() {
        edgesForExtendedLayout = .all

        view.addSubview(closeButton)
        view.addConstraints([
            closeButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            view.safeAreaLayoutGuide.topAnchor
                .anchorWithOffset(to: closeButton.topAnchor)
                .constraint(equalToConstant: 8)
        ])
    }

    // MARK: Updating
    
    private func update(reading: Reading) {
        let readingView = view as! ReadingView
        
        readingView.authorLabel.text = reading.author
        
		if let date = reading.dateAdded {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd/MM/yyyy"

			readingView.dateLabel.text = dateFormatter.string(from: date)
		}
        
        readingView.titleLabel.text = reading.title
        readingView.detailLabel.text = reading.excerpt
        
        readingView.imagesView.isHidden = reading.images == nil
    }
    
    private func update(downloadedImages images: [Data]) {
        imagesCache = images.compactMap(UIImage.init)

        readingView.imagesView.reloadData()
        readingView.backgroundImage = imagesCache.first
    }

}

extension ReadingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imagesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ReadingImageViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        if indexPath.item < imagesCache.count {
            let image = imagesCache[indexPath.item]
            cell.imageView.image = image
        }
        
        return cell
    }

}

extension ReadingViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let layoutMargins = readingView.layoutMargins
        return UIEdgeInsets(top: 0, left: layoutMargins.left - 4, bottom: 0, right: layoutMargins.right - 4)
    }

}
