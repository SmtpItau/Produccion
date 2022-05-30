VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsOperadores"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit

Public opcodigo   As Long
Public opdigito   As String
Public opnombre   As String
'Public objOperador As Object
Public coleccion As New Collection



Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count

   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Public Function GrabarOperadores(rutcli As Long, codcli As Long) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count


      For iLin = 1 To imax

       Sql = "EXECUTE sp_mdopgrabar " & vbCrLf
       Sql = Sql & rutcli & "," & vbCrLf
       Sql = Sql & coleccion(iLin).opcodigo & "," & vbCrLf
       Sql = Sql & "'" & coleccion(iLin).opdigito & "'," & vbCrLf
       Sql = Sql & "'" & coleccion(iLin).opnombre & "'," & vbCrLf
       Sql = Sql & codcli
       If SQL_Execute(Sql) > 0 Then
         Exit Function

       End If
                

      Next iLin




   GrabarOperadores = True

End Function

'Consulta clientes ordenados alfabeticamente y llena una colección
Public Function LeerOperadores(nRutCli As String, nCodcli As String) As Boolean

   Dim Sql           As String
   Dim IdRow         As Integer
   Dim objBuffer     As Object
   Dim Datos()
 
   LeerOperadores = False

   Sql = "execute sp_mdopleerrut " & nRutCli & " , " & nCodcli

   If SQL_Execute(Sql) > 0 Then
      Exit Function

    End If

   Call VaciarColeccion

   Do While SQL_Fetch(Datos()) = 0

      Set objBuffer = New clsOperadores

      With objBuffer
         .opcodigo = Val(Datos(1))
         .opdigito = Datos(2)
         .opnombre = Datos(3)

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerOperadores = True

End Function

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas   As Long
   Dim IdGlosa As String * 40
   Dim Max     As Long

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).opnombre
         .AddItem IdGlosa
         .ItemData(.NewIndex) = coleccion(Filas).opcodigo

      Next Filas

   End With

End Sub

Private Sub Class_Initialize()
   
  ' Set objOperador = New clsOperador

End Sub


Private Sub Class_Terminate()

   'Set objOperador = Nothing

End Sub

Public Function CargarGrid(oControl As Object)

   Dim imax    As Integer
   Dim iLin    As Integer

   imax = coleccion.Count

   With oControl
      .Rows = 1

      For iLin = 1 To imax

         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .Text = coleccion(iLin).opcodigo & "-" & coleccion(iLin).opdigito
         .Col = 2: .Text = coleccion(iLin).opnombre

      Next iLin

   End With

End Function
Public Function RefrescaOpe(oControl As Object)

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim rut        As String
   Call LimpiarTodos
   
   RefrescaOpe = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax

         .Row = iLin

         Set objBuffer = New clsOperadores
         
         .Col = 1
         If .Text <> "" Then
            
            .Col = 1: objBuffer.opcodigo = Mid$(.Text, 1, InStr(1, .Text, "-") - 1)
                      objBuffer.opdigito = Mid$(.Text, (InStr(1, .Text, "-") + 1), 1)
            .Col = 2: objBuffer.opnombre = .Text
      
            coleccion.Add objBuffer

            Set objBuffer = Nothing
         
         End If

      Next iLin
      
      RefrescaOpe = True
      
   End With

End Function
Public Sub LimpiarTodos()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count

   For iLin = imax To 1 Step -1

      coleccion.Remove iLin

   Next iLin

End Sub
Public Function EliminarOpe(ByVal idrutcli As Long, Idcodcli As Long) As Boolean
   Dim Sql  As String
   Dim imax As Integer
   Dim iLin As Integer

   EliminarOpe = True

   Sql = "EXECUTE sp_mdopeliminar " & idrutcli & " , " & Idcodcli

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Error en la grabación", vbCritical, "MENSAJE"
      EliminarOpe = False
         
   End If

   Call LimpiarTodos

End Function

