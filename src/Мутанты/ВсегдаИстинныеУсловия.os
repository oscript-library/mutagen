﻿Перем Токены;
Перем ТаблицаЗамен;


Функция Мутант() Экспорт
	
	Возврат "AlwaysTrue";
	
КонецФункции

Функция Описание() Экспорт
	
	Возврат "Замена логических условий на Истину. ВНИМАНИЕ! Может создавать бесконечные циклы";
	
КонецФункции

#Область Плагин

Процедура Открыть(Парсер, Параметры) Экспорт
	
	ТаблицаЗамен = Парсер.ТаблицаЗамен();
	
КонецПроцедуры // Открыть()

Функция Закрыть() Экспорт
	Возврат Неопределено;
КонецФункции // Закрыть()

Функция Подписки() Экспорт
	Перем Подписки;
	Подписки = Новый Массив;

	Подписки.Добавить("ПосетитьОператорЕсли");
	Подписки.Добавить("ПосетитьОператорИначеЕсли");
	Подписки.Добавить("ПосетитьОператорПока");

	Возврат Подписки;
КонецФункции // Подписки()

#КонецОбласти

#Область ВспомогательныеФункции

Процедура Вставка(Текст, Позиция, Длина)
	НоваяЗамена = ТаблицаЗамен.Добавить();
	НоваяЗамена.Источник = Мутант();
	НоваяЗамена.Текст = Текст;
	НоваяЗамена.Позиция = Позиция;
	НоваяЗамена.Длина = Длина;
КонецПроцедуры

#КонецОбласти

Функция ДлинаОператора(Оператор)

	Длина = Оператор.Выражение.Конец.Позиция - Оператор.Выражение.Начало.Позиция + 1;
	Возврат Длина;

КонецФункции

#Область Подписки

Процедура ПосетитьОператорЕсли(ОбъявлениеОператора) Экспорт
	
	Длина = ДлинаОператора(ОбъявлениеОператора);
	Вставка("Истина", ОбъявлениеОператора.Выражение.Начало.Позиция, Длина);
	
КонецПроцедуры

Процедура ПосетитьОператорИначеЕсли(ОбъявлениеОператора) Экспорт
	
	Длина = ДлинаОператора(ОбъявлениеОператора);
	Вставка("Истина", ОбъявлениеОператора.Выражение.Начало.Позиция, Длина);
	
КонецПроцедуры

Процедура ПосетитьОператорПока(ОбъявлениеОператора) Экспорт
	
	Длина = ДлинаОператора(ОбъявлениеОператора);
	Вставка("Истина", ОбъявлениеОператора.Выражение.Начало.Позиция, Длина);
	
КонецПроцедуры


#КонецОбласти