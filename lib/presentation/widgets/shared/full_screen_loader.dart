import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    
    const messages = <String>[
      'Cargando Pelicula',
      'Comprando Palomitas de maiz',
      'Llamando a mi novia',
      'Cargando Informacion',
      'Buscando a mi novia',
      'Ya casi ...',
      'Esto esta tardando mas de lo esperado :c',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere porfavor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeAlign: 2,),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            }
          )
        ],
      ),
      );
  }
}