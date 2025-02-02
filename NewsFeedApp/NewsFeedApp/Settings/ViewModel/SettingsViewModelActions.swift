//
//  SettingsViewModelActions.swift
//  NewsFeedApp
//
//  Created by Aliaksandr Karenski on 17.12.24.
//

import Combine

/// Экшены вью
struct SettingsViewModelActions {

	/// Энам событий вью
	enum Events {
		/// Нажата кнопка очистки кэша
		case clearCacheDidTap
		/// Значение таймера изменено
		case timerDidChange(Int)
		/// Значение тоггла изменено
		case settingsToggleDidChange(SettingsCellViewModel.SettingsCellType, Bool)
		/// Нажата кнопка источника новостей
		case newsSourceDidTap
	}

	/// Методы жизненного цикла вью контроллера
	let lifecycle = PassthroughSubject<Lifecycle, Never>()
	/// События вью
	let events = PassthroughSubject<Events, Never>()
}
