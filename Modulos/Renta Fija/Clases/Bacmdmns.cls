VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMonedas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objMoneda As Object
Public coleccion As New Collection


Public Sub Coleccion2Control(objControl As Object)
Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem RELLENA_STRING(coleccion(Filas).mncodmon, "L", 4) & Space(1) & RELLENA_STRING(coleccion(Filas).mnnemo, "D", 4) & Space(1) & coleccion(Filas).mndescrip
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).mncodmon
    Next Filas
          
End Sub
Public Sub Coleccion2Combo(objControl As Object)
Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem coleccion(Filas).mnnemo
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).mncodmon
    Next Filas
          
End Sub
Public Function LeerMonedas() As Boolean

    LeerMonedas = False
       
    If miSQL.SQL_Execute("SP_MNLEETODO") <> 0 Then
       Exit Function
    End If
    
    Call VaciarColeccion
    
    Dim DATOS()
    Do While Bac_SQL_Fetch(DATOS())
        Dim objBuf As New clsMoneda
        With objBuf
            .mncodmon = Val(DATOS(1))
            .mnnemo = DATOS(2)
            .mnsimbol = DATOS(3)
            .mndescrip = DATOS(4)
            .mnredondeo = Val(DATOS(5))
            .mnbase = Val(DATOS(6))
            .mntipmon = DATOS(7)
            .mnperiodo = Val(DATOS(8))
            .mncodsuper = Val(DATOS(9))
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerMonedas = True
       
End Function


Public Sub VaciarColeccion()
Dim Filas   As Long
Dim Max     As Long
          
    Max = coleccion.Count
    For Filas = 1 To Max
        coleccion.Remove 1
    Next Filas
          
End Sub
 

Private Sub Class_Initialize()

    Set objMoneda = New clsMoneda
     
End Sub


Private Sub Class_Terminate()
        
    Set objMoneda = Nothing
        
End Sub



Public Sub Coleccion2Combo2(objControl As Object)

   Dim Filas                  As Long
   Dim Max                    As Long

   objControl.Clear
   Max = coleccion.Count

   objControl.AddItem "<< TODAS >>" & Space(100) & Trim(0)

   For Filas = 1 To Max
      'If Coleccion(FILAS).mnrefusd = 1 Or Coleccion(FILAS).mncodmon = 13 Or Coleccion(FILAS).mncodmon = 999 Or Coleccion(FILAS).mncodmon = 998 Then
       If coleccion(Filas).mncodmon = 994 Or coleccion(Filas).mncodmon = 995 Or coleccion(Filas).mncodmon = 13 Or coleccion(Filas).mncodmon = 999 Or coleccion(Filas).mncodmon = 998 Then
         objControl.AddItem coleccion(Filas).mnnemo & Space(100) & coleccion(Filas).mncodmon

       End If

   Next Filas

End Sub
