VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCarters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public ObjCartera As Object
Public coleccion As New Collection
 
Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count

   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Private Sub Class_Initialize()

   'Set ObjCartera = New Clscartera

End Sub

Private Sub Class_Terminate()

   Set ObjCartera = Nothing

End Sub

