VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCarteras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public ObjCartera As Object
Public coleccion As New Collection


Public Sub LLenarCombo(objControl As Object)

   Dim Filas As Long
   Dim Max   As Long

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         .AddItem coleccion(Filas).rcnombre
         .ItemData(.NewIndex) = coleccion(Filas).rcrut

      Next Filas

   End With

End Sub

Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count

   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

