#Использовать logos
#Использовать tempfiles
#Использовать fs

Перем ЛогПриложения;            // Объект                 - объект записи лога приложения
Перем ОбщиеПараметры;           // Структура              - общие параметры приложения
Перем СохрКаталогПриложения;    // Строка                 - текущий каталог приложения
Перем ЭтоПриложениеEXE;         // Булево                 - Истина - выполняется скомпилированный скрипт
Перем ЭтоWindows;               // Булево                 - Истина - скрипт выполняется в среде Windows

Процедура Инициализация(Знач Параметры = Неопределено)

	ОбщиеПараметры = Новый Структура();

	Если ТипЗнч(Параметры) = Тип("Структура") Тогда
		Для Каждого ТекПараметр Из Параметры Цикл
			ОбщиеПараметры.Добавить(ТекПараметр.Ключ, ТекПараметр.Значение);
		КонецЦикла;
	КонецЕсли;

	

КонецПроцедуры // Инициализация()

// Функция - проверяет, что скрипт выполняется в среде Windows
//
// Возвращаемое значение:
//	Булево     - Истина - скрипт выполняется в среде Windows
//
Функция ЭтоWindows() Экспорт

	Если ЭтоWindows = Неопределено Тогда
		СистемнаяИнформация = Новый СистемнаяИнформация;
		ЭтоWindows = Найти(НРег(СистемнаяИнформация.ВерсияОС), "windows") > 0;
	КонецЕсли;

	Возврат ЭтоWindows;

КонецФункции // ЭтоWindows()

// Функция - проверяет, что выполняется скомпилированный скрипт
//
// Возвращаемое значение:
//	Булево     - Истина - выполняется скомпилированный скрипт
//
Функция ЭтоСборкаEXE() Экспорт
	
	Если ЭтоПриложениеEXE = Неопределено Тогда
		ЭтоПриложениеEXE = ВРег(Прав(ТекущийСценарий().Источник, 3)) = "EXE";
	КонецЕсли;

	Возврат ЭтоПриложениеEXE;

КонецФункции // ЭтоСборкаEXE()

// Функция - при необходтимости, определяет и возвращает текущий каталог приложения
//
// Возвращаемое значение:
//  Строка      - текущий каталог приложения
//
Функция КаталогПриложения() Экспорт
	
	Если Не СохрКаталогПриложения = Неопределено Тогда
		Возврат СохрКаталогПриложения;
	КонецЕсли;

	ПутьККаталогу = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..");

	ФайлКаталога = Новый Файл(ПутьККаталогу);
	СохрКаталогПриложения = ФайлКаталога.ПолноеИмя;
	
	Возврат СохрКаталогПриложения;

КонецФункции // КаталогПриложения()

// Функция - возвращает текущий уровень лога приложения
//
// Возвращаемое значение:
//  Строка      - текущий уровень лога приложения
//
Функция УровеньЛога() Экспорт

	Возврат ЛогПриложения.Уровень();

КонецФункции // УровеньЛога()

// Процедура - включает режим отладки
//
// Параметры:
//	РежимОтладки - Булево - включить режим отладки
//
Процедура УстановитьРежимОтладки(Знач РежимОтладки) Экспорт
	
	Если РежимОтладки Тогда
		
		Лог().УстановитьУровень(УровниЛога.Отладка);

	КонецЕсли;
	
КонецПроцедуры // УстановитьРежимОтладки()

// Функция - возвращает общие параметры приложения
//
// Возвращаемое значение:
//  Структура      - общие параметры приложения
//
Функция Параметры() Экспорт

	Возврат ОбщиеПараметры;

КонецФункции // Параметры()

// Функция - при необходимости, инициализирует и возвращает объект управления логированием
//
// Возвращаемое значение:
//  Объект      - объект управления логированием
//
Функция Лог() Экспорт
	
	Если ЛогПриложения = Неопределено Тогда
		ЛогПриложения = Логирование.ПолучитьЛог(ИмяЛогаПриложения());
		
	КонецЕсли;

	Возврат ЛогПриложения;

КонецФункции // Лог()

// Функция - возвращает имя лога приложения
//
// Возвращаемое значение:
//  Строка      - имя лога приложения
//
Функция ИмяЛогаПриложения() Экспорт

	Возврат "oscript.app." + ИмяПриложения();

КонецФункции // ИмяЛогаПриложения()

// Функция - возвращает имя приложения
//
// Возвращаемое значение:
//  Строка      - имя приложения
//
Функция ИмяПриложения() Экспорт

	Возврат "mutagen";
		
КонецФункции // ИмяПриложения()

// Функция - возвращает версию приложения
//
// Возвращаемое значение:
//  Строка      - версия приложения
//
Функция Версия() Экспорт
	
	Возврат "0.0.1";
	
КонецФункции // Версия()

Инициализация();