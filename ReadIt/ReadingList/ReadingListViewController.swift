//
//  ReadingListViewController.swift
//  ReadIt
//
//  Created by Felipe Lobo on 20/08/18.
//  Copyright © 2018 Copyisright. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

class ReadingListViewController: UIViewController {

	let useCase: ReadingListUseCase
	let viewModel: ReadingListViewModel

	weak var navigation: ReadingListNavigation?

	private let tableView: UITableView = {
		let tableView = UITableView(frame: .null, style: .plain)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 96
		tableView.register(ReadingCell.self, forCellReuseIdentifier: .genericIdentifier)

		return tableView
	}()

	private var isLoading = false
	private var isLogged: Bool = false

	private var cancellables = [AnyCancellable]()

    init(useCase: ReadingListUseCase, viewModel: ReadingListViewModel) {
        self.useCase = useCase
		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)

		title = "Read It"
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupSubviews()
		setupLayout()

		viewModel.$readingsList
			.sink { [tableView] readingsList in
				DispatchQueue.main.async { tableView.reloadData() }
			}
			.store(in: &cancellables)

		useCase.loadContent()
	}

	private func setupSubviews() {
		tableView.dataSource = self
		tableView.delegate = self

		view.addSubview(tableView)

		let rightButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: nil, action: nil)
		rightButtonItem.tapPublisher
			.sink { [useCase] in useCase.loadContent() }
			.store(in: &cancellables)

		navigationItem.rightBarButtonItem = rightButtonItem

		let leftButtonItem = UIBarButtonItem(title: "User", style: .plain, target: nil, action: nil)
		leftButtonItem.tapPublisher
			.sink { [weak self] in self?.navigation?.forwardToUser() }
			.store(in: &cancellables)

		navigationItem.leftBarButtonItem = leftButtonItem
	}

	private func setupLayout() {
		view.addConstraints(matchingEdgesOf: tableView)
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		.applyDarkContentIfNeeded(self)
	}
    
}

extension ReadingListViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.readingsList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let reading = viewModel.readingsList[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: .genericIdentifier, for: indexPath) as! ReadingCell
		cell.configure(reading)

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		let reading = viewModel.readingsList[indexPath.row]

		navigation?.forwardTo(reading: reading)

		print("Did select row at \(indexPath.row); title: \(reading.title)")
	}

}

fileprivate extension String {
    
    static var genericIdentifier: String {
        "Generic Identifier"
    }
    
}
