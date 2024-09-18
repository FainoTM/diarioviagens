import 'package:flutter/material.dart';

import '../service/databaseOperations.dart';
import '../utils/customFormField.dart';

class CadastroPessoa extends StatefulWidget {
  const CadastroPessoa({super.key});

  @override
  State<CadastroPessoa> createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {


  TextEditingController controller_nome = TextEditingController();
  TextEditingController controller_email = TextEditingController();
  TextEditingController controller_cpf = TextEditingController();
  TextEditingController controller_datanasc = TextEditingController();
  TextEditingController controller_fone = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Pessoas', style: TextStyle(color: Colors.white),
      ),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 50),
            child: Column(
              children: [
                CustomTextFormField(campo: 'Nome Completo', controlador: controller_nome),
                SizedBox(height: 10,),
                CustomTextFormField(campo: 'Email', controlador: controller_email),
                SizedBox(height: 10,),
                CustomTextFormField(campo: 'CPF', controlador: controller_cpf, mask: '###.###.###-##',),
                SizedBox(height: 10,),
                CustomTextFormField(campo: 'Data de Nascimento', controlador: controller_datanasc, mask: '##/##/####',),
                SizedBox(height: 10,),
                CustomTextFormField(campo: 'Telefone', controlador: controller_fone, mask: '(##) # ####-####',),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () {
                  DatabaseOperationsFirebase().createNewUserFirebase(controller_nome.text, controller_email.text,
                      controller_cpf.text, controller_datanasc.text, controller_fone.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastrado com sucesso!!')));
                },
                    child: Text('Cadastrar', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),)
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
