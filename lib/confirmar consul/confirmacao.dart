import 'package:flutter/material.dart';

class ConfirmacaoConsultaScreen extends StatelessWidget {
  final String nome;
  final String data;
  final String hora;

  ConfirmacaoConsultaScreen({
    required this.nome,
    required this.data,
    required this.hora,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/fundo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Horario Marcado com Sucesso!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  SizedBox(height: 15),
                  Text('Profissional Desejado: $nome',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Data da Consulta: $data',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  SizedBox(height: 10),
                  Text('Hora da Consulta: $hora',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
