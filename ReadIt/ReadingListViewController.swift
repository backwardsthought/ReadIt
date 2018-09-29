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

fileprivate extension String {

	static var genericIdentifier: String {
		return "Generic Identifier"
	}

}

class ReadingListViewController: UIViewController {

	private let disposeBag = DisposeBag()

	private var isLoading = false

	let viewModel: ReadingListViewModelType
	let tableView: UITableView

	var readingsList: [Reading] = []
	var isLogged: Bool = false
	var authSession: ASWebAuthenticationSession? = nil

	init(viewModel: ReadingListViewModelType) {
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

		view.backgroundColor = .white

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(ReadingCell.self, forCellReuseIdentifier: .genericIdentifier)

		view.addSubview(tableView)
		view.addConstraintsForAllEdges(of: tableView)

		viewModel.readingList
				.subscribe(onNext: { readingsList in
					self.readingsList = readingsList
					self.tableView.reloadData()
				})
				.disposed(by: disposeBag)

		viewModel.isLogged
				.subscribe(onNext: { logged in
					self.isLogged = logged
					self.navigationItem.leftBarButtonItem = nil
				})
				.disposed(by: disposeBag)

		let leftButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: nil, action: nil)
		leftButtonItem.rx.tap.subscribe(onNext: { _ in
			self.viewModel.login()
		}).disposed(by: disposeBag)

		let rightButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: nil, action: nil)
		rightButtonItem.rx.tap.subscribe(onNext: { _ in
			self.viewModel.load()
		}).disposed(by: disposeBag)

		navigationItem.leftBarButtonItem = leftButtonItem
		navigationItem.rightBarButtonItem = rightButtonItem

		viewModel.load()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

extension ReadingListViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return readingsList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: .genericIdentifier, for: indexPath)

		let reading = readingsList[indexPath.row]

		cell.textLabel?.text = reading.title
		cell.detailTextLabel?.text = reading.source

		return cell
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		print("Did select row at \(indexPath.row)")
	}

}
