import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/features/add_property/presentation/pages/add_property_page.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/widgets/manage_button.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/widgets/overview_card.dart';
import 'package:house_rental_flutter/src/features/admin_dashboard/presentation/pages/widgets/property_value_card.dart';
import 'package:house_rental_flutter/src/features/manage_users/presentation/pages/manage_users_page.dart';
import '../provider/house_provider.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(title: Text("Admin Dashboard"),
        backgroundColor: Colors.white,
      ),  
      body: statsAsync.when(
        data: (stats) => SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back, Admin", style: TextStyle(fontSize: 22)),
              Text("Admin Dashboard", style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 24),
              Text("Overview", style: TextStyle(color: Colors.black)),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OverviewCard(
                    icon: Icons.home,
                    label: "Total Properties",
                    count: stats['total'],
                    borderColor: Colors.blue,
                  ),
                  SizedBox(height: 12),
                  OverviewCard(
                    icon: Icons.sell,
                    label: "For Sale",
                    count: stats['forSale'],
                    borderColor: Colors.red,
                  ),
                  SizedBox(height: 12),
                  OverviewCard(
                    icon: Icons.home,
                    label: "For Rent",
                    count: stats['forRent'],
                    borderColor: Colors.green,
                  ),
                ],
              ),  

              SizedBox(height: 16),
              Text("Property Value"),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: PropertyValueCard(title: "Total Sale Value", value: "ETB ${stats['saleValue']}", bgColor: Colors.red.shade100)),
                  SizedBox(width: 8),
                  Expanded(child: PropertyValueCard(title: "Monthly Rental Income", value: "ETB ${stats['rentValue']}/mo", bgColor: Colors.blue.shade100)),
                ],
              ),
              SizedBox(height: 16),
              Text("Management"),
              SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: ManageButton(icon: Icons.home, label: "Manage Properties", onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddPropertyPage()));})),
                    SizedBox(width: 16),
                    Expanded(child: ManageButton(icon: Icons.group, label: "Manage Users", onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUsersPage()));})),
                  ],
                ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: (){}, child: Text("Add New Property",style: TextStyle(color: Colors.white),)))
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
