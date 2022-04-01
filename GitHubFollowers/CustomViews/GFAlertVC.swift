//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by Egor Tushev on 31.03.2022.
//

import UIKit
import SnapKit

class GFAlertVC: UIViewController {

    private let containerView = UIView(frame: .zero)
    private let titleLabel = GFTitleLabel(textAligment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAligment: .center)
    private let actionBotton = GFButton(backgroundColor: .systemPink, title: "Ok")

    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?

    private let padding: CGFloat = 20

    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configure()
        makeConstraints()
    }

    private func configure() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionBotton)

        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor

        titleLabel.text = alertTitle ?? "Something went wrong"
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 0
        actionBotton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }

    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    private func makeConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.centerY.equalTo(view.snp.centerY)
            maker.centerX.equalTo(view.snp.centerX)
            maker.width.equalTo(view.snp.width).multipliedBy(0.85)
            maker.height.equalTo(220)
        }
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(containerView.snp.top).offset(padding)
            maker.left.equalTo(containerView.snp.left).offset(padding)
            maker.right.equalTo(containerView.snp.right).inset(padding)
            maker.height.equalTo(25)
        }
        messageLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom)
            maker.left.equalTo(containerView.snp.left).offset(padding)
            maker.right.equalTo(containerView.snp.right).inset(padding)
            maker.bottom.equalTo(actionBotton.snp.top)
        }
        actionBotton.snp.makeConstraints { maker in
            maker.bottom.equalTo(containerView.snp.bottom).inset(padding)
            maker.left.equalTo(containerView.snp.left).offset(padding)
            maker.right.equalTo(containerView.snp.right).inset(padding)
            maker.height.equalTo(containerView.snp.height).multipliedBy(0.15)
        }
    }
}
