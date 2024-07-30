import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/view/screens/auth/login/login_screen.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/product_provider.dart';
import '../../utils/colors/app_color.dart';
import 'home_widgets/product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get the screen width dynamically
    int columns = 2;
    if (screenWidth > 600) {
      columns = 3;
    } else if (screenWidth > 900) {
      columns = 4;
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Hero(
          tag: "app_logo",
          child: Text(
            'e-Shop',
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          PopupMenuButton(
            iconColor: AppColors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("Logout"),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                ),
              ];
            },
          ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 3 / 5,
              ),
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return ProductDetails(
                  product: product,
                  showDiscountPrice: productProvider.showDiscountPrice,
                );
              },
              itemCount: productProvider.products.length,
            ),
          );
        },
      ),
    );
  }
}
