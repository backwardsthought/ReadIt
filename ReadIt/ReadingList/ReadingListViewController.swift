//
//  ReadingListViewController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 20/08/18.
//  Copyright © 2018 Copyisright. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices

protocol ReadingListNavigationDelegate: class {
    
    func navigate(to reading: Reading)
    
}

class ReadingListViewController: UIViewController {

	private let disposeBag = DisposeBag()

	private var isLoading = false
    private let tableView: UITableView
    
    private var readingsList: [Reading] = []
    private var isLogged: Bool = false
    private var authSession: ASWebAuthenticationSession? = nil

    let useCase: ReadingListUseCase
    let viewModel: ReadingListViewModelType
    
    weak var navigationDelegate: ReadingListNavigationDelegate?

    init(useCase: ReadingListUseCase, viewModel: ReadingListViewModelType) {
        self.useCase = useCase
		self.viewModel = viewModel
		self.tableView = UITableView(frame: .null, style: .plain)

		super.init(nibName: nil, bundle: nil)

		self.title = "Read It"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(ReadingCell.self, forCellReuseIdentifier: .genericIdentifier)

		view.addSubview(tableView)
		view.addConstraintsForAllEdges(of: tableView)

		viewModel.readingList
				.subscribe(onNext: { [weak self] readingsList in
					self?.readingsList = readingsList
					self?.tableView.reloadData()
				})
				.disposed(by: disposeBag)

		let rightButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: nil, action: nil)
		rightButtonItem.rx.tap.subscribe(onNext: { [weak self] _ in
			self?.useCase.loadContent()
		}).disposed(by: disposeBag)

		navigationItem.rightBarButtonItem = rightButtonItem

		useCase.loadContent()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .applyDarkContentIfNeeded(self)
	}
    
}

extension ReadingListViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return readingsList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: .genericIdentifier, for: indexPath) as? ReadingCell else { return UITableViewCell() }

		let reading = readingsList[indexPath.row]

		cell.configure(reading)

		return cell
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
        
        let reading = readingsList[indexPath.row]
        
        navigationDelegate?.navigate(to: reading)
        
        print("Did select row at \(indexPath.row); title: \(reading.title)")
	}

}

fileprivate extension String {
    
    static var genericIdentifier: String {
        return "Generic Identifier"
    }
    
}
