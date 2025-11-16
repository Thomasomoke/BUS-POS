import 'package:bus_pos/common/widgets/app_button.dart';
import 'package:bus_pos/common/widgets/select_input.dart';
import 'package:bus_pos/common/widgets/textfield_widget.dart';
import 'package:bus_pos/core/config/extensions.dart';
import 'package:bus_pos/features/booking/models/enum.dart';
import 'package:bus_pos/features/booking/providers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _nationalityController = TextEditingController();
  final FocusNode _nationalityFocus = FocusNode();
  final TextEditingController _idController = TextEditingController();
  final FocusNode _idFocus = FocusNode();
  final TextEditingController _ageController = TextEditingController();
  final FocusNode _ageFocus = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    _phoneController.dispose();
    _phoneFocus.dispose();
    _nationalityController.dispose();
    _nationalityFocus.dispose();
    _idController.dispose();
    _idFocus.dispose();
    _ageController.dispose();
    _ageFocus.dispose();
    super.dispose();
  }

  void confirmBooking() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
    } else {
      debugPrint("Validation failed");
    }
  }

  PaymentMethod paymentMethod = PaymentMethod.mpesa;
  Gender gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, provider, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 8.0,
                    children: [
                      Text(
                        "Passenger Details",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextfieldWidget(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        hintText: "John Kinyanjui",
                        isLoading: provider.isLoading,
                        nextFocusNode: _phoneFocus,
                        labelText: "Passenger",
                      ),
                      SelectInput(
                        padding: 5,
                        iconsize: 24,
                        placeholder: gender.name.toSentenceCase(),
                        items: Gender.values
                            .map((value) => value.name)
                            .toList(),
                        onSelect: (item) {
                          setState(() {
                            gender = Gender.values.byName(item);
                          });
                        },
                      ),
                      TextfieldWidget(
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        hintText: "07#########",
                        isLoading: provider.isLoading,
                        nextFocusNode: _ageFocus,
                        labelText: "Phone Number",
                        minimumCharacters: 10,
                        keyboardType: TextInputType.number,
                      ),
                      TextfieldWidget(
                        controller: _ageController,
                        focusNode: _ageFocus,
                        hintText: "18",
                        isLoading: provider.isLoading,
                        nextFocusNode: _nationalityFocus,
                        labelText: "Age",
                        keyboardType: TextInputType.number,
                      ),
                      TextfieldWidget(
                        controller: _nationalityController,
                        focusNode: _nationalityFocus,
                        hintText: "Kenyan",
                        isLoading: provider.isLoading,
                        nextFocusNode: _idFocus,
                        labelText: "Nationality",
                        isRequired: false,
                      ),
                      TextfieldWidget(
                        controller: _idController,
                        focusNode: _idFocus,
                        hintText: "12345678",
                        isLoading: provider.isLoading,
                        labelText: "Identification",
                        isRequired: false,
                      ),
                      SelectInput(
                        padding: 5,
                        iconsize: 24,
                        placeholder: paymentMethod.name.toSentenceCase(),
                        items: PaymentMethod.values
                            .map((value) => value.name)
                            .toList(),
                        onSelect: (item) {
                          setState(() {
                            paymentMethod = PaymentMethod.values.byName(item);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                isLoading: provider.isLoading,
                onPressed: () => confirmBooking(),
                text: "Process Booking",
              ),
            ],
          ),
        );
      },
    );
  }
}
