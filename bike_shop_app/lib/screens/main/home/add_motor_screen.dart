import 'package:bike_shop_app/models/motor.dart';
import 'package:bike_shop_app/screens/main/home/widgets/build_header.dart';
import 'package:bike_shop_app/utils/constant.dart';
import 'package:bike_shop_app/utils/theme.dart';
import 'package:bike_shop_app/viewModels/motor_provider.dart';
import 'package:bike_shop_app/viewModels/motor_selected_value.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMotorScreen extends StatefulWidget {
  final bool isAdd;
  const AddMotorScreen({Key? key, required this.isAdd}) : super(key: key);

  @override
  State<AddMotorScreen> createState() => _AddMotorScreenState();
}

class _AddMotorScreenState extends State<AddMotorScreen> {
  final formKey = GlobalKey<FormState>();
  final nopolController = TextEditingController();
  final tahunController = TextEditingController();
  final kilometerController = TextEditingController();
  late String message;

  @override
  void initState() {
    super.initState();

    if (!widget.isAdd) {
      message = 'Update Motor';
      Future.delayed(Duration.zero, () async {
        await Provider.of<MotorProvider>(context).getMotor();
      });

      final motor = context.read<MotorProvider>().motor!;

      nopolController.text = motor.nopol!;
      tahunController.text = motor.tahun!;
      kilometerController.text = motor.kilometer == null ? '0' : motor.kilometer.toString();
    } else {
      message = 'Tambah Motor';
    }
  }

  @override
  void dispose() {
    super.dispose();
    nopolController.dispose();
    tahunController.dispose();
    kilometerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(context, message),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.08,
          MediaQuery.of(context).size.height * 0.03,
          MediaQuery.of(context).size.width * 0.08,
          0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipe Motor',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Consumer<MotorSelectedValue>(
                builder: (context, provider, _) {
                  return DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    hint: Text(
                      'Pilih motor...',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        color: primaryColor500.withOpacity(0.5),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: dropdownItems,
                    validator: (value) {
                      if (value == null) {
                        return 'Wajib pilih motor';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      provider.setMotorSelected(value.toString());
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Nomor Polisi',
                style: subtitleTextStyle,
              ),
              Text(
                'Isi data sesuai STNK',
                style: subtitleTextStyle.copyWith(fontSize: 10),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: nopolController,
                cursorColor: darkBlue300,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'contoh: B 1234 XYZ',
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: 14,
                    color: primaryColor500.withOpacity(0.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Form tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Tahun Produksi',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: tahunController,
                cursorColor: darkBlue300,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: '2021',
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: 14,
                    color: primaryColor500.withOpacity(0.5),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Form tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                'Kilometer (opsional)',
                style: subtitleTextStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextFormField(
                controller: kilometerController,
                cursorColor: darkBlue300,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Jarak tempuh (KM)',
                  hintStyle: subtitleTextStyle.copyWith(
                    fontSize: 14,
                    color: primaryColor500.withOpacity(0.5),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Consumer<MotorProvider>(
                builder: (context, value, _) {
                  String? message;
                  final isLoading = value.motorState == MotorState.loading;
                  final isError = value.motorState == MotorState.error;

                  if (isLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (isError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(message!),
                        ),
                      );
                      value.changeState(MotorState.none);
                    });
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;

                        final motor = Motor(
                          motorType: Provider.of<MotorSelectedValue>(context, listen: false).motor.toUpperCase(),
                          nopol: nopolController.text.trim().toUpperCase(),
                          tahun: tahunController.text.trim(),
                          kilometer: int.tryParse(kilometerController.text.trim()) ?? 0,
                        );

                        if (widget.isAdd) {
                          message = await value.addMotor(motor);

                          if (message == 'Success') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Tambah motor berhasil!')),
                            );
                          }
                        } else {
                          message = await value.updateMotor(motor);

                          if (message == 'Success') {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Update motor berhasil!')),
                            );
                          }
                        }
                      },
                      child: Text(
                        'Simpan',
                        style: buttonTextStyle,
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return darkBlue700;
                            }
                            return darkBlue500;
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
