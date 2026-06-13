import 'package:thalorix_app/Features/marketplace/data/models/product_model.dart';

class MarketplaceLocalDataSource {
  List<ProductModel> getProducts() {
    return [
      ProductModel(
        image: "assets/images/temp_app1.jpg",
        title: "Mobile App UI",
        price: 45,
        description: "Clean modern UI template.",
        creator: "John Doe",
      ),
      ProductModel(
        image: "assets/images/temp1_app3.jpg",
        title: "Mobile App UI",
        price: 45,
        description: "Clean modern UI template.",
        creator: "John Doe",
      ),
      ProductModel(
        image: "assets/images/temp_web1.jpg",
        title: " WEB UI",
        price: 45,
        description: "Clean modern UI template.",
        creator: "John Doe",
      ),
      ProductModel(
        image: "assets/images/temp_app1.jpg",
        title: "Mobile App UI",
        price: 45,
        description: "Clean modern UI template.",
        creator: "John oe",
      ),
      ProductModel(
        image: "assets/images/temp_web6.jpg",
        title: "Mobile App UI",
        price: 45,
        description: "Clean modern UI template.",
        creator: "John Doe",
      ),
    ];
  }
}
