import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toppfan/views/ViewSeats.dart';
import 'data/api.dart';
import 'models/DataRows.dart';

void main() => runApp(MyApp());

//Iniciamos con la clase default MyApp dado que es un demo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Utilizamos GetMaterialApp para poder usar el gestor de estados getX dentro del flujo
    return GetMaterialApp(
      title: 'ToppFan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      //Como home llamamos al widget Stadium que lo que hace es hacer una pequeña validación de vistas
      home: Stadium(),
    );
  }
}

class Stadium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //dentro de este contenedor lo que hacemos es cargar la información del endpoint que venia en el documento de la prueba técnica
          child: FutureBuilder<DataRows>(
            //loadRows es un future que va al api y obtiene la información que se necesita para pintar la grada
            future: loadRows(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              //simplemente retornamos un widget que construya la vista de la grada y le pasamos como parametro el modelo con la info del endpoint
              return snapshot.hasData
                  ? ViewSeats(datos: snapshot.data)
                  : Center(
                      child: Column(
                        children: [
                          Image.asset('assets/images/splash.gif'),

                          //mientras la info se obtiene inluimos un widget de carga y una imagen para simular un splash
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
            },
          ),
        ),
      ), //VistaInteractiva(),
    );
  }
}
