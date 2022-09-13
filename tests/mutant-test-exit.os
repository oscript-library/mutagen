#Использовать asserts
#Использовать "../src"

Перем ЮнитТест;

Перем КодПроцедура;
Перем КодФункция;

Перем КодПроцедураНовая;
Перем КодФункцияНовая;

// Процедура выполняется перед запуском теста
//
Процедура ПередЗапускомТеста() Экспорт
	
	Лог = ПараметрыПриложения.Лог();
	Лог.УстановитьУровень(УровниЛога.Отладка);

	Кодогенерация.ПодключитьМутантов();
	
КонецПроцедуры // ПередЗапускомТеста()

Функция МутацииДляТеста()

	Мутант = Новый БыстрыйВыход();
	Мутации = Новый Массив;
	Мутации.Добавить(Мутант);

	Возврат Мутации;

КонецФункции

// Функция возвращает список тестов для выполнения
//
// Параметры:
//    Тестирование    - Тестер        - Объект Тестер (1testrunner)
//    
// Возвращаемое значение:
//    Массив        - Массив имен процедур-тестов
//    
Функция ПолучитьСписокТестов(Тестирование) Экспорт
	
	ЮнитТест = Тестирование;
	СписокТестов = Новый Массив;

	СписокТестов.Добавить("ТестДолжен_СформироватьМутантаДляПроцедуры");
	СписокТестов.Добавить("ТестДолжен_СформироватьМутантаДляФункции");

	Возврат СписокТестов;

КонецФункции

Процедура ТестДолжен_СформироватьМутанта(ИсходныйКод, КонтрольноеЗначение)

	Мутации = МутацииДляТеста();
	Результат = Кодогенерация.ВыполнитьЗаменыВКоде(ИсходныйКод, Мутации);

	Ожидаем.Что(Результат.Количество(), "Должна быть одна мутация").Равно(1);
	Для Каждого ИмяКод Из Результат Цикл

		Ожидаем.Что(ИмяКод.Значение).Равно(КонтрольноеЗначение);

	КонецЦикла;

КонецПроцедуры

Процедура ТестДолжен_СформироватьМутантаДляПроцедуры() Экспорт

	ТестДолжен_СформироватьМутанта(КодПроцедура, КодПроцедураНовая);

КонецПроцедуры

Процедура ТестДолжен_СформироватьМутантаДляФункции() Экспорт

	ТестДолжен_СформироватьМутанта(КодФункция, КодФункцияНовая);

КонецПроцедуры

КодПроцедура = "Процедура Тестовая(а,б = 0) Экспорт Сообщить(а+б); КонецПроцедуры;";
КодПроцедураНовая = "Процедура Тестовая(а,б = 0) Экспорт Возврат;Сообщить(а+б); КонецПроцедуры;";

КодФункция = "Функция Тестовая(а,б = 0) Результат = а + б; Сообщить(Результат); Возврат Результат; КонецФункции;";
КодФункцияНовая = "Функция Тестовая(а,б = 0) Возврат Null;Результат = а + б; Сообщить(Результат); Возврат Результат; КонецФункции;";