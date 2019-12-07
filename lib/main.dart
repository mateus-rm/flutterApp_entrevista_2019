import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(EntrevistaApp());

class EntrevistaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Entrevista Mateus",
      home: Pag1(),
      theme: ThemeData(textTheme: TextTheme(body1: TextStyle(fontSize: 18))),
    );
  }
}

class Pag1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Pag1();
  }
}

class _Pag1 extends State<Pag1> {
  DateTime _birthDate;
  final TextEditingController _birthDateText = new TextEditingController();
  final TextEditingController _nameText = new TextEditingController();
  final List _jobs = [
    "Programador Java",
    "Programador Python",
    "Programador Flutter",
    "Programador React"
  ];
  String _currentJob;
  List<DropdownMenuItem<String>> _jobsItens;

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String job in _jobs) {
      items.add(new DropdownMenuItem(value: job, child: new Text(job)));
    }
    return items;
  }

  @override
  void initState() {
    _jobsItens = getDropDownMenuItems();
    _currentJob = _jobsItens[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //imagem de topo
          Image.asset("assets/pag1.png"),
          Container(
            //container dos campos
            margin: EdgeInsets.all(50.0),
            child: Column(
              //coluna dos campos
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  //Full Name input
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Full Name:"),
                      TextField(
                        textAlign: TextAlign.left,
                        controller: _nameText,
                      )
                    ],
                  ),
                ),
                Container(
                  //Select job input
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("Select Job:"),
                        DropdownButton(
                          isExpanded: true,
                          value: _currentJob,
                          items: _jobsItens,
                          onChanged: (selectedJob) {
                            setState(() {
                              _currentJob = selectedJob;
                            });
                          },
                        )
                      ]),
                ),
                Container(
                  //Select birth date input
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Date of Birth:"),
                      TextField(
                          controller: _birthDateText,
                          textAlign: TextAlign.left,
                          readOnly: true,
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now())
                                .then((date) {
                              setState(() {
                                _birthDate = date;
                                _birthDateText.text =
                                    _birthDate.day.toString() +
                                        "/" +
                                        _birthDate.month.toString() +
                                        "/" +
                                        _birthDate.year.toString();
                              });
                            });
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            //icones de navegação
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                size: 32,
                color: Colors.grey,
              ),
              Icon(
                Icons.radio_button_checked,
                size: 16,
              ),
              Icon(
                Icons.radio_button_unchecked,
                size: 16,
                color: Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.play_circle_filled),
                iconSize: 32,
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  if (_birthDate != null) {
                    //apenas para não deixar o usuário avançar sem por a data
                    //colocar uma Alert Dialog seria interessante
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return Pag2(
                          _nameText.text.toString(), _currentJob, _birthDate);
                    }));
                  }
                },
              )
            ],
          )
        ],
      ),
    ));
  }
}

class Pag2 extends StatelessWidget {
  String nome, job;
  DateTime birthDate;

  @override
  Pag2(String this.nome, String this.job, DateTime this.birthDate);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //imagem de topo
          Image.asset("assets/pag2.png"),
          Container(
            //container dos campos de texto
            margin: EdgeInsets.all(50.0),
            child: Column(
              //coluna dos campos de texto
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  //container com os resultados em texto
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(nome,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(job,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                            calculateAge(birthDate).toString() + " anos",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            //icones de navegação
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.grey,
                  iconSize: 32,
                  onPressed: () {
                    Navigator.pop(context,
                        CupertinoPageRoute(builder: (context) {
                      return Pag1();
                    }));
                  }),
              Icon(
                Icons.radio_button_unchecked,
                size: 16,
                color: Colors.grey,
              ),
              Icon(
                Icons.radio_button_checked,
                size: 16,

              ),
              IconButton(
                color: Colors.blueAccent,
                icon: Icon(Icons.play_circle_filled),
                iconSize: 32,
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    ));
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
