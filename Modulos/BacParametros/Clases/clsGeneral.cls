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
Public nombre           As String
Public rut              As Long
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

'Function GRABALOG(Evento As String, OpcionSistema As String, NumeroOperacion As String, TipoSwap As Integer, ValorAnterior As String, ValorUltimo As String)
'
'Dim CodEvento As String
'Dim Tablas As String
'Dim DetalleEvento As String
'
'Tablas = ""
'If Evento = "Ingreso" Then
'    ValorAnterior = ""
'    CodEvento = "01"
'    Tablas = "MovDiario-"
'ElseIf Evento = "Modificacion" Or Evento = "ModificacionCartera" Then
'    Call COMPARA_VALORES(ValorAnterior, ValorUltimo)
'    CodEvento = "02"
'End If
'
'Tablas = Tablas & "Cartera-Carteralog"
'
'DetalleEvento = Evento & " Operacion " & NumeroOperacion
'
'Select Case TipoSwap
'Case 1
'    DetalleEvento = DetalleEvento & " Swap de Tasas "
'Case 2
'    DetalleEvento = DetalleEvento & " Swap de Monedas "
'Case 3
'    DetalleEvento = DetalleEvento & " FRA "
'End Select
'DetalleEvento = DetalleEvento & "operacion N. " & NumeroOperacion
'DetalleEvento = "operacion N. " & NumeroOperacion
'
'Call COMPARA_VALORES(ValorAnterior, ValorUltimo)
'
'
'Call GRABA_LOG_AUDITORIA( _
'                           1, _
'                           Format(gsbac_fecp, "yyyymmdd"), _
'                            MISQL.HostName, _
'                            gsBAC_User, _
'                            Sistema, _
'                            OpcionSistema, _
'                            CodEvento, _
'                            DetalleEvento, _
'                            Tablas, _
'                            ValorAnterior, _
'                            ValorUltimo)
'
'End Function
'
'Public Sub GRABA_LOG_AUDITORIA(Entidad, fechaproc, _
'Terminal, Usuario, idSistema, codigoMenu, CodigoEvento, _
'DetalleModificacion, TablaInvolucrada, ValorAntiguo, ValorNuevo As String)
'
'Dim Tran As String
'
' Tran = giSQL_DatabaseCommon & "..SP_LOG_Auditoria" & " '" & Entidad & "','" & fechaproc _
'        & "', '" & Terminal & "', '" & Usuario & _
'        "', '" & idSistema & "','" & codigoMenu & "','" & CodigoEvento & "','" & DetalleModificacion & "', '" _
'        & TablaInvolucrada & "', '" & ValorAntiguo & "', '" & ValorNuevo & "'"
'
'If Not Bac_Sql_Execute(Tran) Then
'    MsgBox "Problemas al Grabar Log de Auditoria.", vbCritical
'Else
'    'grabacion exitosa
'End If
'
'End Sub
'
'
Function CierreDeMesa() As Boolean
   Dim Sql           As String
   Dim datos()

   

   If Not Bac_Sql_Execute("SP_CIERREMESA") Then
      MsgBox "No se puede realizar el cierre de mesa", vbExclamation, TITSISTEMA
      Exit Function

   End If

   Do While Bac_SQL_Fetch(datos())
   
      If datos(1) = "0" Then
         cierreMesa$ = "0"
         MsgBox "Se Ha Desactivado El Cierre de Mesa", vbInformation, TITSISTEMA
      Else
         cierreMesa$ = "1"
         MsgBox "Se Ha Realizado El Cierre de Mesa", vbInformation, TITSISTEMA
      End If
      
   Loop
   
   Call gsc_Parametros.DatosGenerales
   
   CierreDeMesa = (cierreMesa = "1")

End Function
''''''''''''''Public Function DatosGenerales() As Boolean
''''''''''''''
''''''''''''''   Dim Sql        As String
''''''''''''''   Dim DATOS()
''''''''''''''
''''''''''''''   DatosGenerales = False
''''''''''''''
''''''''''''''
''''''''''''''
''''''''''''''   If Bac_Sql_Execute("SP_DATOSGENERALES") Then
''''''''''''''
''''''''''''''      If Bac_SQL_Fetch(DATOS()) Then
''''''''''''''
''''''''''''''         Entidad = DATOS(1)
''''''''''''''         codigo = DATOS(2)
''''''''''''''         nombre = DATOS(3)
''''''''''''''         rut = Val(DATOS(4))
''''''''''''''         direccion = DATOS(5)
''''''''''''''         comuna = DATOS(6)
''''''''''''''         Ciudad = DATOS(7)
''''''''''''''         telefono = DATOS(8)
''''''''''''''         fax = DATOS(9)
''''''''''''''         FechaAnt = DATOS(10)
''''''''''''''         fechaproc = DATOS(11)
''''''''''''''         fechaprox = DATOS(12)
''''''''''''''         Numero_Operacion = DATOS(13)
''''''''''''''         rutbcch = DATOS(14)
''''''''''''''         iniciodia = DATOS(15)
''''''''''''''         libor = DATOS(16)
''''''''''''''         Paridad = DATOS(17)
''''''''''''''         tasamtm = DATOS(18)
''''''''''''''         tasas = DATOS(19)
''''''''''''''         findia = DATOS(20)
''''''''''''''         cierreMesa = DATOS(21)
''''''''''''''
''''''''''''''         DatosGenerales = True
''''''''''''''
''''''''''''''      End If
''''''''''''''   End If
''''''''''''''
''''''''''''''    DolarObs = ValorMoneda(994, fechaproc)
''''''''''''''
''''''''''''''    ValorUF = ValorMoneda(998, fechaproc)
''''''''''''''
''''''''''''''End Function

Private Sub Class_Initialize()

'Set objGeneral = New clsGeneral

End Sub

Private Sub Class_Terminate()

'Set objGeneral = Nothing

End Sub


Public Function DatosGenerales() As Boolean
Dim datos()

    DatosGenerales = False

    Envia = Array("ME")
    If Not Bac_Sql_Execute("SP_CARGAPARAMETROS_CONTROLFINANCIERO", Envia) Then
        
        End
    
    End If
    
    If Bac_SQL_Fetch(datos()) Then
        
        gsbac_fecp = Format(datos(1), gsc_FechaDMA)
        gsBAC_DolarObs = CDbl(datos(2))
        gsBAC_ValmonUF = CDbl(datos(3))
        gsBAC_Fecpx = datos(4)
        gsBAC_Clien = datos(5)
        gsBAC_DolarAcuer = CDbl(datos(6))
        giBAC_Entidad = 1
        gsBac_Version = Trim("BacTrader " & gsBAC_Clien)
        DatosGenerales = True
    
    Else
        
        MsgBox "Falla Recuperando Parametros.", 16, TITSISTEMA
        End
    
    End If

End Function


