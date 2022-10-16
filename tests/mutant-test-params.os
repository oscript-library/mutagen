#Использовать asserts
#Использовать "../src"

Перем ЮнитТест;


// Процедура выполняется перед запуском теста
//
Процедура ПередЗапускомТеста() Экспорт
	
	
КонецПроцедуры // ПередЗапускомТеста()

Функция МутацииДляТеста()

	Мутант = ЗагрузитьСценарий("src/Мутанты/ЗаменаПараметровПроцФунк.os");
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

	СписокТестов.Добавить("ТестДолжен_ПроверитьИдентификатор");

	СписокТестов.Добавить("ТестДолжен_СформироватьЗаменитьИстина");
	СписокТестов.Добавить("ТестДолжен_СформироватьЗаменитьЛожь");
	СписокТестов.Добавить("ТестДолжен_СформироватьЗаменитьСтрока");
	СписокТестов.Добавить("ТестДолжен_СформироватьЗаменитьЧисло");
	СписокТестов.Добавить("ТестДолжен_СформироватьЗаменитьНеопределено");

	Возврат СписокТестов;

КонецФункции

Процедура ТестДолжен_ПроверитьИдентификатор() Экспорт

	Ожидаем.Что(МутацииДляТеста()[0].Мутант()).Равно("ParamByDefault");

КонецПроцедуры


Процедура ТестДолжен_СформироватьМутанта(ИсходныйКод, КонтрольноеЗначение)

	Мутации = МутацииДляТеста();
	Результат = Кодогенерация.ВыполнитьЗаменыВКоде(ИсходныйКод, Мутации);

	Ожидаем.Что(Результат.Количество(), "Должна быть одна мутация").Равно(1);
	Для Каждого ИмяКод Из Результат Цикл

		Ожидаем.Что(ИмяКод.Значение).Равно(КонтрольноеЗначение);

	КонецЦикла;

КонецПроцедуры

Процедура ТестДолжен_СформироватьЗаменитьИстина() Экспорт

	ТестДолжен_СформироватьМутанта(
		"Функция Тест(а, б=Истина) Экспорт Сообщить(а); Возврат Не а; КонецФункции"
		, "Функция Тест(а, б=Ложь) Экспорт Сообщить(а); Возврат Не а; КонецФункции");

КонецПроцедуры

Процедура ТестДолжен_СформироватьЗаменитьЛожь() Экспорт

	ТестДолжен_СформироватьМутанта(
		"Функция Тест(а, б=Ложь) Экспорт Сообщить(а); Возврат Не а; КонецФункции"
		, "Функция Тест(а, б=Истина) Экспорт Сообщить(а); Возврат Не а; КонецФункции");

КонецПроцедуры

Процедура ТестДолжен_СформироватьЗаменитьСтрока() Экспорт

	ТестДолжен_СформироватьМутанта(
		"Функция Тест(а, б=""Тест"") Экспорт Сообщить(а); Возврат Не а; КонецФункции"
		, "Функция Тест(а, б=""xxТестxx"") Экспорт Сообщить(а); Возврат Не а; КонецФункции");

КонецПроцедуры

Процедура ТестДолжен_СформироватьЗаменитьЧисло() Экспорт

	ТестДолжен_СформироватьМутанта(
		"Функция Тест(а, б=5) Экспорт Сообщить(а); Возврат Не а; КонецФункции"
		, "Функция Тест(а, б=10) Экспорт Сообщить(а); Возврат Не а; КонецФункции");

КонецПроцедуры

Процедура ТестДолжен_СформироватьЗаменитьНеопределено() Экспорт

	ТестДолжен_СформироватьМутанта(
		"Функция Тест(а, б=Неопределено) Экспорт Сообщить(а); Возврат Не а; КонецФункции"
		, "Функция Тест(а, б=Null) Экспорт Сообщить(а); Возврат Не а; КонецФункции");

КонецПроцедуры
