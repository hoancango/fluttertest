import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/4_ptbac2/native_add.dart';
import 'package:get/get.dart';

class QuadraticEquation extends StatefulWidget {
  const QuadraticEquation({super.key});

  @override
  State<QuadraticEquation> createState() => _QuadraticEquationState();
}

class _QuadraticEquationState extends State<QuadraticEquation> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final TextEditingController _controllerC = TextEditingController();
  RxDouble a = 0.0.obs;
  RxDouble b = 0.0.obs;
  RxDouble c = 0.0.obs;
  RxBool hasValidInput = false.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PT bac 2'),
      ),
      body: Obx(
        () => Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
                  ],
                  controller: _controllerA,
                  decoration: const InputDecoration(
                    hintText: 'Value of a',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giá trị';
                    }
                    if (double.tryParse(value) == null ||
                        double.tryParse(value) == 0) {
                      return 'Giá trị không hợp lệ, đảm bảo a là số hợp lệ khác 0';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
                  ],
                  controller: _controllerB,
                  decoration: const InputDecoration(
                    hintText: 'Value of b',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giá trị';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Giá trị không hợp lệ';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true, signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$'))
                  ],
                  controller: _controllerC,
                  decoration: const InputDecoration(
                    hintText: 'Value of c',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập giá trị';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Giá trị không hợp lệ';
                    }

                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final aValue = double.tryParse(_controllerA.text);
                  final bValue = double.tryParse(_controllerB.text);
                  final cValue = double.tryParse(_controllerC.text);
                  if (aValue != null &&
                      aValue != 0 &&
                      bValue != null &&
                      cValue != null) {
                    a.value = aValue;
                    b.value = bValue;
                    c.value = cValue;
                    hasValidInput.value = true;
                  }else{
                    hasValidInput.value = false;
                  }
                },
                child: Text('Tìm nghiệm'),
              ),

              SizedBox(height: 10,),

              (hasValidInput.value == true)
                  ? (solveQuadratic(a.value, b.value, c.value).hasRealSolution == 1)
                      ? Text(
                          'Phương trình có nghiệm:\n x1 = ${solveQuadratic(a.value, b.value, c.value).x1}\n x2 = ${solveQuadratic(a.value, b.value, c.value).x2}')
                      : Text('Phương trình vô nghiệm')
                  : Text('Giá trị nhập không hợp lệ'),
            ],
          ),
        ),
      ),
    );
  }
}
