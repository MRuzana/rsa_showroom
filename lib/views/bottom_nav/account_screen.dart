
import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';

class AccountScreen extends StatelessWidget {


  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: AppBar(title: Text("Driver Profile")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/images/logo.png')as ImageProvider,
                    ),
                    const SizedBox(height: 16),
                    
                    const SizedBox(height: 8),

                    // _buildInfoRow("ID Number", driver.idNumber),
                    // _buildInfoRow("Phone", driver.phone),
                    // _buildInfoRow("Personl No", driver.personalPhoneNumber),
                    // _buildInfoRow("Cash in Hand", "₹${driver.cashInHand}"),
                    // _buildInfoRow("Driver Salary", "₹${driver.driverSalary}"),
                    // _buildInfoRow("Advance", "₹${driver.advance}"),
                    // //  _buildInfoRow("Balance Amount", "₹${driver.balanceAmount}"),
                    // // _buildInfoRow("Total Expense", "₹${driver.totalExpense}"),
                    // //  _buildInfoRow("Diesel Expense", "₹${driver.dieselExpense}"),
                    // // _buildInfoRow("Other Expense", "₹${driver.expense}"),
                    // _buildInfoRow("Reward Points", "${driver.rewardPoints}"),
                    // // _buildInfoRow("Vehicles", driver.vehicleNumbers.join(", ")),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
