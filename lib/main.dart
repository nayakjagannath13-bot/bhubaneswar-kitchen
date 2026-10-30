
import 'package:flutter/material.dart';

void main() {
  runApp(const BhubaneswarKitchen());
}

class BhubaneswarKitchen extends StatelessWidget {
  const BhubaneswarKitchen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhubaneswar Kitchen',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const KitchenHome(),
    );
  }
}

class KitchenHome extends StatefulWidget {
  const KitchenHome({super.key});

  @override
  State<KitchenHome> createState() => _KitchenHomeState();
}

class _KitchenHomeState extends State<KitchenHome> {
  int page = 0;
  int cart = 0;

  final List<Map<String, dynamic>> foods = [
    {'name': 'Veg Thali', 'price': 99, 'emoji': '🍛'},
    {'name': 'Chicken Thali', 'price': 149, 'emoji': '🍗'},
    {'name': 'Egg Curry Rice', 'price': 99, 'emoji': '🍳'},
    {'name': 'Paneer Masala', 'price': 129, 'emoji': '🥘'},
    {'name': 'Chicken Biryani', 'price': 159, 'emoji': '🍚'},
    {'name': 'Dal Rice', 'price': 69, 'emoji': '🍲'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: const Text('Bhubaneswar Kitchen'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Cart items: $cart')),
              );
            },
            icon: Badge(
              label: Text('$cart'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: page == 0 ? customerPage() : adminPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (index) {
          setState(() => page = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Customer',
          ),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      ),
    );
  }

  Widget customerPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delicious Food, Delivered!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Fresh Veg & Non-Veg Meals',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Our Food Menu',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...foods.map((food) => Card(
          child: ListTile(
            leading: Text(
              food['emoji'],
              style: const TextStyle(fontSize: 35),
            ),
            title: Text(
              food['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('₹${food['price']}'),
            trailing: FilledButton(
              onPressed: () {
                setState(() => cart++);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${food['name']} added to cart'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ),
        )),
        const SizedBox(height: 15),
        Text('Cart: $cart items'),
      ],
    );
  }

  Widget adminPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
            title: const Text('Total Menu Items'),
            trailing: Text('${foods.length}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.green),
            title: const Text('Cart Items'),
            trailing: Text('$cart'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.location_on, color: Colors.red),
            title: Text('Business Location'),
            subtitle: Text('Pokhariput, Bhubaneswar, Odisha'),
          ),
        ),
        const Card(
          child: ListTile(
            leading: Icon(Icons.phone, color: Colors.blue),
            title: Text('Customer Support'),
            subtitle: Text('9078195728'),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Food Menu Management',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...foods.map((food) => ListTile(
          title: Text(food['name']),
          trailing: Text('₹${food['price']}'),
        )),
      ],
    );
  }
}
