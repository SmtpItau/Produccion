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
Public Nombre           As String
Public Rut              As Long
Public direccion        As String
Public COMUNA           As String
Public CIUDAD           As String
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

Private Sub Class_Initialize()

'Set objGeneral = New clsGeneral

End Sub

Private Sub Class_Terminate()

'Set objGeneral = Nothing

End Sub


Public Function DatosGenerales() As Boolean
Dim Datos()

    DatosGenerales = False

    Envia = Array("ME")
    If Not BAC_SQL_EXECUTE("sp_CargaParametros_ControlFinanciero", Envia) Then
        
        End
    
    End If
    
    If BAC_SQL_FETCH(Datos()) Then
        
        gsbac_fecp = Format(Datos(1), gsc_FechaDMA)
        gsBAC_DolarObs = CDbl(Datos(2))
        gsBAC_ValmonUF = CDbl(Datos(3))
        gsBAC_Fecpx = Datos(4)
        gsBAC_Clien = Datos(5)
        gsBAC_DolarAcuer = CDbl(Datos(6))
        giBAC_Entidad = 1
        
        DatosGenerales = True
    
    Else
        
        MsgBox "Falla Recuperando Parametros.", 16
        End
    
    End If

End Function


