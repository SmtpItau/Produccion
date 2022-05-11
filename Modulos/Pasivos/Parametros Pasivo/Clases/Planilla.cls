VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsPlanillas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim I&, X&, Y&
Dim xStr$
Dim Datos()

Public objPlanilla  As Object
Public coleccion    As New Collection

Private Sub Class_Initialize()
   Set objPlanilla = New clsPlanilla
End Sub
Private Sub Class_Terminate()
   Set objPlanilla = Nothing
End Sub
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Function Cantidad() As Long
   Cantidad = coleccion.Count
End Function
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Sub Cargar(objLista As Object, Optional objOriginal)
Dim I&, xLine$, xStr$

    objLista.Clear
    
    For I = 1 To coleccion.Count
        With coleccion(I)
            xLine = .planilla_fecha
            xStr = Format(.planilla_numero, "######0"): xLine = xLine & Space(8 - Len(xStr)) & xStr
            xStr = .Operacion_Moneda: xLine = xLine & Space(4 - Len(xStr)) & xStr
            xStr = Format(.monto_origen, "###,###,###,##0.00"): xLine = xLine & Space(18 - Len(xStr)) & xStr
            xStr = .Tipo_Operacion_Cambio: xLine = xLine & Space(5 - Len(xStr)) & xStr & Space(2)
            xStr = .interesado_nombre: xLine = xLine & " " & xStr
            If VarType(objOriginal) = vbObject Then
                .Planilla_Original_Numero = objOriginal.planilla_numero
                .Planilla_Original_Fecha = objOriginal.planilla_fecha
            End If
        End With
        If VarType(objOriginal) = vbObject Then
            If objOriginal.Operacion_Moneda <> coleccion(I).Operacion_Moneda Then
                xLine = ""
            End If
        End If
        If xLine <> "" Then
            objLista.AddItem xLine
            objLista.ItemData(objLista.NewIndex) = coleccion(I).operacion_numero
        End If
    Next I
    
End Sub
'******************************************************************
'*   Carga solo Planillas que contienen moneda (Planillas Vigentes)
Public Sub CargaxMoneda(nMoneda%)

    For I = coleccion.Count To 1 Step -1
        If nMoneda <> coleccion(I).Operacion_Moneda Then
            coleccion.Remove I
        End If
    Next I
    
End Sub
'******************************************************************
'*   Cantidad de filas en Coleccion de Planillas
Public Sub Carga_Planilla(intPos&, objPlanilla As Object)
Dim xentidad%, xNumOpe&, xNumPla&, xFecPla$

    If intPos > 0 Then
        xentidad = coleccion(intPos).Entidad
        xNumOpe = coleccion(intPos).operacion_numero
        xNumPla = coleccion(intPos).planilla_numero
        xFecPla = Format(coleccion(intPos).planilla_fecha, "yyyymmdd")
        objPlanilla.Leer xentidad, xNumOpe, xNumPla, xFecPla
    Else
        objPlanilla.Limpiar
    End If
        
End Sub
'************************************************************
'*    Suma los montos originales de las planillas asociadas a la
'*    operación según fecha de emisión para la xEntidad indicada
Public Function Suma_Planillas(xentidad$, xNumOpe&, xNumPla&, xFecha$, xMoneda%) As Double
Dim Mouse%

    Mouse = Screen.MousePointer
    Screen.MousePointer = 11
    
    Suma_Planillas = 0

    For I = 1 To coleccion.Count
    
        If coleccion(I).Entidad <> xentidad Then
        '----- Entidad no corresponde
        
        ElseIf Format(coleccion(I).planilla_fecha, "yyyymmdd") <> xFecha Then
        '----- Planilla no corresponde al dia solicitado
        
        ElseIf coleccion(I).operacion_numero <> xNumOpe Then
        '----- Operacion no correspode a la solicitada
        
        ElseIf coleccion(I).planilla_numero = xNumPla Or coleccion(I).Planilla_Original_Numero = xNumPla Or coleccion(I).rel_numero = xNumPla Or xNumPla = 0 Then
            If coleccion(I).Operacion_Moneda = xMoneda Then
                If coleccion(I).Tipo_Documento < 3 Then
                    Suma_Planillas = Suma_Planillas + coleccion(I).monto_origen
                Else
                    Suma_Planillas = Suma_Planillas - coleccion(I).monto_origen
                End If
            End If
            
        End If
        
    Next I
    
    Screen.MousePointer = Mouse

End Function
'******************************************************************
'*   Vacia la Coleccion de Planillas
Public Sub Vaciar()
Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1
   Next Filas&

End Sub
