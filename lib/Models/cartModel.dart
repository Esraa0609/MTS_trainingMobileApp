class Cart {
  final int? id;
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? productPrice;
  final int? quantity;
  final int? currentStock;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quantity,
    required this.unitTag,
    required this.image, 
    required this.currentStock,
  });

  Cart.fromMap(Map<dynamic, dynamic> res)
  : id = res['id'],
  productId = res['productId'],
  productName = res['productName'],
  initialPrice = res['initialPrice'],
  productPrice = res['productPrice'],
  quantity = res['quantity'],
  currentStock = res['currentStock'],
  unitTag = res['unitTag'],
  image = res['image'];

  Map<String, Object?> toMap()
  {
    return{
      'id' : id, 
      'productId' : productId,
      'productName' : productName,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'quantity' : quantity,
      'currentStock' : currentStock,
      'unitTag' : unitTag,
      'image' : image
    };
  }






}
