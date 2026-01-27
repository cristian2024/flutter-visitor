import 'package:flutter/material.dart';

/// ------------------------------------------------------------
/// AlertSuccessfulPurchase
/// ------------------------------------------------------------
///
/// Widget de diálogo que muestra una confirmación visual
/// cuando se realiza una compra exitosa.
/// ------------------------------------------------------------
/// Funcionalidad:
/// ------------------------------------------------------------
/// - Muestra un ícono de éxito (check).
/// - Presenta un mensaje de confirmación al usuario.
/// - Ofrece un botón para cerrar el diálogo.
/// ------------------------------------------------------------
/// Uso:
/// ------------------------------------------------------------
/// Se recomienda mostrar este diálogo mediante `showDialog`:
///
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => const AlertSuccessfulPurchase(),
/// );
/// ```
/// ------------------------------------------------------------
class AlertSuccessfulPurchase extends StatelessWidget {
  const AlertSuccessfulPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 64,
              color: Colors.green.shade600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '¡Compra exitosa!',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Tu pedido ha sido procesado correctamente.',
            style: textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // actions: [
      //   SizedBox(
      //     width: double.infinity,
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       style: ElevatedButton.styleFrom(
      //         padding: const EdgeInsets.symmetric(vertical: 12),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //       ),
      //       child: const Text('Aceptar'),
      //     ),
      //   ),
      // ],
    );
  }
}