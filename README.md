# Приложение для отборочного этапа Волга-IT 2022
Приложение создано в качестве решения домашнего задание для конкурса Волга-IT. Первый раз запариваюсь, чтобы оформить файл `readme.md`, надеюсь вы это прочтете. Во всяком случае в конце важная информация, необходимая, чтобы вы могли корректно собрать проект.

## Оглавление

- [Приложение для отборочного этапа Волга-IT 2022](#приложение-для-отборочного-этапа-волга-it-2022)
  - [Оглавление](#оглавление)
  - [Работа с Finnhub Stock API](#работа-с-finnhub-stock-api)
    - [Созданные методы](#созданные-методы)
      - [`connectToStockSocket`](#connecttostocksocket)
      - [`getStockInfo`](#getstockinfo)
      - [`getMarketNews`](#getmarketnews)
      - [`getCompanyInformation`](#getcompanyinformation)
      - [`getCompanyNews`](#getcompanynews)
  - [Отображение списка акций](#отображение-списка-акций)
  - [Оптимизация](#оптимизация)
  - [Дополнительные плюшки](#дополнительные-плюшки)
  - [Как запустить код?](#как-запустить-код)

## Работа с Finnhub Stock API
Для работы с предоставленным сервисом создан абстрактный класс `Api`.

### Созданные методы
- [connectToStockSocket](#connecttostocksocket)
- [getStockInfo](#getstockinfo)
- [getMarketNews](#getmarketnews)
- [getCompanyInformation](#getcompanyinformation)
- [getCompanyNews](#getcompanynews)

#### `connectToStockSocket`
Метод необходимый для подключения к веб-сокету.
```Dart
Uri.parse('wss://ws.finnhub.io?token=$apiKey')
```

#### `getStockInfo`
Метод необходимый для получения основной информации по акции(здесь больше интересовала последняя цена и цена на начало торгов).
```Dart
Uri.parse('https://finnhub.io/api/v1/quote?symbol=${stock.name}&token=$apiKey')
```

#### `getMarketNews`
Метод необходимый для получения последних новостей маркета.
```Dart
Uri.parse('https://finnhub.io/api/v1/news?category=general&token=$apiKey')
```

#### `getCompanyInformation`
Метод необходимый для получения основной информации о комании.
```Dart
Uri.parse('https://finnhub.io/api/v1/stock/profile2?symbol=$symbol&token=$apiKey')
```

#### `getCompanyNews`
Метод необходимый для получения последних новостей комании.
```Dart
Uri.parse('https://finnhub.io/api/v1/company-news?symbol=$symbol&from=${DateTime.now().subtract(Duration(days: 7)).toString().split(' ')[0]}&to=${DateTime.now().toString().split(' ')[0]}&token=$apiKey')
```

## Отображение списка акций
Акции хранятся и изменяются в провайдере `StocksProvider` предоставляющем данные по всему приложению. Для отображения используется `ListView`, однако не обычный, а анимированный - `AnimatedList`:
<img src='https://user-images.githubusercontent.com/61556435/171033849-5e93686a-5684-46ba-8e16-d9a7e5d9927a.png' width=300>
```Dart
AnimatedList(
      key: _key,
      scrollDirection: Axis.vertical,
      initialItemCount: insertedItems.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index, animation) {
        return SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.2),
              end: const Offset(0, 0),
            ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: StockWidget(widget.stocks[index])));
      },
    );
```

## Оптимизация
Прослушывание информации одновременно по всем акциям сильно затрудняет работу приложения. Это становится более заметным, когда количество переваливает за 15. Чтобы избежать ненужных фризов будем прослушивать только те акции, которые видны в данный момент на экране. `ListView` как раз нам для этого и нужен. Как известно, одним из его отличий от `SingleChildScrollView` в связке с `Column` является оптимизация отображения виджетов(отображаются и хранятся в памяти только те, которые видны на экране, или близки к этому). Всё что нам сейчас необходимо сделать, так это привязать прослушку акции к её наличию на экране пользователя.

Чтобы это сделать, каждый виджет сделаем Stateful и переопределим у них два метода `initState` и `dispose`:
```Dart
@override
  void initState() {
    provider.listenStock(widget.stock.name);
    super.initState();
  }

  @override
  void dispose() {
    provider.notListenStock(widget.stock.name);
    super.dispose();
  }
 ```
Теперь прослушиваться будут лишь те акции, что видны на экране. Чтобы продемонстрировать работу такого решения, сверху над списком акции создан `pager`, изменения в данных которого не связано с его наличием на экране. В `pager` добавлены три акции. Изначально цены на них будут меняться, т.к. в основном списке они тоже видны, однако если мы пролистаем вниз, изменения прекратятся, акции, что более не видны не прослушиваются.

<img src='https://user-images.githubusercontent.com/61556435/171038788-6865f268-b025-4cc2-9ae6-20c415e2e01d.png' width=400>


## Дополнительные плюшки
Исходя из предоставленных вначале методах класса `Api`, и так понятен доп.функционал. Чтобы не растягивать просто добавлю скрины:

<img src='https://user-images.githubusercontent.com/61556435/171039041-f4be7e3e-8a28-4cc6-b74a-3fc5938ff5cc.png' width=300><img src='https://user-images.githubusercontent.com/61556435/171039077-6fafdb3e-ec5f-4894-8956-095b94fe46ee.png' width=300><img src='https://user-images.githubusercontent.com/61556435/171039101-b943ce06-e0f3-461b-8e12-473c06c39bec.png' width = 300>

## Как запустить код?
**Важно!!!!** Чтобы приложение заработало необходимо добавить в папку `lib` файл с именем `apiKey.dart`, в котором создайте просто переменную с именем `apiKey` и значением вашего ключа с finnhub.