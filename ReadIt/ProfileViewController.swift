//
// Created by Felipe Lobo on 2018-09-30.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

fileprivate extension String {

	static var genericIdentifier: String {
		return "Generic Identifier"
	}

}

class ProfileViewController: UIViewController {

	let tableView: UITableView

	init() {
		self.tableView = UITableView(frame: .null, style: .grouped)

		super.init(nibName: nil, bundle: nil)
	}

	override required init?(coder aDecoder: NSCoder) {
		fatalError("You should not use init?(coder:), ever!")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor(white: 0.1, alpha: 1)

		tableView.backgroundView?.backgroundColor = UIColor(white: 0.1, alpha: 1)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: .genericIdentifier)

		view.addSubview(tableView)
		view.addConstraintsForAllEdges(of: tableView)
	}

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: .genericIdentifier, for: indexPath)

		return cell
	}

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Did select")
	}

}
