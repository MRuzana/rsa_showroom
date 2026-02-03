import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/constants/spacing_constants.dart';
import 'package:rsa_showroom/core/utils/base_scafold.dart';
import 'package:rsa_showroom/core/validators.dart';
import 'package:rsa_showroom/services/booking_services.dart';
import 'package:rsa_showroom/views/widgets/button.dart';
import 'package:rsa_showroom/views/widgets/dropdown.dart';
import 'package:rsa_showroom/views/widgets/text_field.dart';

class AddBookings extends StatefulWidget {
  const AddBookings({super.key});

  @override
  State<AddBookings> createState() => _AddBookingsState();
}

class _AddBookingsState extends State<AddBookings> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vehicleNumberController =
      TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  String? selectedType;
  late String fileNumber;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    selectedType = 'Service Center';
    final number = generateFileNumber();
    fileNumber = 'SHOWROOM - $number';
  }

  String generateFileNumber() {
    final random = Random();
    return random.nextInt(1000).toString().padLeft(3, '0');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: AppBar(
          //  automaticallyImplyLeading: false,
          title: const Text('Enter booking details'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("Booking ID : ", style: _redBoldStyle()),
                    // kHeight20,
                    Text("File Number : $fileNumber", style: _redBoldStyle()),
                    kHeight10,
                    dropdownField<String>(
                      value: selectedType,
                      labelText: 'Select service',
                      items: const [
                        DropdownMenuItem(
                            value: 'Service Center',
                            child: Text('Service Center')),
                        DropdownMenuItem(
                            value: 'Body Shops', child: Text('Body Shops')),
                        DropdownMenuItem(
                            value: 'Showrooms', child: Text('Showrooms')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                    ),
                    kHeight10,
                    textField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        labelText: "Enter name",
                        validator: (value) => Validator.validateNotEmpty(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        suffixIcon: Icon(Icons.person)),
                    kHeight10,
                    textField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        labelText: "Enter phone number",
                        validator: (value) => Validator.validateNotEmpty(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        suffixIcon: Icon(Icons.call)),
                    kHeight10,
                    textField(
                        controller: _vehicleNumberController,
                        keyboardType: TextInputType.name,
                        labelText: "Enter vehicle number",
                        validator: (value) => Validator.validateNotEmpty(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        suffixIcon: Icon(Icons.directions_bus)),
                    kHeight10,
                    textField(
                        controller: _commentsController,
                        keyboardType: TextInputType.name,
                        minLines: 3,
                        maxLines: 3,
                        labelText: "Comments",
                        validator: (value) => Validator.validateNotEmpty(value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        suffixIcon: Icon(Icons.comment)),
                    kHeight10,
                    button(
                      buttonText: _isSubmitting ? 'SUBMITTING...' : 'SUBMIT',
                      color:
                          _isSubmitting ? Colors.grey : const Color(0xFFFF0000),
                      buttonPressed: _isSubmitting
                          ? null // 👈 disables button
                          : () async {
                              // Validate form
                              if (!_formKey.currentState!.validate()) return;

                              if (selectedType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please select service category"),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _isSubmitting = true;
                              });

                              final success = await BookingService().addBooking(
                                fileNumber: fileNumber,
                                customerName: _nameController.text.trim(),
                                mob1: _phoneController.text.trim(),
                                serviceCategory: selectedType!,
                                customerVehicleNumber:
                                    _vehicleNumberController.text.trim(),
                                comments: _commentsController.text.trim(),
                                showroom: "694cc84328153b3d845b49ff",
                              );

                              setState(() {
                                _isSubmitting = false;
                              });

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Booking added successfully.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Future.delayed(const Duration(seconds: 1), () {
                                  if (!mounted) return;
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/home',
                                    (route) => false,
                                  );
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to add booking"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _redBoldStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.red,
      fontSize: 15,
    );
  }
}
