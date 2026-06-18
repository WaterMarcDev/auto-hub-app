import 'package:auto_hub_app/core/theme/app_colors.dart';
import 'package:auto_hub_app/core/theme/app_text_styles.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/models/address_model.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/widgets/address_text_field.dart';
import 'package:auto_hub_app/features/your_addresses/presentation/widgets/address_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressForm extends StatefulWidget {
  final AddressModel? initialAddress;
  final void Function(AddressModel) onSave;

  const AddressForm({
    this.initialAddress,
    required this.onSave,
    super.key,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedType;
  late final TextEditingController _labelController;
  late final TextEditingController _streetController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _zipController;

  @override
  void initState() {
    super.initState();
    final address = widget.initialAddress;
    _selectedType = address?.type ?? 'home';
    _labelController = TextEditingController(text: address?.label ?? '');
    _streetController = TextEditingController(text: address?.streetAddress ?? '');
    _cityController = TextEditingController(text: address?.city ?? '');
    _stateController = TextEditingController(text: address?.state ?? '');
    _zipController = TextEditingController(text: address?.zip ?? '');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressModel(
        id: widget.initialAddress?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        type: _selectedType,
        label: _labelController.text.trim(),
        streetAddress: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim().toUpperCase(),
        zip: _zipController.text.trim(),
        isDefault: widget.initialAddress?.isDefault ?? false,
      );
      widget.onSave(address);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.initialAddress != null;
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onboardingSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: keyboardInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom Sheet Drag Handle
              SizedBox(height: 12.h),
              Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),

              // Title and Close Button Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditMode ? 'Edit Address' : 'Add Address',
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: AppColors.onboardingTextPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: AppColors.onboardingSurfaceLight,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                            width: 0.8,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.close,
                          size: 16.sp,
                          color: AppColors.onboardingTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Form Fields
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Type Selection
                        AddressTypeSelector(
                          selectedType: _selectedType,
                          onTypeSelected: (type) {
                            setState(() {
                              _selectedType = type;
                              // Default label values if empty
                              if (_labelController.text.trim().isEmpty) {
                                if (type == 'home') {
                                  _labelController.text = 'Home';
                                } else if (type == 'work') {
                                  _labelController.text = 'Work';
                                }
                              }
                            });
                          },
                        ),
                        SizedBox(height: 20.h),

                        // Label Input
                        AddressTextField(
                          label: 'Label',
                          hintText: 'e.g. Home, Mom\'s House',
                          controller: _labelController,
                          textCapitalization: TextCapitalization.words,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter a label for this address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18.h),

                        // Street Address Input
                        AddressTextField(
                          label: 'Street Address',
                          hintText: 'Street address',
                          controller: _streetController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Please enter the street address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 18.h),

                        // City, State, Zip Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // City Field
                            Expanded(
                              flex: 4,
                              child: AddressTextField(
                                label: 'City',
                                hintText: 'City',
                                controller: _cityController,
                                textCapitalization: TextCapitalization.words,
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),

                            // State Field
                            Expanded(
                              flex: 2,
                              child: AddressTextField(
                                label: 'State',
                                hintText: 'ST',
                                controller: _stateController,
                                textCapitalization: TextCapitalization.characters,
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  if (val.trim().length != 2) {
                                    return '2 letters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),

                            // Zip Field
                            Expanded(
                              flex: 3,
                              child: AddressTextField(
                                label: 'Zip',
                                hintText: 'ZIP',
                                controller: _zipController,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        // Submit Button
                        GestureDetector(
                          onTap: _submit,
                          child: Container(
                            width: double.infinity,
                            height: 52.h,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.onboardingCyan,
                                  AppColors.onboardingCyanDark,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(26.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.onboardingCyan.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 12,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              isEditMode ? 'Save Changes' : 'Add Address',
                              style: AppTextStyles.button.copyWith(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
