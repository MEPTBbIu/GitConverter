
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
	
		ПриЧтенииСозданииНаСервере();
	
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();
	
	ОбновитьСостояниеНаСервере();
	
	ИмяФайлаЛога = КонвертацияХранилища.ИмяФайлаЛогаКонвертацииХранилища(ТекущийОбъект.КаталогВыгрузкиВерсий);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если АвтообновлениеСостоянияЗадания Тогда
	
		ОбновитьСостояниеНаКлиенте();
	
	КонецЕсли; 
	
	Элементы.ФормаОбновлятьСостояниеАвтоматически.Пометка = АвтообновлениеСостоянияЗадания;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.ДополнительныеСвойства.Вставить("Расписание", Расписание);
	ТекущийОбъект.ДополнительныеСвойства.Вставить("Использование", РегламентноеЗаданиеИспользуется);
	Если ТекущийОбъект.Наименование = ТекущийАдрес Тогда
		ТекущийОбъект.Наименование = ТекущийОбъект.Адрес;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОбновитьСостояниеНаКлиенте();
	Если ЗначениеЗаполнено(Объект.Ссылка) И НЕ Объект.КонвертироватьВФорматEDT Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Конвертация в формат 1С:Предприятия является устаревшей. Рекомендуется выполнить конвертацию в формат 1C:EDT.'"));
	КонецЕсли;
	ТекущийАдрес = Объект.Адрес;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если ЗначениеЗаполнено(Объект.ВерсияПлатформы) ИЛИ РегламентноеЗаданиеИспользуется Тогда
		ПутьКВерсиям = Константы.ПутьКВерсиямПлатформыНаСервере.Получить();
		Если НЕ ЗначениеЗаполнено(ПутьКВерсиям) Тогда
			Сообщение = Новый СообщениеПользователю();
			Сообщение.Текст = НСтр("ru = 'Не заполнена константа ""Путь к версиям Платформы на сервере"".'");
			Сообщение.ПутьКДанным = "Объект.ВерсияПлатформы";
			Сообщение.КлючДанных = Объект.Ссылка;
			Сообщение.Сообщить();
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РегламентноеЗаданиеИспользуетсяПриИзменении(Элемент)
	
	УстановитьДоступность(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура РасписаниеСтрокойНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ДиалогРасписания = Новый ДиалогРасписанияРегламентногоЗадания(Расписание);
	ДиалогРасписания.Показать(Новый ОписаниеОповещения("РасписаниеСтрокойНажатиеЗавершение", ЭтотОбъект));
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаЛогаОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если Не ЗначениеЗаполнено(ИмяФайлаЛога) Тогда
		Возврат;
	КонецЕсли;
	
	Текст = Новый ТекстовыйДокумент();
	
	ИмяФайла = "";
	ПрочитатьТекстовыйФайлНаСервере(ИмяФайлаЛога, Текст, ИмяФайла);
	
	Текст.Показать(ИмяФайла, ИмяФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура ЛокальныйКаталогGitПриИзменении(Элемент)
	
	ПроверитьНаличиеРепозитория();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьСостояние(Команда)
	
	ОбновитьСостояниеНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьКонвертацию(Команда)
	
	ЗапуститьКонвертациюНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКоммиты(Команда)
	
	ВыполнитьКоммитыНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновлятьСостояниеАвтоматически(Команда)
	
	АвтообновлениеСостоянияЗадания = НЕ АвтообновлениеСостоянияЗадания;
	Элементы.ФормаОбновлятьСостояниеАвтоматически.Пометка = АвтообновлениеСостоянияЗадания;
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьРепозиторийGit(Команда)
	
	Если НЕ ЗначениеЗаполнено(Объект.ЛокальныйКаталогGit) Тогда
	
		ПоказатьПредупреждение(, НСтр("ru = 'Не указан локальный каталог репозитория Git'"));
		Возврат;
	
	КонецЕсли; 
	
	Если Модифицированность ИЛИ Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
	
		Если НЕ Записать() Тогда
		
			Возврат;
		
		КонецЕсли; 
	
	КонецЕсли;
	
	СоздатьРепозиторийGitНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьВерсииИзОтчетаПоХранилищу(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.МножественныйВыбор = Ложь;
	Диалог.Фильтр = "Отчет по версиям хранилища(*.mxl)|*.mxl";
	Диалог.ПроверятьСуществованиеФайла = Истина;
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьВерсииИзОтчетаПоХранилищуВыбор", ЭтотОбъект);
	
	Диалог.Показать(Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьАдресРепозиторияGit(Команда)
	
	Если НЕ ЗначениеЗаполнено(Объект.АдресРепозиторияGit) Тогда
	
		ПоказатьПредупреждение(, НСтр("ru = 'Не указан адрес репозитория на сервере Git'"));
		Возврат;
	
	КонецЕсли; 
	
	Если Модифицированность Тогда
	
		Если НЕ Записать() Тогда
		
			Возврат;
		
		КонецЕсли; 
	
	КонецЕсли;
	
	УстановитьАдресРепозиторияGitНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура КонвертироватьВФорматEDT(Команда)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Конвертировать в формат 1C:EDT можно только существующий репозиторий.'"));
		Возврат;
	КонецЕсли;
	
	ПараметрыОткрытия = Новый Структура("Хранилище", Объект.Ссылка);
	ОткрытьФорму("Обработка.КонвертацияВФорматEDT.Форма", ПараметрыОткрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьДоступнуюВерсиюEDT(Команда)

	Версия = Объект.ВерсияПлатформы;
	Если НЕ ЗначениеЗаполнено(Версия) Тогда
		СисИнфо = Новый СистемнаяИнформация();
		Версия = СисИнфо.ВерсияПриложения;
	КонецЕсли;
	Квалификаторы = СтрРазделить(Версия, ".");
	Если Квалификаторы.Количество() = 4 Тогда
		Квалификаторы.Удалить(Квалификаторы.ВГраница());
		Версия = СтрСоединить(Квалификаторы, ".");
		ВерсииEDT = ПолучитьДоступныеВерсииEDTНаСервере();
		ВерсияНайдена = Ложь;
		Для Каждого ВерсияEDT Из ВерсииEDT Цикл
			Если Версия = ВерсияEDT Тогда
				ВерсияНайдена = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		Если ВерсияНайдена Тогда
			Текст = НСтр("ru = 'Версия ''%Версия%'' доступна для конвертации в формат 1C:EDT.'");
		ИначеЕсли ВерсииEDT.Количество() = 0 Тогда
			Текст = НСтр("ru = 'Не обнаружено доступных версий в 1C:EDT!
						 |Возможно 1C:EDT версии 1.8 и выше не установлена на сервере или недоступна для запуска.'");
		Иначе
			Текст = НСтр("ru = 'Версия ''%Версия%'' не доступна для конвертации в формат 1C:EDT.
						 |Укажите версию платформы из доступных: %ВерсииEDT%.'");
			Текст = СтрЗаменить(Текст, "%ВерсииEDT%", СтрСоединить(ВерсииEDT, ", "));
		КонецЕсли;
		Текст = СтрЗаменить(Текст, "%Версия%", Версия);
	Иначе
		Текст = НСтр("ru = 'Версия платформы должна быть в формате Х.Х.Х.Х'");
	КонецЕсли;
	
	ПоказатьПредупреждение(, Текст);

КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСостояниеНаСервере()
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
	
		СостояниеЗадания = "";
		Возврат;
	
	КонецЕсли; 
	
	Отбор = Новый Структура();
	Отбор.Вставить("Ключ", Строка(Объект.Ссылка.УникальныйИдентификатор()));
	Отбор.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
	Отбор.Вставить("ИмяМетода", "КонвертацияХранилища.ВыполнитьКонвертацию");
	
	МассивФоновыхЗаданий = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
	
	Если МассивФоновыхЗаданий.Количество() > 0 Тогда
		Задание = МассивФоновыхЗаданий[0];
		СостояниеЗадания = НСтр("ru='Выполняется конвертация с %Дата%'");
		СостояниеЗадания = СтрЗаменить(СостояниеЗадания, "%Дата%", Задание.Начало);
		
	ИначеЕсли ЗначениеЗаполнено(Объект.РегламентноеЗадание) Тогда
		СостояниеЗадания = "";
		РегЗадание = РегламентныеЗадания.НайтиПоУникальномуИдентификатору(
			Новый УникальныйИдентификатор(Объект.РегламентноеЗадание));
		СвойстваПоследнегоФоновогоЗадания = РегламентныеЗаданияСлужебный
			.ПолучитьСвойстваПоследнегоФоновогоЗаданияВыполненияРегламентногоЗадания(РегЗадание);
		Если СвойстваПоследнегоФоновогоЗадания <> Неопределено 
			И СвойстваПоследнегоФоновогоЗадания.Состояние = СостояниеФоновогоЗадания.ЗавершеноАварийно Тогда
			СостояниеЗадания = СтрШаблон(НСтр("ru='Задание конвертации завершено аварийно в %1 по причине: %2'"), 
				СвойстваПоследнегоФоновогоЗадания.Конец,
				СвойстваПоследнегоФоновогоЗадания.ОписаниеИнформацииОбОшибке); 
		КонецЕсли;
	Иначе
		СостояниеЗадания = "";
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|	И ВерсииХранилища.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.ВерсияПомещена)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|	И ВерсииХранилища.Состояние В (ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.МетаданныеЗагружены),
	|		ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.НачалоКоммита))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|	И
	|	НЕ ВерсииХранилища.Состояние В (ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.ПустаяСсылка),
	|		ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.НачалоКоммита), ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.ВерсияПомещена))
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество,
	|	МАКСИМУМ(СостоянияВерсииСрезПоследних.Период) КАК Окончание,
	|	МИНИМУМ(СостоянияВерсииСрезПоследних.Период) КАК Начало
	|ПОМЕСТИТЬ ОбщаяСкорость
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СостоянияВерсии.СрезПоследних КАК СостоянияВерсииСрезПоследних
	|		ПО ВерсииХранилища.Ссылка = СостоянияВерсииСрезПоследних.ВерсияХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|	И ВерсииХранилища.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.ВерсияПомещена)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА РАЗНОСТЬДАТ(ОбщаяСкорость.Начало, ОбщаяСкорость.Окончание, ЧАС) = 0
	|			ТОГДА 0
	|		ИНАЧЕ ОбщаяСкорость.Количество / РАЗНОСТЬДАТ(ОбщаяСкорость.Начало, ОбщаяСкорость.Окончание, ЧАС)
	|	КОНЕЦ КАК Скорость
	|ИЗ
	|	ОбщаяСкорость КАК ОбщаяСкорость
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВерсииХранилища.Ссылка) КАК Количество,
	|	МАКСИМУМ(СостоянияВерсииСрезПоследних.Период) КАК Окончание,
	|	МИНИМУМ(СостоянияВерсииСрезПоследних.Период) КАК Начало
	|ПОМЕСТИТЬ ТекущаяСкорость
	|ИЗ
	|	Справочник.ВерсииХранилища КАК ВерсииХранилища
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.СостоянияВерсии.СрезПоследних КАК СостоянияВерсииСрезПоследних
	|		ПО ВерсииХранилища.Ссылка = СостоянияВерсииСрезПоследних.ВерсияХранилища
	|ГДЕ
	|	ВерсииХранилища.Владелец = &Хранилище
	|	И ВерсииХранилища.Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияВерсии.ВерсияПомещена)
	|	И СостоянияВерсииСрезПоследних.Период >= &ПредыдущаяДата
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВЫБОР
	|		КОГДА РАЗНОСТЬДАТ(ТекущаяСкорость.Начало, ТекущаяСкорость.Окончание, ЧАС) = 0
	|			ТОГДА 0
	|		ИНАЧЕ ТекущаяСкорость.Количество / РАЗНОСТЬДАТ(ТекущаяСкорость.Начало, ТекущаяСкорость.Окончание, ЧАС)
	|	КОНЕЦ КАК Скорость
	|ИЗ
	|	ТекущаяСкорость КАК ТекущаяСкорость";
	
	Запрос.УстановитьПараметр("ПредыдущаяДата", ТекущаяДатаСеанса() - 86400);
	Запрос.УстановитьПараметр("Хранилище", Объект.Ссылка);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[0].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	ВсегоВерсий = ВыборкаДетальныеЗаписи.Количество;
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[1].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	КоличествоКоммитов = ВыборкаДетальныеЗаписи.Количество;
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[2].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	КоличествоВерсийОбработано = ВыборкаДетальныеЗаписи.Количество;
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[3].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	КоличествоПодготавливаемыхВерсий = ВыборкаДетальныеЗаписи.Количество;
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[5].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	СредняяСкорость = ВыборкаДетальныеЗаписи.Скорость;
	
	ВыборкаДетальныеЗаписи = РезультатыЗапроса[7].Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	СредняяСкоростьЗаСутки = ВыборкаДетальныеЗаписи.Скорость;
	

КонецПроцедуры

&НаСервере
Процедура ЗапуститьКонвертациюНаСервере()
	
	Отбор = Новый Структура();
	Ключ = Строка(Объект.Ссылка.УникальныйИдентификатор());
	Отбор.Вставить("Ключ", Ключ);
	Отбор.Вставить("Состояние", СостояниеФоновогоЗадания.Активно);
	Отбор.Вставить("ИмяМетода", "КонвертацияХранилища.ВыполнитьКонвертацию");

	МассивФоновыхЗаданий = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);

	Если МассивФоновыхЗаданий.Количество() > 0 Тогда
		Задание = МассивФоновыхЗаданий[0];
		СостояниеЗадания = НСтр("ru='Выполняется конвертация с %Дата%'");
		СостояниеЗадания = СтрЗаменить(СостояниеЗадания, "%Дата%", Задание.Начало);

	Иначе
		СостояниеЗадания = "";
		
		ПараметрыЗадания = Новый Массив;
		ПараметрыЗадания.Добавить(Объект.Ссылка);
		
		НаименованиеЗадания = НСтр("ru = 'Конвертация хранилища'") + ": ";
	
		НаименованиеЗадания = Лев(НаименованиеЗадания + СокрЛП(Объект.Адрес), 120);
		
		ФоновыеЗадания.Выполнить("КонвертацияХранилища.ВыполнитьКонвертацию", ПараметрыЗадания, Ключ, НаименованиеЗадания);
		
	КонецЕсли;
	
	ОбновитьСостояниеНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКоммитыНаСервере()
	
	КонвертацияХранилища.ЗапуститьКоммитыВФоне(Объект.Ссылка);
	
	ОбновитьСостояниеНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСостояниеНаКлиенте()

	ОтключитьОбработчикОжидания("ОбновитьСостояниеНаКлиенте");
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьСостояниеНаСервере();
	
	Если АвтообновлениеСостоянияЗадания Тогда
	
		ПодключитьОбработчикОжидания("ОбновитьСостояниеНаКлиенте", 20, Истина);
	
	КонецЕсли; 

КонецПроцедуры 

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	УстановитьПривилегированныйРежим(Истина);
	Задание = РегламентныеЗаданияСервер.Задание(Объект.РегламентноеЗадание);
	Если Задание <> Неопределено Тогда
		Расписание = Задание.Расписание;
		РегламентноеЗаданиеИспользуется = Задание.Использование;
		РасписаниеСтрокой = Строка(Расписание);
	Иначе
		Расписание = Новый РасписаниеРегламентногоЗадания;
		РасписаниеСтрокой = РасписаниеСтрокой = Строка(Расписание);
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
	
	ПроверитьНаличиеРепозитория();
	
	ТекущийАдрес = Объект.Адрес;
	
	СисИнфо = Новый СистемнаяИнформация;
	Элементы.ВерсияПлатформы.ПодсказкаВвода = СисИнфо.ВерсияПриложения;
	
	УстановитьДоступность(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступность(Форма)
	
	Форма.Элементы.РасписаниеСтрокой.Доступность = Форма.РегламентноеЗаданиеИспользуется;
	Форма.Элементы.КонвертироватьВФорматEDT.Видимость = НЕ Форма.Объект.КонвертироватьВФорматEDT;
	Форма.Элементы.ФормаКонвертироватьВФорматEDT.Видимость = НЕ Форма.Объект.КонвертироватьВФорматEDT;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьДоступныеВерсииEDTНаСервере()
	
	Возврат КонвертацияХранилища.ПолучитьСписокВерсийEDT();
		
КонецФункции


&НаКлиенте
Процедура РасписаниеСтрокойНажатиеЗавершение(Расписание1, ДополнительныеПараметры) Экспорт
	
	Если Расписание1 <> Неопределено Тогда
		
		Модифицированность = Истина;
		Расписание         = Расписание1;
		РасписаниеСтрокой  = Строка(Расписание);
		
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПроверитьНаличиеРепозитория()

	Если НЕ ЗначениеЗаполнено(Объект.ЛокальныйКаталогGit) Тогда
		
		Элементы.СоздатьРепозиторийGit.Доступность = Ложь;
		Элементы.ФормаСоздатьРепозиторийGit.Доступность = Ложь;
		Возврат;
	
	КонецЕсли; 
	
	НайденныеФайлы = НайтиФайлы(Объект.ЛокальныйКаталогGit, "*");
	Для каждого Файл Из НайденныеФайлы Цикл
	
		Если НРег(Файл.Имя) = ".git" Тогда
			
			Элементы.СоздатьРепозиторийGit.Доступность = Ложь;
			Элементы.ФормаСоздатьРепозиторийGit.Доступность = Ложь;
			Возврат;
		
		КонецЕсли; 
	
	КонецЦикла; 
	
	Элементы.СоздатьРепозиторийGit.Доступность = Истина;
	Элементы.ФормаСоздатьРепозиторийGit.Доступность = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьВерсииИзОтчетаПоХранилищуВыбор(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт 
	
	Если ВыбранныеФайлы = Неопределено ИЛИ ВыбранныеФайлы.Количество() <> 1 Тогда
		Возврат;
	КонецЕсли; 
	
	ПолноеИмяФайла = ВыбранныеФайлы[0];
	
	Оповещение = Новый ОписаниеОповещения("ЗагрузитьВерсииИзОтчетаПоХранилищуПослеПомещения", ЭтотОбъект);
	
	НачатьПомещениеФайла(Оповещение, , ПолноеИмяФайла, Ложь, УникальныйИдентификатор);
	
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьВерсииИзОтчетаПоХранилищуПослеПомещения(Результат, АдресФайла, ВыбранноеИмяФайла, ДополнительныеПараметры) Экспорт 
	
	Если Результат <> Истина Тогда
		Возврат;
	КонецЕсли; 
	
	ЗагрузитьВерсииИзОтчетаПоХранилищуНаСервере(АдресФайла);
	
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьВерсииИзОтчетаПоХранилищуНаСервере(АдресФайла)
	
	Файл = ПолучитьИзВременногоХранилища(АдресФайла);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("mxl");
	Файл.Записать(ИмяВременногоФайла);
	
	Справочники.ВерсииХранилища.ЗагрузитьВерсииИзОтчета(Объект.Ссылка, ИмяВременногоФайла);
	
	УдалитьФайлы(ИмяВременногоФайла);
	
КонецПроцедуры

&НаСервере
Процедура СоздатьРепозиторийGitНаСервере()
	
	КонвертацияХранилища.СоздатьРепозиторийGit(Объект.Ссылка);
	
	ПроверитьНаличиеРепозитория();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьАдресРепозиторияGitНаСервере()
	
	КонвертацияХранилища.УстановитьАдресРепозиторияGit(Объект.Ссылка);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПрочитатьТекстовыйФайлНаСервере(ПутьКФайлу, Текст, ИмяФайла, КодировкаСистемы = Ложь)
	
	ОбщегоНазначения.ПрочитатьТекстовыйФайл(ПутьКФайлу, Текст, ИмяФайла, КодировкаСистемы);
	
КонецПроцедуры

#КонецОбласти
