import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendário de Agendamento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isScheduled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário de Agendamento'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Selecione uma data:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text("${selectedDate.toLocal()}".split(' ')[0]),
              ),
              SizedBox(height: 20),
              Text(
                'Selecione um horário:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text("${selectedTime.format(context)}"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _schedule(context),
                child: Text('Agendar'),
              ),
              SizedBox(height: 20),
              if (isScheduled)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 10),
                    Text(
                      'Agendamento feito!',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isScheduled = false;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        isScheduled = false;
      });
    }
  }

  void _schedule(BuildContext context) {
    setState(() {
      isScheduled = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduledPage(
          date: selectedDate,
          time: selectedTime,
        ),
      ),
    );
  }
}

class ScheduledPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;

  ScheduledPage({required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Agendamento'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Data selecionada:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "${date.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Horário selecionado:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "${time.format(context)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
