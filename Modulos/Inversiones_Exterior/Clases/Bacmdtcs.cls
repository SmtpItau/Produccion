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
Public Coleccion As New Collection
Sub Agregar(Codigo As String, Glosa As String)
Dim objBuf As Object

    Set objBuf = New clsCodigo
    With objBuf
        .Codigo = Codigo
        .Glosa = Glosa
    End With
    Coleccion.Add objBuf
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
    For Fila = 1 To Coleccion.Count
        If Coleccion(Fila).Grabar(CodTab) = False Then
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


Public Function LeerCodigos(ByVal nCodTab As Integer) As Boolean
Dim datos()
Dim objBuf As New clsCodigo
Dim cTipo As String

    LeerCodigos = False
    
If nCodTab = 204 Then
     If Tipo_op = "C" Then
        cTipo = "CPX"
     Else
        cTipo = "VPX"
     End If
        
        envia = Array()
        AddParam envia, cTipo
        AddParam envia, GLB_ID_SISTEMA
        AddParam envia, GLB_CARTERA
        
        ''''envia = Array(cTipo, "BEX")
    
 
    If Not Bac_Sql_Execute(gsSQL_Database_comun & "..Sp_MDRCLeerCodigo", envia) Then
            Exit Function
    End If
Else
                envia = Array(CDbl(nCodTab))
                
                If Not Bac_Sql_Execute("Sva_gen_lee_tbg", envia) Then
                    Exit Function
                End If
End If
     
                Call VaciarColeccion
              
                Do While Bac_SQL_Fetch(datos())
                    With objBuf
                        .Codigo = Val(datos(1))
                        .Glosa = Trim$(datos(2))
                    End With
                    Coleccion.Add objBuf
                    Set objBuf = Nothing
                Loop
    
                LeerCodigos = True
                

           
End Function






Public Sub VaciarColeccion()
Dim FILAS As Long
Dim Max   As Long
          
    Max = Coleccion.Count
    For FILAS = 1 To Max
        Coleccion.Remove 1
    Next FILAS
          
End Sub

Public Sub Coleccion2Control(objControl As Object)
Dim FILAS   As Long
Dim IDGLOSA As String * 25
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count

    For FILAS = 1 To Max
        IDGLOSA = Coleccion(FILAS).Glosa
        objControl.AddItem IDGLOSA
        objControl.ItemData(objControl.NewIndex) = Coleccion(FILAS).Codigo
    Next FILAS
    
End Sub

Public Sub Coleccion2Grilla(objControl As Object)
Dim FILAS   As Long
Dim Max     As Long

    objControl.Rows = 1
    Max = Coleccion.Count
    
    For FILAS = 1 To Max
        objControl.Rows = objControl.Rows + 1
        objControl.row = objControl.Rows - 1
        objControl.Col = 1: objControl.Text = Mid$(Coleccion(FILAS).Glosa, 126, 3)
        objControl.Col = 2: objControl.Text = Mid$(Coleccion(FILAS).Glosa, 1, 25)
    Next FILAS

End Sub


'Public Function LeerTablas() As Boolean
'Dim datos()
'
'    LeerTablas = False
'
'    If miSQL.SQL_Execute("SP_TBLEETABLAS1") <> 0 Then
'       Exit Function
'    End If
'
'    Call VaciarColeccion
'
'    Do While Bac_SQL_Fetch(datos())
'        Dim objBuf As New clsCodTab
'        With objBuf
'            .Codigo = Val(datos(1))
'            .Glosa = Trim$(datos(2))
'            .TipMan = Trim$(datos(3))
'        End With
'        Coleccion.Add objBuf
'        Set objBuf = Nothing
'    Loop
'
'    LeerTablas = True
'
'End Function



Public Function LeerCodigos1(ByVal nCodTab As Integer, NOMBRE As String) As Boolean
Dim datos()
Dim objBuffer     As Object

   LeerCodigos1 = False
'   Sql = "sp_mdtcleercodigos " & c
 
    envia = Array(CDbl(nCodTab))
    
    If Not Bac_Sql_Execute("sp_mdtcleercodigos", envia) Then
        Exit Function
    End If

    Call VaciarColeccion

    Do While Bac_SQL_Fetch(datos())
        Set objBuffer = New clsCodigo
        With objBuffer
            .Codigo = CDbl(Val(datos(1)))
            .Glosa = Trim$(datos(2))
        End With
        Coleccion.Add objBuffer
        Set objBuffer = Nothing
    Loop

    LeerCodigos1 = True

End Function

