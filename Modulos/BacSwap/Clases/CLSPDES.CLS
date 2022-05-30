VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsparidades"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public objparidad  As Object
Public coleccion As New Collection

Public Function Grabar() As Integer
'Graba todos los miembros de la coleccion

Dim SQL     As String
Dim Msg     As String
Dim Fila    As Integer
' estas son variabbles locales

'Dim cCodigo As Integer
'Dim cfecha  As String
'Dim cperiodo  As Integer
'Dim cbid  As Double
'Dim cask  As Double
'estas son variables donde se va a grabar la información

Dim Max     As Long
     
    Grabar = False
        
    If SQL_Execute("BEGIN TRANSACTION") <> 0 Then
       Grabar = 1
       Exit Function
    End If
    
    Max = coleccion.Count
    'coleccon.count :trae el valor de la cantidad de registros
    'que hay en la coleccion para controlar el ciclo de grabación
    
    For Fila = 1 To Max
       If coleccion(Fila).Grabar() = False Then
           If SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
              Grabar = 2
              Exit Function
            End If
           Exit For
        End If
    Next Fila
    
    If SQL_Execute("COMMIT TRANSACTION") <> 0 Then
       Grabar = 3
       Exit Function
    End If
    
    Grabar = True

End Function

Function agregar(codigo As Long, fecha As String, periodo As Integer, bid As Double, ask As Double, puncom As Double, punven As Double)

'estea funcion agrega un neevo elemen to a esta coleccion
'recordemos que una coleccion es un conjunto de registros
'de tipo clase ,la cual nos sirve para trabajar con un con-
'junto de registros a la vez.

Dim objBuf As Object

    Set objBuf = New clsparidad
    With objBuf
        .pcodigo = codigo
        .pfecha = fecha
        .pperiodo = periodo
        .pbid = bid
        .pask = ask
        .puncom = puncom
        .punven = punven
    End With
   'coleccion.add : le suma a la coleccion un nuevo registro
   'de tipo clase.
   
    coleccion.Add objBuf
Set objBuf = Nothing

End Function
Sub limpiar()

pcodigo = 0
pfecha = ""
pperiodo = 0
pbid = 0
pask = 0
puncom = 0
punven = 0

End Sub

Private Sub Class_Initialize()

Set objparidad = New clsparidad

End Sub


Private Sub Class_Terminate()

Set objparidad = Nothing

End Sub


