VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsOperacionSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'--------------- Operaciones Swaps
Public nNumOper         As Long     'Número de operación
Public nCodCart         As Long     'Rut Cartera Swap
Public nCodigo          As Long     'Rut Cliente
Public nContraparte     As Long     'Rut Contraparte

Public cTipOper         As String   'Tipo Operación
Public cTipModa         As String   'Tipo de modalidad
Public cFecha           As String   'Fecha de Inicio Operación
Public cFecVcto         As String   'Fecha de Vencimiento

Public nMoneda1         As Integer  'Moneda 1
Public nMtoMda1         As Double   'Monto Moneda1
Public nEquUSD1         As Double   'Monto Moneda1 Equivalente en USD
Public nEquMda1         As Double   'Monto Moneda1 Equivalente en $
Public nParMda1         As Double   'Paridad Equivalente USD Moneda1
Public nPreMda1         As Double   'Precio Equivalente $ Moneda1
Public cTasMda1         As Integer  'Código Tasa Moneda1
Public nTasMda1         As Double   'Tasa Moneda1
Public nSprMda1         As Double   'Spread Moneda1

Public nMoneda2         As Integer  'Moneda 2
Public nMtoMda2         As Double   'Monto Moneda2
Public nEquUSD2         As Double   'Monto Moneda2 Equivalente en USD
Public nEquMda2         As Double   'Monto Moneda2 Equivalente en $
Public nParMda2         As Double   'Paridad Equivalente USD Moneda2
Public nPreMda2         As Double   'Precio Equivalente $ Moneda2
Public cTasMda2         As Integer  'Código Tasa Moneda1
Public nTasMda2         As Double   'Tasa Moneda1
Public nSprMda2         As Double   'Spread Moneda1

Public cObservacion     As String   'Observaciones

Public cLock            As String   'Operación Tomada por
Public cEstado          As String   'Estado de la Operación (Aprobada/Pendiente/Anulada)
Public cOperador        As String   'Operador que genero la operación
Public Status           As Boolean

Public nFPRecibimos     As Double   'Formas de Pago Recibimos
Public nFPPagamos       As Double   'Formas de Pago Pagamos
Public cRetiro          As String   'Tipo de Retiro Vienen/Vamos

Public Function CargarDatos() As Boolean

   Dim Sql        As String
   Dim Datos()

   CargarDatos = False

   Sql = "EXECUTE sp_leeroperacion_swap " & nNumOper

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer la operación", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
      
   Loop

   CargarDatos = True

End Function

Public Function CargarFlujos() As Boolean

   Dim Sql        As String
   Dim Datos()

   CargarFlujos = False

   Sql = "EXECUTE sp_leerflujos_swap " & nNumOper

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer Flujos de operación", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
      
   Loop

   CargarFlujos = True

End Function
