VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsConsultasSwaps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'*** Variables para traspaso de datos a procedimiento
Public Operacion As Integer
Public TipOp As Integer
Public Condicion As Integer
Public Orden As Integer
Public CodCliente As Double
Public RutCliente As Double
Public CodMoneda As Integer
Public OpcFecha As Integer
Public Fecha1 As Date
Public Fecha2 As Date

Public coleccion As New Collection


Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub



'Public Fecha1 As Date
Function ConsultaDatos() As Boolean

    Dim SQL           As String
    Dim Datos()
    Dim objBuffer     As Object
 
    ConsultaDatos = False
    
    Envia = Array()
    AddParam Envia, CDbl(Operacion)
    AddParam Envia, CDbl(TipOp)
    AddParam Envia, CDbl(Condicion)
    AddParam Envia, CDbl(Orden)
    AddParam Envia, CDbl(CodCliente)
    AddParam Envia, CDbl(RutCliente)
    AddParam Envia, CDbl(CodMoneda)
    AddParam Envia, CDbl(OpcFecha)
    AddParam Envia, Format(Fecha1, "yyyymmdd")
    AddParam Envia, Format(Fecha2, "yyyymmdd")
    AddParam Envia, GLB_AREA_RESPONSABLE
    AddParam Envia, GLB_CARTERA_NORMATIVA
    AddParam Envia, GLB_SUB_CARTERA_NORMATIVA
    AddParam Envia, GLB_LIBRO

    If Not Bac_Sql_Execute("SP_CONSULTASFILTRO", Envia) Then
      Exit Function
    End If
       
    Call VaciarColeccion

    Do While Bac_SQL_Fetch(Datos())
        Set objBuffer = New clsConsultaSwap
    
        With objBuffer
            .TipProd = Datos(1)
            .NumOperacion = Val(Datos(2))
            .TipoOperacion = Datos(6)
            .CodigoCliente = Val(Datos(3))
            .Cliente = Datos(4)
            .FechaInicio = Datos(7)
            .FechaVenc = Datos(8)
            .MonedaOp = Datos(10)
            .MontoOp = BacStrTran((Datos(11)), ".", gsc_PuntoDecim)
            .TasaBase = Val(Datos(12))
            .MontoConv = BacStrTran((Datos(13)), ".", gsc_PuntoDecim)
            .TasaConv = BacStrTran((Datos(14)), ".", gsc_PuntoDecim)
            .Modalidad = Datos(15)
            .RutCliente = Datos(16)
            .Area_Responsable = Trim(Datos(17))
            .Cartera_Normativa = Trim(Datos(18))
            .SubCartera_Normativa = Trim(Datos(19))
            .Libro = Trim(Datos(20))
        End With
        
        coleccion.Add objBuffer
        
        Set objBuffer = Nothing
    
    Loop

   ConsultaDatos = True
   
End Function


Function ConsultaVecimientos() As Boolean

Dim SQL           As String
Dim Datos()
Dim objBuffer     As Object
Dim NumOpePaso As Integer

ConsultaVecimientos = False
    
    Envia = Array()
    AddParam Envia, Format(Fecha1, "yyyymmdd")

   If Not Bac_Sql_Execute("SP_CONSULTAFLUJOSVENCIDOS", Envia) Then 'SP_CONSULTA_FLUJOS_VENCIDOS_PRD21657
      Exit Function

   End If
       
    Call VaciarColeccion
    NumOpePaso = 0

    Do While Bac_SQL_Fetch(Datos())
    
        Set objBuffer = New clsConsultaSwap
        If NumOpePaso <> Datos(2) Then
             With objBuffer
                 .TipProd = Datos(1)
                 .NumOperacion = Datos(2)
                  NumOpePaso = Datos(2)
                 .TipoOperacion = Datos(5)
                 .Cliente = Datos(3)
                 .FechaInicio = Datos(6)
                 .MonedaOp = Datos(7)
                 
                 If Trim(Datos(1)) = "TASA" Then
                     .MontoOp = Datos(10)
                     .MontoConv = Datos(12)
                 Else
                     .MontoOp = CDbl(Datos(10)) + CDbl(Datos(9))
                     .MontoConv = CDbl(Datos(12)) + CDbl(Datos(11))
                 End If
                 
                 .NumFlujo = Val(Datos(13)) & " "
                 .Modalidad = Datos(16)
                 .CodTipoOp = Datos(17)
                 .iValorICP = Datos(18)
                 .FechaLiq = Datos(19) 'Incorporado el día 02-04-2015
            End With
             
            coleccion.Add objBuffer
       End If
        Set objBuffer = Nothing

    Loop
   
   ConsultaVecimientos = True
   
End Function

