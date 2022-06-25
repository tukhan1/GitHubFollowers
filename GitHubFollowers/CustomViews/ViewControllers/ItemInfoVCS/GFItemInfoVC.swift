//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 08.06.2022.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let itemInfoViewOne: GFItemInfoView = GFItemInfoView()
    let itemInfoViewTwo: GFItemInfoView = GFItemInfoView()
    let actionButton: GFButton = GFButton()

    weak var delegate: UserInfoVCDelegate?

    var user: User!

    private let stackView: UIStackView = UIStackView()

    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureActionButton()
        makeConstraints()
    }

    private func configure() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(stackView)
        view.addSubview(actionButton)
    }

    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc func actionButtonTapped() {}

    private func makeConstraints() {
        let padding = 10
        stackView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).inset(padding)
            make.top.equalTo(view.snp.top).offset(padding)
            make.height.equalTo(50)
        }
        actionButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).inset(padding)
            make.height.equalTo(44)
            make.bottom.equalTo(view.snp.bottom).inset(padding)
        }
    }
}
