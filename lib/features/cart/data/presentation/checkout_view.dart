// features/cart/data/presentation/checkout_view.dart

import 'package:bookia/core/custom_widget/custom_button.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/functions/validation_func.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:bookia/features/cart/data/gover_list.dart';
import 'package:bookia/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.totalPrice});
  final String totalPrice;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  int governorateId = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is CheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is CheckoutLoadedState) {
          Navigator.pop(context);
          showErrorDialog(context, "Order placed successfully",
              type: DialogType.success);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                context.read<HomeBloc>().add(PlaceOrderEvent(
                      name: usernameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      address: addressController.text,
                      governorateId: governorateId.toString(),
                    ));
              }
            },
            text: 'Checkout',
            textcolor: AppColor.whiteColor,
            fontsize: 24,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.primaryColor,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Total Price: ${widget.totalPrice} EGP',
                          style: gettitleTextStyle18(),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  const Divider(),
                  const Gap(20),
                  Text(
                    'Customer Information',
                    style: gettitleTextStyle18(),
                  ),
                  const Gap(15),
                  _buildTextField(
                    controller: usernameController,
                    hintText: 'Name',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your Name'
                        : null,
                  ),
                  const Gap(15),
                  _buildTextField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!emailValidation(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const Gap(15),
                  _buildTextField(
                    controller: phoneController,
                    hintText: 'Phone',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your phone number'
                        : null,
                  ),
                  const Gap(15),
                  _buildTextField(
                    controller: addressController,
                    hintText: 'Address',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your address'
                        : null,
                  ),
                  const Gap(15),
                  _buildGovernorateDropdown(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  Widget _buildGovernorateDropdown() {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primaryColor,
      ),
      child: DropdownButton(
        dropdownColor: AppColor.primaryColor,
        isExpanded: true,
        value: governorateId,
        onChanged: (value) {
          setState(() {
            governorateId = value as int;
          });
        },
        items: governorateList
            .map(
              (city) => DropdownMenuItem(
                value: city['id'],
                child: Text(city['governorate_name_en'].toString()),
              ),
            )
            .toList(),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
        ),
      ),
    );
  }
}
