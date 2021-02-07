import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoControl = TextEditingController();
  TextEditingController alturaControl = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetField(){
    setState(() {
      pesoControl.text =  "";
      alturaControl.text = "";
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();

    });
  }

  void _calcular(){
    setState(() {
      if(_formKey.currentState.validate()){
        double peso = double.parse(pesoControl.text);
        double altura = double.parse(alturaControl.text)/100;
        double imc = peso/(altura*altura);
        mudarTexto(imc);
      }
    });
  }

  void mudarTexto(double imc){

    if(imc < 18.6){
      _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
    }
    else if(imc < 24.9){
      _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
    }
    else if(imc < 29.9){
      _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
    }
    else if(imc < 34.9){
      _infoText = "Obesidade de grau I (${imc.toStringAsPrecision(3)})";
    }
    else if(imc < 39.9){
      _infoText = "Obesidade de grau II (${imc.toStringAsPrecision(3)})";
    }
    else{
      _infoText = "Obesidade de grau III (${imc.toStringAsPrecision(3)})";
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(icon:Icon(Icons.refresh),
          onPressed: _resetField   
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline, size: 120, color: Colors.black),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
                controller: pesoControl,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.black)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 25),
                controller: alturaControl,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:10,bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: _calcular,
                    child:Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.black,
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black ,fontSize: 25),)
            ],
          ),
        ),
      ),
    );
  }
}