import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bmt_output_page.dart';

class BmiInputPage extends StatefulWidget {
  const BmiInputPage({Key? key}) : super(key: key);

  @override
  State<BmiInputPage> createState() => _BmiInputPageState();
}

class _BmiInputPageState extends State<BmiInputPage> {
  late TextEditingController cHeight;
  late TextEditingController cWeight;
  bool showWeight = false;

  @override
  void initState() {
    cHeight = TextEditingController();
    cWeight = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cHeight.dispose();
    cWeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: cHeight,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Input Height(cm)',
                    ),
                    validator: (value) =>
                        value != null && value.isNotEmpty ? null : '키를 입력해주세요.',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: cWeight,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Input Weight(kg)',
                    ),
                    validator: (value) => value != null && value.isNotEmpty
                        ? null
                        : '몸무게를 입력해주세요.',
                    obscureText: showWeight,
                  ),
                  const SizedBox(height: 20),
                  CupertinoSwitch(
                    value: showWeight,
                    onChanged: (value) => setState(() {
                      showWeight = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  Text('Weight : ${showWeight ? '****' : 'digit'}'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final cm = int.parse(cHeight.text);
                              final kg = int.parse(cWeight.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BmiOutputPage(
                                      bmi: kg / pow(cm / 100, 2))));
                            }
                          },
                          child: const Text('Calculation'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
