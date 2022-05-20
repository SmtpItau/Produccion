VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsApoderado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Public Objrutcli  As Object
Public coleccion  As New Collection

'MDAP : TABLA DE APODERADOS
'-----------------------------------------------
Public aprutcli             As Long
Public apdvcli              As String
Public aprutapo             As Long
Public apdvapo              As String
Public apnombre             As String
Public apcargo              As String
Public apfono               As String
Public apemail              As String

Public Function Control2Combo(oControl As Object)

   Dim imax    As Integer
   Dim iLin    As Integer

   imax = coleccion.Count

   With oControl
      .Clear

      For iLin = 1 To imax
         .AddItem coleccion(iLin).apnombre
         .ItemData(.NewIndex) = coleccion(iLin).aprutapo
      Next iLin

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


Public Function ProGrabarApo(idrutcli As Long, iddigito As String, Idcodcli As Long) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
   Dim Grabar     As Integer
    
   ProGrabarApo = False
    
   'Inicia una Transacción
   

   If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
      Grabar = 1
      Exit Function
   End If
    
   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count

      If coleccion(Fila).GrabarApo(idrutcli, iddigito, Idcodcli) = False Then

         

         If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
            Grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   

   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
      Grabar = 4
      Exit Function
   
   End If
     
   ProGrabarApo = True

End Function


Sub VaciarColeccion()
   Dim Filas As Long
   Dim Max   As Long

   Max = coleccion.Count
   For Filas = 1 To Max
      coleccion.Remove 1

   Next Filas

End Sub

Public Function EliminarApoderado(rutcli As String, codcli As String) As Boolean
   
   Dim Sql As String
If eliminame <> 100 Then
   EliminarApoderado = False
   
   Envia = Array()
   
   AddParam Envia, CDbl(rutcli)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(codcli)
   
   If Not BAC_SQL_EXECUTE("Sp_Borrar_Apoderado1 ", Envia) Then
       Exit Function
   End If

   EliminarApoderado = True
Else
   EliminarApoderado = False
   
   Envia = Array()
   AddParam Envia, CDbl(rutcli)
   AddParam Envia, CDbl(opecod)
   
   If Not BAC_SQL_EXECUTE("Sp_Borrar_Apoderado1 ", Envia) Then
       Exit Function
   End If

   EliminarApoderado = True
End If
End Function


Public Function LimpiaGrilla(Grillas As Object)
   
   ''------------------------------------------------------------------''
   '' Coloca una marca "X" a los rut erroneos que se filatraron, para  ''
   '' luego grabar los buenos solamente
   '' -----------------------------------------------------------------''
   
Dim Fila       As Integer
Dim sRut       As String
Dim sDv        As String

 With Grillas
  
       For Fila = 1 To .Rows - 1
              
            .Col = 0
            .Row = Fila
      
             If Len(.Text) >= 1 Then ' And InStr(1, .Text, "-") <> 0
                    
                    sRut = .Text  'Mid$(.Text, 1, Len(.Text) - IIf(InStr(.Text, "-") = 0, 1, 2))
                    sDv = .TextMatrix(Fila, 1) 'Right$(.Text, 1)
          
                     If Not ControlRUT(sRut, sDv) Then
                             ''MsgBox "Rut Incorrecto", vbExclamation, "MENSAJE"
                             .Col = 4
                             .Text = "X"
                     End If
                     
            Else
                    .Col = 4
                    .Text = "X"
     
            End If
 
      Next Fila

 End With

End Function


Public Function RefrescaApo(Grillas As Object)

   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim Rut        As String
   Dim Marca      As String
   Dim Fila As Long
   
   Call LimpiarTodos                      '' Limpia Todo el Coleccion
   
   Call LimpiaGrilla(Grillas)
  
 
   RefrescaApo = False
 
 
 With Grillas
 
     For Fila = 1 To .Rows - 1
          
          
        Set objBuffer = New clsApoderado
         
         .Row = Fila
         .Col = 4
         
         Marca = ""
         Marca = Trim$(.Text)

         If Marca <> "X" Then
            
            .Col = 0
            objBuffer.aprutapo = .Text 'Mid$(.Text, 1, InStr(1, .Text, "-") - 1)
            objBuffer.apdvapo = .TextMatrix(Fila, 1) ' Mid$(.Text, (InStr(1, .Text, "-") + 1), 1)
             
            .Col = 2
            objBuffer.apnombre = Trim$(.Text)
           
            .Col = 3
            objBuffer.apcargo = Trim$(.Text)
           
            .Col = 4
            objBuffer.apfono = Trim$(.Text)

            .Col = 6
            objBuffer.apemail = Trim$(.Text)

             coleccion.Add objBuffer
         End If
         
            Set objBuffer = Nothing

     Next Fila
          
  End With
          
   RefrescaApo = True
      
 End Function

Public Function GrabarApo(rutcli As String, Digito As String, codcli As Long) As Boolean

   Dim Fila       As Long
   Dim Sql        As String

      GrabarApo = False
   
      For Fila = 1 To coleccion.Count
       
            
            Envia = Array()
            AddParam Envia, CDbl(rutcli)
            AddParam Envia, Digito
            AddParam Envia, CDbl(codcli)
            AddParam Envia, coleccion(Fila).aprutapo
            AddParam Envia, coleccion(Fila).apdvapo
            AddParam Envia, UCase(coleccion(Fila).apnombre)
            AddParam Envia, coleccion(Fila).apcargo
            AddParam Envia, coleccion(Fila).apfono
            AddParam Envia, coleccion(Fila).apemail
                       

           If Not BAC_SQL_EXECUTE("sp_Grabar_Apoderado ", Envia) Then
              Exit Function
        
           End If

      Next Fila

   GrabarApo = True

End Function


