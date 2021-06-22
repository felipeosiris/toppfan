import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';

//Clase para ver el detalle del asiento, aquí solo fue agregar un estilo para que hiciera algo al dar click
//es importante mencionar que se reciben todos los parametros necesarios para poder generar un ticket dinamico
class SeatDetails extends StatefulWidget {
  const SeatDetails({Key key, this.columna, this.fila, this.ticket})
      : super(key: key);
  final String ticket, columna, fila;

  @override
  _SeatDetailsState createState() => _SeatDetailsState();
}

class _SeatDetailsState extends State<SeatDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        //se utilizó el package FlutterTicketWidget para ahorra tiempo :D
        child: FlutterTicketWidget(
          width: 350.0,
          height: 500.0,
          isCornerRounded: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 1.0, color: Colors.green),
                      ),
                      child: Center(
                        child: Text(
                          'America vs Chivas',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'AME',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.sports_soccer,
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'GDL',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Ticket de palco',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: <Widget>[
                      ticketDetailsWidget(
                          'Tipo', 'Personal', 'Fecha', '23-06-2021'),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                        child: ticketDetailsWidget('Ticket',
                            '${this.widget.ticket}', 'Entrada', '66B'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 40.0),
                        child: ticketDetailsWidget(
                            'Fila',
                            '${this.widget.fila}',
                            'Asiento',
                            '${this.widget.columna}'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                  child: Center(
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Codigo_QR.svg/1024px-Codigo_QR.svg.png'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 75.0, right: 75.0),
                  child: Text(
                    '9824 0972 1742 1298',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
