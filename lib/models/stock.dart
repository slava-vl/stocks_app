class Stock {
  final String name;
  final String fullName;
  double price;
  double lastPrice;

  Stock({
    this.fullName,
    this.name='Name',
    this.lastPrice=0.0,
    this.price=0.0,
  });
}
