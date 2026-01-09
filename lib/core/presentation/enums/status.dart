/// ------------------------------------------------------------
/// Status
/// ------------------------------------------------------------
///
/// Enumeración que representa el estado de una operación
/// asíncrona dentro de la aplicación.
/// ------------------------------------------------------------
/// Valores:
/// ------------------------------------------------------------
/// - `ready`
///   Estado inicial o inactivo.
///
/// - `loading`
///   Indica que la operación se encuentra en proceso.
///
/// - `success`
///   Indica que la operación finalizó correctamente.
///
/// - `error`
///   Indica que ocurrió un error durante la operación.
/// ------------------------------------------------------------
enum Status {
  ready,
  loading,
  success,
  error,
}
