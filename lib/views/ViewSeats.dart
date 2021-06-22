import 'package:flutter/material.dart';
import 'package:toppfan/models/DataRows.dart';
import 'package:get/get.dart';
import 'package:toppfan/views/SeatDetails.dart';
import 'package:toppfan/views/ViewStadiums.dart';

//esta es una clase un poco extensa donde se contruye la vista de la grada
class ViewSeats extends StatelessWidget {
  const ViewSeats({
    Key key,
    this.datos,
  }) : super(key: key);
  final DataRows datos;

  @override
  Widget build(BuildContext context) {
    //estas variables son importantes ya que dan la relación de tamaño de todos los elementos
    double width2 = 40;
    double height2 = 30;

    //el widget InteractiveViewer es importante para poder interactuar con la grada, sirve en este caso para poder hacer zoom
    return InteractiveViewer(
      panEnabled: true, // Set it to false to prevent panning.
      //boundaryMargin: EdgeInsets.all(10),
      scaleEnabled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignPanAxis: true,
      minScale: .01,
      maxScale: 30,
      //boundaryMargin: const EdgeInsets.all(double.infinity),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0C1418), Color(0xFF269AB7)],
            stops: [0, 1],
            begin: Alignment(-1, 1),
            end: Alignment(1, -1),
          ),
        ),
        //Esta parte es importante ya que a pesar de que el widget padre posee un "scroll" necesitamos el widget de SingleChildScrollView
        //para poder evitar que los widgets se desborden de la pantalla para esto se debe inhabiliar el scroll del widget padre
        //es el primero de 2 scrolls para crear la grada, es donde vive el eje Y
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 2),
                child: Column(
                  children: [
                    //dejé el titulo y el logo de estadio dentro del scroll ya que me gusta que al hacer scroll quede una pantalla limpia
                    Row(
                      children: [
                        Text(
                          'ToppFan',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.black54,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(StadiumPage());
                          },
                          child: Image.network(
                            'https://www.pngkit.com/png/full/162-1625640_clipart-resolution-10241024-dodger-stadium.png',
                            width: width2 * 2,
                            height: height2 * 2,
                          ),
                        ),
                      ],
                    ),
                    //información de lo que significa cada color de asiento
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/seat.png',
                            width: width2 * .8,
                            height: height2 * .8,
                            color: Colors.grey,
                          ),
                          Text('Ocupados'),
                          SizedBox(
                            width: width2 / 2,
                          ),
                          Image.asset(
                            'assets/images/seat.png',
                            width: width2 * .8,
                            height: height2 * .8,
                            color: Colors.green,
                          ),
                          Text('Disponibles'),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              //este widget genera el card donde se construye la grada
              _widget_view_seats(
                  width2: width2, height2: height2, datos: datos),
            ],
          ),
        ),
      ),
    );
  }
}

class _widget_view_seats extends StatelessWidget {
  const _widget_view_seats({
    Key key,
    @required this.width2,
    @required this.height2,
    @required this.datos,
  }) : super(key: key);

  final double width2;
  final double height2;
  final DataRows datos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width2 - height2),
      child: Container(
        child: Card(
          elevation: 50,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(height2),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                //en los widgets anteriores creamos los ejes para poder navegar por el widget y ver la información
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //usando un poco de estructuras (for) creamos tantas veces como sea necesario un Row para ir acomodando las columnas
                    for (var i = 0; i < datos.rows.length; i++)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //primero pintamos el eje de las filas, de igual modo dentro del scroll para que se oculte al mover
                          Text(
                            datos.rows[i].name,
                            style: TextStyle(
                              fontSize: width2 - height2,
                            ),
                          ),
                          //Este algoritmo es una tip para crear un widget nulo y que ocupe el espacio de los asientos recorridos
                          for (var k = 0;
                              k <= int.parse(datos.rows[i].seats.start);
                              k++)
                            Padding(
                              padding: EdgeInsets.all(height2 / 10),
                              child: Container(
                                width: width2,
                                height: height2,
                                child: Text(''),
                              ),
                            ),
                          //aqui creamos el algoritmos para pintar los asientos, debe iniciar en 1 ya que no hay asiento 0
                          for (var j = 1;
                              j <= int.parse(datos.rows[i].seats.total);
                              j++)
                            Padding(
                              padding: EdgeInsets.all(height2 / 10),
                              child: Container(
                                width: width2,
                                height: height2,
                                //aqui creamos el click para ir a la vista especifica del asiento y crear el ticket
                                child: InkWell(
                                  onTap: () {
                                    //usamos getX para ir a la vista e ir cerrando memoria inecesaria
                                    Get.to(
                                      () => SeatDetails(
                                        ticket: "${datos.rows[i].name}-$i-$j",
                                        columna: "$i",
                                        fila: "$j",
                                      ),
                                    );
                                  },
                                  //en un stack dibujamos el asiento y le sobreponemos su id asiento
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      //dependiendo de los onHoldSale vamos pintando de cierto color
                                      //usamos un where en la lista de los ocupado y los igualamos con el loop actual
                                      //si la lista obetina no está vacia entoces ya procedemos a pintar
                                      Image.asset(
                                        'assets/images/seat.png',
                                        color: datos.rows[i].seats.onHoldSale
                                                .where((element) =>
                                                    element == j.toString())
                                                .isNotEmpty
                                            ? Colors.grey
                                            : Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: (width2 - height2),
                                        ),
                                        child: Text(
                                          "${datos.rows[i].name}-$i-$j",
                                          style: TextStyle(
                                            fontSize: (width2 - height2) / 2,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }
}
