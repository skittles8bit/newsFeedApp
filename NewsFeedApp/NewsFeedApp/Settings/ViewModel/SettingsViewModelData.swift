//
//  SettingsViewModelData.swift
//  NewsFeedApp
//
//  Created by Aliaksandr Karenski on 17.12.24.
//

import Combine

/// Данные вью модели настроек
struct SettingsViewModelData {
	/// Обновления ячейки настроек
	let updateSettingsCellPublisher: AnyPublisher<[SettingsCellViewModel], Never>
	/// Обновление состояния пикер вью
	let pickerViewStatePublisher: AnyPublisher<SettingsPickerViewStateModel, Never>
	/// Обновление состояния кнопки источника новостей
	let newsSourceButtonStatePublisher: AnyPublisher<Bool, Never>
}
