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

Public Function CargarGrid(oControl As Object)

   Dim imax    As Integer
   Dim iLin    As Integer

   imax = coleccion.Count

   With oControl
      .Rows = 1

      For iLin = 1 To imax

         .Rows = .Rows + 1
         .Row = .Rows - 1
        '.Col = 0: .Text = coleccion(iLin).CodMda
         .Col = 1: .Text = coleccion(iLin).aprutapo & "-" & coleccion(iLin).apdvapo
         .Col = 2: .Text = coleccion(iLin).apnombre
         .Col = 3: .Text = coleccion(iLin).apcargo
         .Col = 4: .Text = coleccion(iLin).apfono

      Next iLin

   End With

End Function

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


Public Function RefrescaApo(oControl As Object)


   Dim objBuffer  As Object
   Dim iLin       As Integer
   Dim imax       As Integer
   Dim rut        As String
   Call LimpiarTodos
   
   RefrescaApo = False
   
   imax = oControl.Rows - 1

   With oControl
      
      For iLin = 1 To imax

         .Row = iLin

         Set objBuffer = New clsApoderado
         
         .Col = 1
         If .Text <> "" Then
            
            .Col = 1: objBuffer.aprutapo = Mid$(.Text, 1, InStr(1, .Text, "-") - 1)
                      objBuffer.apdvapo = Mid$(.Text, (InStr(1, .Text, "-") + 1), 1)
            .Col = 2: objBuffer.apnombre = .Text
            .Col = 3: objBuffer.apcargo = .Text
            .Col = 4: objBuffer.apfono = .Text
      
            coleccion.Add objBuffer

            Set objBuffer = Nothing
         
         End If

      Next iLin
      
      RefrescaApo = True
      
   End With

End Function


Public Function EliminarApo(ByVal idrutcli As Long, Idcodcli As Long) As Boolean
   Dim Sql  As String
   Dim imax As Integer
   Dim iLin As Integer

   EliminarApo = True

   Envia = Array( _
                  CDbl(idrutcli), _
                  CDbl(Idcodcli) _
                )

   If Not Bac_Sql_Execute("SP_APELIMINAAPO", Envia) Then
   
      MsgBox "Error en la grabación", vbCritical, "MENSAJE"
      EliminarApo = False
         
   End If

   Call LimpiarTodos

End Function

Public Sub LimpiarTodos()

   Dim iLin       As Integer
   Dim imax       As Integer

   imax = coleccion.Count

   For iLin = imax To 1 Step -1

      coleccion.Remove iLin

   Next iLin

End Sub
Public Function GrabarApo(rutcli As Long, digito As String, CodCli As Long) As Boolean

   Dim Fila       As Long
   Dim Sql        As String

   GrabarApo = False
   
   Envia = Array( _
                  CDbl(rutcli), _
                  digito, _
                  CDbl(aprutapo), _
                  apdvapo, _
                  apnombre, _
                  apcargo, _
                  apfono, _
                  CDbl(CodCli) _
                )

   If Not Bac_Sql_Execute("SP_MDAPGRABAR", Envia) Then
   
      Exit Function

   End If

   GrabarApo = True

End Function

Public Function ProGrabarApo(idrutcli As Long, iddigito As String, Idcodcli As Long) As Boolean

   Dim Fila       As Long
   Dim Sql        As String
   Dim grabar     As Integer
    
   ProGrabarApo = False
    
   'Inicia una Transacción
   If Not BacBeginTransaction() Then
      
      grabar = 1
      Exit Function
   
   End If
    
   'Graba todos los elementos o miembros de la colección
   For Fila = 1 To coleccion.Count

      If coleccion(Fila).GrabarApo(idrutcli, iddigito, Idcodcli) = False Then
         
         If Not BacRollBackTransaction() Then
            
            grabar = 3
            Exit Function

         End If

      End If

   Next Fila

   'Si no hubo error compromete la transacción
   If Not BacCommitTransaction() Then
      
      grabar = 4
      Exit Function
   
   End If
     
   ProGrabarApo = True

End Function

Public Function LeeTabApo(nRut As Long, CodCli As Long) As Boolean

   Dim Sql        As String
   Dim objBuffer  As Object
   Dim Datos()

   LeeTabApo = False
 
   Envia = Array(CDbl(nRut), CDbl(CodCli))

   If Not Bac_Sql_Execute("SP_MDAPLEERRUT", Envia) Then
      
      Exit Function

   End If
     
   Call VaciarColeccion
              
   Do While Bac_SQL_Fetch(Datos())
                
      Set objBuffer = New clsApoderado

      With objBuffer
         .aprutapo = Datos(1)
         .apdvapo = Trim$(Datos(2))
         .apnombre = Trim$(Datos(3))
         .apcargo = Trim$(Datos(4))
         .apfono = Trim$(Datos(5))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeeTabApo = True

End Function


Sub VaciarColeccion()
   
   Dim Filas As Long
   Dim Max   As Long

   Max = coleccion.Count
   
   For Filas = 1 To Max
      
      coleccion.Remove 1

   Next Filas

End Sub

