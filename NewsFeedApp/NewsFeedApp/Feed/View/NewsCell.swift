//
//  NewsCell.swift
//  NewsFeedApp
//
//  Created by Aliaksandr Karenski on 13.12.24.
//

import UIKit

protocol NewsCellDelegate: AnyObject {
	func didTapShowMoreInfoButton(for cell: NewsCell)
}

final class NewsCell: UITableViewCell {

	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16, weight: .bold)
		label.numberOfLines = .zero
		return label
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.numberOfLines = .zero
		return label
	}()

	private lazy var showMoreInfoButton: UIButton = {
		let button = UIButton()
		button.setTitle("Показать подробно", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
		let action = UIAction { [weak self] _ in
			guard let self else { return }
			descriptionLabel.isHidden.toggle()
			showMoreInfoButton.isHidden = true
			delegate?.didTapShowMoreInfoButton(for: self)
		}
		button.addAction(action, for: .touchUpInside)
		return button
	}()

	private lazy var newsImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private lazy var publicationDateLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .bold)
		return label
	}()

	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 4
		stackView.distribution = .fill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

	private var imageHeightConstraint: NSLayoutConstraint?

	weak var delegate: NewsCellDelegate?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		titleLabel.text = nil
		descriptionLabel.text = nil
		newsImageView.image = nil
		publicationDateLabel.text = nil
		showMoreInfoButton.isHidden = false
		descriptionLabel.isHidden = true
	}

	func setup(with item: NewsFeedModelDTO) {
		titleLabel.text = item.title
		descriptionLabel.text = item.description
		if item.isDescriptionExpanded {
			showMoreInfoButton.isHidden = true
			descriptionLabel.isHidden = false
		}
		if let imageURL = item.imageURL {
			imageHeightConstraint?.isActive = true
			newsImageView.setImage(from: imageURL)
		} else {
			imageHeightConstraint?.isActive = false
		}
		if let publicationDate = item.publicationDate {
			let checkMark: String = item.isArticleReaded ? .checkMark : .empty
			publicationDateLabel.text = (item.channel ?? .empty)
			+ " | "
			+ publicationDate.formatted()
			+ .space
			+ checkMark
		}
	}
}

// MARK: - Private

private extension NewsCell {

	enum Constants {
		static let insent: CGFloat = 16
		static let imageHeight: CGFloat = 300
	}

	func setup() {
		selectionStyle = .none
		backgroundColor = .systemBackground
		contentView.addSubview(stackView)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(descriptionLabel)
		stackView.addArrangedSubview(showMoreInfoButton)
		stackView.addArrangedSubview(newsImageView)
		stackView.addArrangedSubview(publicationDateLabel)
		NSLayoutConstraint.activate(
			[
				stackView.topAnchor.constraint(
					equalTo: contentView.topAnchor,
					constant: Constants.insent
				),
				stackView.bottomAnchor.constraint(
					equalTo: contentView.bottomAnchor,
					constant: -Constants.insent
				),
				stackView.leadingAnchor.constraint(
					equalTo: contentView.leadingAnchor,
					constant: Constants.insent
				),
				stackView.trailingAnchor.constraint(
					equalTo: contentView.trailingAnchor,
					constant: -Constants.insent
				),
			]
		)
		imageHeightConstraint = newsImageView.heightAnchor.constraint(
			equalToConstant: Constants.imageHeight
		)
	}
}
