import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';

class ProductMaster extends ConsumerStatefulWidget {
  const ProductMaster({super.key});

  @override
  ConsumerState<ProductMaster> createState() => _ProductMasterState();
}

class _ProductMasterState extends ConsumerState<ProductMaster> {
  String initialValue = AssetConstants.categoryList.isNotEmpty
      ? AssetConstants.categoryList[0] // You can choose any default value here
      : '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: AppColors.kButtonGray,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomTextRaleway(text: 'Product Master'),
                const SizedBox(
                  height: 8,
                ),
                const CustomTextPopins(
                  text: 'Fill the product details for upload to database',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextRaleway(
                    text: 'Category',
                    fontSize: 16,
                    fontColor: AppColors.kLiteBlack,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                DropdownButton<String>(
                  isDense: false,
                  isExpanded: true,
                  value: ref.read(productRiverPod).category ?? initialValue,
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: AppColors.kLiteBlack),
                  onChanged: (String? valueS) {
                    // This is called when the user selects an item.
                    setState(() {
                      ref.read(productRiverPod).category = valueS;
                    });
                  },
                  items: AssetConstants.categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Product Name',
                  hintText: 'xxxxxxxxx',
                  controller: ref.read(productRiverPod).productNameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Description',
                  hintText: 'xyz@gmail.com',
                  controller: ref.read(productRiverPod).descriptionController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Price',
                  hintText: 'xyz@gmail.com',
                  controller: ref.read(productRiverPod).priceController,
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    ref.read(productRiverPod).selectImageAndUpload();
                  },
                  child: Container(
                    height: SizeConfig.h(context) * 0.3,
                    width: SizeConfig.w(context),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        color: AppColors.kLiteBlue,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                FileImage(ref.read(productRiverPod).getImage))),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                    buttonText: 'Submit',
                    onTap: () {
                      ref
                          .read(productRiverPod)
                          .insertToProductDB()
                          .whenComplete(() =>
                              ref.read(productRiverPod).clearProductMaster());

                      setState(() {
                        ref.read(productRiverPod).isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : const SizedBox();
                      });
                    }),
              ],
            )),
      ),
    );
  }
}
