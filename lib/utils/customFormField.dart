import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormField extends StatelessWidget {
  final String campo;
  final TextEditingController controlador;
  final String? mask;

  const CustomTextFormField({
    Key? key,
    required this.campo,
    required this.controlador,
    this.mask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maskFormatter = mask != null ? MaskTextInputFormatter(mask: mask) : null;

    return TextFormField(
      controller: controlador,
      inputFormatters: maskFormatter != null ? [maskFormatter] : [],
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(200)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        hintText: campo,
        label: Text(campo),
      ),
      textAlign: TextAlign.center,
      validator: (name) => name!.length < 3 ? 'Nome deve ser maior que 3 dígitos' : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
