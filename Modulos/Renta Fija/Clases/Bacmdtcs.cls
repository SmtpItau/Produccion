VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Agregar un campo que indique si se puede mantener o no.
Public objTabCod As Object
Public coleccion As New Collection
Sub Agregar(Codigo As String, Glosa As String)
Dim objBuf As Object

    Set objBuf = New clsCodigo
    With objBuf
        .Codigo = Codigo
        .Glosa = Glosa
    End With
    coleccion.Add objBuf
    objBuf = Nothing

End Sub

Public Function Grabar(CodTab As Integer) As Integer
Dim Fila As Long
Dim Sql  As String
    
    Grabar = False
                
    'Inicia una Transacción
    If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
        Grabar = 1
        Exit Function
    End If
    
    'Elimina todos los items para una tabla
    If miSQL.SQL_Execute("SP_TCELIMINACODIGOS1 " & CodTab) <> 0 Then
        If miSQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
            Grabar = 2
            Exit Function
        End If
        Exit Function
    End If
    
    'Graba todos los elementos o miembros de la colección
    For Fila = 1 To coleccion.Count
        If coleccion(Fila).Grabar(CodTab) = False Then
            If miSQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                Grabar = 3
                Exit Function
            End If
        End If
    Next Fila

    'Si no hubo error compromete la transacción
    If miSQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
        Grabar = 4
        Exit Function
    End If
    
    If CodTab = 1 Then
        If miSQL.SQL_Execute("SP_LLENAFILTROFORPAG") <> 0 Then
            MsgBox "Problemas al Generar Filtros para Formas de Pago" & Chr$(10) & Chr$(13) & "Las Operaciones Causarán Error al Grabar", vbCritical, gsBac_Version
        End If
    End If
    Grabar = True

End Function


Public Function LeerCodigos(ByVal nCodTab As Integer, Optional TipoOperacion As Variant) As Boolean
Dim DATOS()
Dim objBuf As New clsCodigo
Dim cTipo As String
Dim SW As Integer
SW = 0
    LeerCodigos = False
    
    Select Case nCodTab
                
        Case 79, 105
                nCodTab = 1
                cTipo = ""
                
                If nCodTab = 105 Then
                    cTipo = IIf(RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "ST", "VP", Mid$(BacFrmIRF.Tag, 1, 2))
                    If RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RC" Or RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RV" Then
                        cTipo = IIf(RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RC", "VI", "CI")
                    End If
                End If
                
                                      
                
                Envia = Array(CDbl(nCodTab), cTipo)
                If RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "IB" Then
                    AddParam Envia, "S"
                End If
                
                If Not Bac_Sql_Execute("SP_LEEFORPAG", Envia) Then
                    
                    Exit Function
                End If
     
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                
                
                    If ((BacIrfGr.proMoneda <> gsBac_Dolar And DATOS(3) = "N") And Val(DATOS(1)) <> 11 And SwMx <> "C") Or _
                    (SwMx = "C" And DATOS(3) = "S") Or BacFrmIRF.Tag = "RI" Then
                    
                         With objBuf
                                  .Codigo = Val(DATOS(1))
                                  .Glosa = Trim$(DATOS(2))
                              End With
                               coleccion.Add objBuf
                              Set objBuf = Nothing
                                                
                    End If
                    
'                    If (BacIrfGr.proMoneda = gsBac_Dolar And Datos(3) = "S" Or Val(Datos(1)) = 11) Then
'
'                               With objBuf
'                                  .Codigo = Val(Datos(1))
'                                  .Glosa = Trim$(Datos(2))
'                              End With
'                               Coleccion.Add objBuf
'                              Set objBuf = Nothing
'
'                    End If
                       
                    
                    
                Loop
    
                LeerCodigos = True
        Case Else
                If nCodTab <> 204 Then
                
                    Envia = Array(CDbl(nCodTab))
                
                    If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
                      Exit Function
                    End If
                Else
                
                    If Tipo_Operacion <> "" Then
                        TipoOperacion = Tipo_Operacion
                        SW = 1
                    End If
                        
                    If SW = 0 Then
                         If IsMissing(TipoOperacion) Then
                            TipoOperacion = IIf(Trim(Tipo_Operacion) = "", Left(BacFrmIRF.Tag, 2), Tipo_Operacion)
                         End If
                    End If
                     
                     'Envia = Array(TipoOperacion, "BTR")
                     Envia = Array()
                     AddParam Envia, TipoOperacion
                     AddParam Envia, GLB_ID_SISTEMA
                     AddParam Envia, GLB_CARTERA
                
                    If Not Bac_Sql_Execute(gsSQL_Database_comun & "..SP_MDRCLEERCODIGO", Envia) Then
                        Exit Function
                    End If
                    
                    
                    
                End If
                
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                    With objBuf
                        .Codigo = Val(DATOS(1))
                        .Glosa = Trim$(DATOS(2))
                    End With
                    coleccion.Add objBuf
                    Set objBuf = Nothing
                Loop
    
                LeerCodigos = True
                
    End Select

           
End Function






Public Sub VaciarColeccion()
Dim Filas As Long
Dim Max   As Long
          
    Max = coleccion.Count
    For Filas = 1 To Max
        coleccion.Remove 1
    Next Filas
          
End Sub

Public Sub Coleccion2Control(objControl As Object, Optional Tipo As Integer)
Dim Filas   As Long
Dim IdGlosa As String * 25
Dim Max     As Long
Dim Codigo As String
          
    If (Tipo <> 2) Or (Tipo <> 2) Then
    objControl.Clear
    End If

    Max = coleccion.Count
    If Tipo = 1 Then objControl.AddItem ("EJECUTIVO")
    For Filas = 1 To Max
        IdGlosa = coleccion(Filas).Glosa
        objControl.AddItem IdGlosa
        Codigo = coleccion(Filas).Codigo
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).Codigo
    Next Filas
    
End Sub

Public Sub Coleccion2Grilla(objControl As Object)
Dim Filas   As Long
Dim Max     As Long

    objControl.Rows = 1
    Max = coleccion.Count
    
    For Filas = 1 To Max
        objControl.Rows = objControl.Rows + 1
        objControl.Row = objControl.Rows - 1
        objControl.Col = 1: objControl.text = Mid$(coleccion(Filas).Glosa, 126, 3)
        objControl.Col = 2: objControl.text = Mid$(coleccion(Filas).Glosa, 1, 25)
    Next Filas

End Sub


Public Function LeerTablas() As Boolean
Dim DATOS()

    LeerTablas = False
    
    If miSQL.SQL_Execute("SP_TBLEETABLAS1") <> 0 Then
       Exit Function
    End If
          
    Call VaciarColeccion
             
    Do While Bac_SQL_Fetch(DATOS())
        Dim objBuf As New clsCodTab
        With objBuf
            .Codigo = Val(DATOS(1))
            .Glosa = Trim$(DATOS(2))
            .TipMan = Trim$(DATOS(3))
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerTablas = True
          
End Function



Public Function LeerCodigos1(ByVal nCodTab As Integer, NOMBRE As String) As Boolean
Dim DATOS()
Dim objBuffer     As Object

   LeerCodigos1 = False
'   Sql = "SP_MDTCLEERCODIGOS " & c
 
    Envia = Array(CDbl(nCodTab))
    
    If Not Bac_Sql_Execute("SP_MDTCLEERCODIGOS", Envia) Then
        Exit Function
    End If

    Call VaciarColeccion

    Do While Bac_SQL_Fetch(DATOS())
        Set objBuffer = New clsCodigo
        With objBuffer
            .Codigo = CDbl(Val(DATOS(1)))
            .Glosa = Trim$(DATOS(2))
        End With
        coleccion.Add objBuffer
        Set objBuffer = Nothing
    Loop

    LeerCodigos1 = True

End Function

Public Sub ColeccionDVPNo(objControl As Object)
   Dim Filas   As Long
   Dim IdGlosa As String * 25
   Dim Max     As Long
          
   objControl.Clear
   Max = coleccion.Count

   For Filas = 1 To Max
      IdGlosa = coleccion(Filas).Glosa
      If Not IdGlosa Like "*DVP*" Then
         objControl.AddItem IdGlosa
         objControl.ItemData(objControl.NewIndex) = coleccion(Filas).Codigo
      End If
   Next Filas
End Sub
Public Sub ColeccionDVPSi(objControl As Object)
   Dim Filas   As Long
   Dim IdGlosa As String * 25
   Dim Max     As Long
          
   objControl.Clear
   Max = coleccion.Count

   For Filas = 1 To Max
      IdGlosa = coleccion(Filas).Glosa
      If IdGlosa Like "*DVP*" Then
         objControl.AddItem IdGlosa
         objControl.ItemData(objControl.NewIndex) = coleccion(Filas).Codigo
      End If
   Next Filas
End Sub

'-------------------------------------------------------------
'-------- LD1-COR-035 MANTENCION VOLCKER RULE-----------------
'-------------------------------------------------------------

Public Function LeerCodVPVI(ByVal nCodTab As Integer) As Boolean
Dim DATOS()
Dim objBuf As New clsCodigo
Dim cTipo As String

    LeerCodVPVI = False
    
    Envia = Array(CDbl(nCodTab))
                
    If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
       Exit Function
    End If
     
    Call VaciarColeccion
              
    Do While Bac_SQL_Fetch(DATOS())
       With objBuf
          Select Case Val(DATOS(1))
             Case 1, 2, 3, 4
               .Codigo = IIf(Val(DATOS(1)) = 4, 99, Val(DATOS(1)))
               .Glosa = IIf(Val(DATOS(1)) = 4, "TODAS", Trim$(DATOS(2)))
             Case Else
               Exit Do
          End Select
       End With
       coleccion.Add objBuf
       Set objBuf = Nothing
    Loop
    LeerCodVPVI = True
End Function


'=========================================
'                   FUSION
'=========================================

'Lee todos los codigos de una Tabla

Public Function LeerForma_de_Pago(ByVal iMoneda As Integer) As Boolean
    Dim DATOS()
   Dim objBuffer              As Object

   LeerForma_de_Pago = False

   Sql = "sp_leeforpag_MONEDA " & CStr(iMoneda)

   If Not Bac_Sql_Execute(Sql) Then
      Exit Function

   End If

   Call VaciarColeccion

   Do While Bac_SQL_Fetch(DATOS())
      Set objBuffer = New clsCodigo

      With objBuffer
         .Codigo = CDbl(Val(DATOS(1)))
         .Glosa = Trim$(DATOS(2))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerForma_de_Pago = True

End Function


Public Function LeerCodigosItau(ByVal nCodTab As Integer) As Boolean
Dim DATOS()
Dim objBuf As New clsCodigo
Dim cTipo As String

    LeerCodigosItau = False
    
    Select Case nCodTab
                
        Case 79, 105
                nCodTab = 1
                cTipo = ""
                
                If nCodTab = 105 Then
                    cTipo = IIf(RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "ST", "VP", Mid$(BacFrmIRF.Tag, 1, 2))
                    If RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RC" Or RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RV" Then
                        cTipo = IIf(RTrim(Mid$(BacFrmIRF.Tag, 1, 2)) = "RC", "VI", "CI")
                    End If
                End If
                
                Envia = Array(BacIrfGr.proCodMoneda)
                
                If BacIrfGr.proCodMoneda <> 13 Then
                  If Not Bac_Sql_Execute("SP_LEEFORPAG_moneda", Envia) Then
                    Exit Function
                  End If
                Else
                  If Not Bac_Sql_Execute("SP_LEEFORPAG2_moneda", Envia) Then
                    Exit Function
                  End If
                End If
                
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                
'                    If (BacIrfGr.proMoneda <> gsBac_Dolar And datos(3) = "N") Or (BacIrfGr.proMoneda = gsBac_Dolar And datos(3) = "S") Then
                       With objBuf
                           .Codigo = Val(DATOS(1))
                           .Glosa = Trim$(DATOS(2))
                       End With
                        coleccion.Add objBuf
                       Set objBuf = Nothing
'                    End If
                    
                Loop
    
                LeerCodigosItau = True
                
        Case 80
        
                
                
                Envia = Array(BacIrfGr.proCodMoneda)
                
                If Not Bac_Sql_Execute("SP_LEEFORPAG2_moneda", Envia) Then
                    
                    Exit Function
                End If
     
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                
                       With objBuf
                           .Codigo = Val(DATOS(1))
                           .Glosa = Trim$(DATOS(2))
                       End With
                        coleccion.Add objBuf
                       Set objBuf = Nothing
                    
                Loop
    
                LeerCodigosItau = True

        Case 1975
                If Not Bac_Sql_Execute("SP_TRAE_FAMILIA_INSTRUMENTOS") Then
                    
                    Exit Function
                End If
     
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                
                       With objBuf
                           .Codigo = Val(DATOS(1))
                           .Glosa = Trim$(DATOS(2))
                       End With
                        coleccion.Add objBuf
                       Set objBuf = Nothing
                    
                Loop
    
                LeerCodigosItau = True

        'modificado para LD1-COR-035
        Case 1111
                Envia = Array(CDbl(nCodTab))
                
                If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
                    Exit Function
                End If
                 Call VaciarColeccion
                
                Dim Codigo As String
                Dim Cod As Long
              
                Do While Bac_SQL_Fetch(DATOS())
                    With objBuf
                         Codigo = DATOS(1)
                         Select Case Codigo
                            Case "A"
                                Cod = 1
                            Case "C"
                                Cod = 2
                            Case "P"
                                Cod = 3
                            Case "R"
                                Cod = 4
                            Case "T"
                                Cod = 5
                         End Select
                        .Codigo = Cod
                        .Glosa = Trim$(DATOS(2))
                    End With
                    coleccion.Add objBuf
                    Set objBuf = Nothing
                Loop
    
                LeerCodigosItau = True
                ' END modificado para LD1-COR-035
            

        Case Else
        
                Envia = Array(CDbl(nCodTab))
                
                If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
                    Exit Function
                End If
     
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(DATOS())
                    With objBuf
                        .Codigo = Val(DATOS(1))
                        .Glosa = Trim$(DATOS(2))
                    End With
                    coleccion.Add objBuf
                    Set objBuf = Nothing
                Loop
    
                LeerCodigosItau = True
                
    End Select

           
End Function

Public Function CargaSucursal(cCual As String) As Boolean
    Dim DATOS()
    Dim objBuffer     As Object
    Dim Sql$
    Dim nIndice       As Integer
    If cCual = "SUCURSAL" Then
       Sql = "SP_LEESUCURSAL"
    ElseIf cCual = "EJECUTIVO" Then
       Sql = "SP_LEEEJECUTIVO"
    ElseIf cCual = "RENTABILIDAD" Then
       Sql = "SP_TCLEECODIGOS1 9923"  '----TABLA_GENERAL DETALLE Y GLOBAL
    ElseIf cCual = "CONDICION" Then
       Sql = "SP_LEECONDICION"
    ElseIf cCual = "DEPOSITO" Then
       Sql = "SP_TCLEECODIGOS1 10"
    End If
    Call VaciarColeccion
    If Not Bac_Sql_Execute(Sql) Then
       Exit Function
    End If
    nIndice = 0
    Do While Bac_SQL_Fetch(DATOS())
           Set objBuffer = New clsCodigo
           With objBuffer
              If cCual = "RENTABILIDAD" Or cCual = "CONDICION" Then
                 ' esto debido a que el codigo del tipo de rentabilidad
                 ' es una letra no un numero, el index se incrementa solo en uno
                 ' no lo toma de la tabla
                 nIndice = nIndice + 1
                .Codigo = nIndice
              Else
                .Codigo = CDbl(Val(DATOS(1)))
              End If
              .Glosa = Trim$(DATOS(2))
           End With
           coleccion.Add objBuffer
           Set objBuffer = Nothing
    Loop
    CargaSucursal = True
End Function

