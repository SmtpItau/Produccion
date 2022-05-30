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
Public Codigo           As String
Public Nombre           As String
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
Public Paridad          As Integer
Public tasamtm          As Integer
Public tasas            As Integer
Public findia           As Integer
Public cierreMesa       As String
Public FechaAnt
Public fechaproc
Public fechaprox
Public DolarObs         As Double
Public ValorUF          As Double
Public Devengo       As Integer
Public Contabilidad      As Integer
Public CantidadReg   As Integer
Public notaria As String
Public fecha_escritura_bco As String
Public digrut As String
Public RutComDer As String      'PRD19111 ComDer
Public ActivaComder As String   'PRD19111 ComDer


Function CambiaFlags(nOpcion As Integer, nValor As Integer)
    Envia = Array()
    AddParam Envia, nOpcion
    AddParam Envia, nValor

    If Not Bac_Sql_Execute("SP_CAMBIAFLAGS", Envia) Then
      MsgBox "No se puede actualizar registro de control", vbExclamation, TITSISTEMA
      Exit Function
      
   End If

    Call DatosGenerales

End Function

Function CierreDeMesa() As Boolean
   Dim SQL           As String
   Dim Datos()
   Dim nCierre       As Integer

'   Sql = "EXECUTE sp_cierremesa"
    Envia = Array()

    If Not Bac_Sql_Execute("SP_CIERREMESA", Envia) Then
      MsgBox "No se puede realizar el cierre de mesa", vbExclamation, "Cierre de Mesa"
      Exit Function
      
   End If

   Do While Bac_SQL_Fetch(Datos())
      
      If Datos(1) = "0" Then
         cierreMesa$ = "0"
         nCierre = 0
      ElseIf Datos(1) = "1" Then
         If Datos(2) <> "" Then
             MsgBox Datos(2), vbOKOnly, Msj
         End If
         cierreMesa$ = "1"
         nCierre = 1
      ElseIf Datos(1) = "-1" Then
         MsgBox Datos(2), vbCritical, Msj
         nCierre = 2
      End If
      
   Loop
     
   Call gsc_Parametros.DatosGenerales
   CierreDeMesa = (cierreMesa = "1")
   
 ' 20090120 - Se agrega por control de req. Interfaz Art.84
   If nCierre = 0 Then
      Call GRABA_LOG_AUDITORIA("Opc_20700", "01", "Graba Cierre de Mesa", "", "Mesa Cerrada", "Mesa Abierta")
   ElseIf nCierre = 1 Then
      Call GRABA_LOG_AUDITORIA("Opc_20700", "01", "Graba Cierre de Mesa", "", "Mesa Abierta", "Mesa Cerrada")
   Else
      Call GRABA_LOG_AUDITORIA("Opc_20700", "01", "Graba Cierre de Mesa", "", "Mesa Abierta", "Existen Operaciones Con Problemas (lim. o feriados), No se Puede Cerrar la Mesa; Mesa Abierta")
   End If
   
   
End Function
Public Function DatosGenerales() As Boolean

   Dim SQL        As String
   Dim Datos()

   DatosGenerales = False
   
   If Bac_Sql_Execute("SP_DATOSGENERALES") Then

      If Bac_SQL_Fetch(Datos()) Then
                  
         Entidad = Datos(1)
         Codigo = Datos(2)
         Nombre = Datos(3)
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
         iniciodia = Val(Datos(15))
         libor = Datos(16)
         Paridad = Datos(17)
         tasamtm = Datos(18)
         tasas = Datos(19)
         findia = Val(Datos(20))
         cierreMesa = Val(Datos(21))
         gsBAC_Codigo = Datos(22)
         Devengo = Datos(23)
         Contabilidad = Datos(24)
         CantidadReg = Datos(25)
         fecha_escritura_bco = Datos(26)
         notaria = Datos(27)
         digrut = Datos(28)
         RutComDer = Datos(29)      'PRD19111 ComDer
         ActivaComder = Datos(30)   'PRD19111 ComDer

         DatosGenerales = True

      End If
   
   End If
        
    DolarObs = ValorMoneda(994, fechaproc)
   
    ValorUF = ValorMoneda(998, fechaproc)
    
    Call RefrescaCheck

End Function

Function RefrescaCheck()

         BACSwap.Opc_20700.Checked = cierreMesa
         BACSwap.Opc_20701.Checked = cierreMesa
         BACSwap.Opc_50100.Checked = Devengo
         BACSwap.Opc_50300.Checked = Contabilidad
         BACSwap.Opc_70100.Checked = findia
         BACSwap.Opc_10100.Checked = iniciodia
         
End Function
