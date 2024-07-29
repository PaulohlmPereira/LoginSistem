import 'package:dvsgse/checagemPaginas/checagem_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fundo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Faça seu Cadastro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors
                        .white,
                  ),
                ),
                SizedBox(
                  height: 90,
                ),
                TextFormField(
                  controller: _nomeController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Nome Completo',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Email',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Senha',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 55),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    cadastrar();
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  cadastrar() async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if(userCredential != null) {
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => ChecagemPage()), (
            route) => false);
      }
    }on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Crie uma senha mais segura'),
            backgroundColor: Colors.redAccent,
            ),
          );

        } else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Este email ja foi cadastrado'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
    }
  }
}
