VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGeneral"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Public objGeneral As Object
Public coleccion  As New Collection


'BacGeneral : TABLA DE PARAMETROS GENERALES
'-----------------------------------------------
Public Entidad          As String
Public codigo           As String
Public NOMBRE           As String
Public Rut              As Long
Public direccion        As String
Public comuna           As String
Public Ciudad           As String
Public telefono         As String
Public fax              As String
Public Numero_Operacion As Long
Public rutbcch          As String
Public iniciodia        As Integer
Public libor            As Integer
Public paridad          As Integer
Public tasamtm          As Integer
Public tasas            As Integer
Public findia           As Integer
Public cierreMesa       As String
Public FechaAnt
Public fechaproc
Public fechaprox
Public DolarObs         As Double
Public ValorUF          As Double

Function CierreDeMesa() As Boolean
   Dim Sql           As String
   Dim Datos()

   Sql = "EXECUTE sp_cierremesa"

   If SQL_Execute(Sql) > 0 Then
      MsgBox "No se puede realizar el cierre de mesa", vbExclamation, "Cierre de Mesa"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
   
      If Datos(1) = "0" Then
         cierreMesa$ = "0"
         MsgBox "Se Ha Desactivado El Cierre de Mesa", vbInformation, Msj
      Else
         cierreMesa$ = "1"
         MsgBox "Se Ha Realizado El Cierre de Mesa", vbInformation, Msj
      End If
      
   Loop
   
   Call gsc_Parametros.DatosGenerales
   
   CierreDeMesa = (cierreMesa = "1")

End Function
Public Function DatosGenerales() As Boolean

   Dim Sql        As String
   Dim Datos()

   DatosGenerales = False

   Sql = "EXECUTE sp_DatosGenerales"

   If SQL_Execute(Sql) = 0 Then
      
      If SQL_Fetch(Datos()) = 0 Then
         
         Entidad = Datos(1)
         codigo = Datos(2)
         NOMBRE = Datos(3)
         Rut = Val(Datos(4))
         direccion = Datos(5)
         comuna = Datos(6)
         Ciudad = Datos(7)
         telefono = Datos(8)
         fax = Datos(9)
         FechaAnt = Datos(10)
         fechaproc = Datos(11)
         fechaprox = Datos(12)
         Numero_Operacion = Datos(13)
         rutbcch = Datos(14)
         iniciodia = Datos(15)
         libor = Datos(16)
         paridad = Datos(17)
         tasamtm = Datos(18)
         tasas = Datos(19)
         findia = Datos(20)
         cierreMesa = Datos(21)
         
         DatosGenerales = True

      End If
   End If
        
    DolarObs = ValorMoneda(994, fechaproc)
   
    ValorUF = ValorMoneda(998, fechaproc)

End Function

Private Sub Class_Initialize()

'Set objGeneral = New clsGeneral

End Sub

Private Sub Class_Terminate()

'Set objGeneral = Nothing

End Sub

