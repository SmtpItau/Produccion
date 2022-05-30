VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTabla"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

'Agregar un campo que indique si se puede mantener o no.
Public CodTab    As Integer
Public GlosaTab  As String
Public TabCod    As New Collection

Public Function Grabar() As Integer
Dim Fila As Long
Dim SQL  As String
   
    
    Grabar = False
                
    If sm_Execute("BEGIN TRANSACTION") <> 0 Then
       Grabar = 1
       Exit Function
    End If
    
    If sm_Execute("Exec Sp_TcEliItem " & CodTab) <> 0 Then
       If sm_Execute("ROLLBACK TRANSACTION") <> 0 Then
          Grabar = 2
          Exit Function
       End If
       Exit Function
    End If
    
    For Fila = 1 To TabCod.Count
        SQL = "EXEC Sp_TcGrabar  " & Chr(10)
        SQL = SQL & CodTab & "," & Chr(10)
        SQL = SQL & "'" & TabCod(Fila).Codigo & "'," & Chr(10)
        SQL = SQL & "'" & TabCod(Fila).Glosa & "'"
        If sm_Execute(SQL) <> 0 Then
           If sm_Execute("ROLLBACK TRANSACTION") <> 0 Then
              Grabar = 3
              Exit Function
           End If
        End If
    Next Fila

    If sm_Execute("COMMIT TRANSACTION") <> 0 Then
       Grabar = 4
       Exit Function
    End If
    
    Grabar = True

End Function



Public Function LeerTabCod(ByVal nCodTab As Integer) As Boolean

Dim SQL   As String
Dim Datos()

    LeerTabCod = False
    SQL = "EXEC Sp_TcLeeItem " & nCodTab
    If sm_Execute(SQL) <> 0 Then
        Exit Function
    End If
     
    TabCodClear
    CodTab = nCodTab%
              
    Do While sm_Fetch(Datos()) = 0
        Dim oCodigo As New clsCodigo
        oCodigo.Codigo = Val(Datos(1))
        oCodigo.Glosa = Trim$(Datos(2))
        TabCod.Add oCodigo
        Set oCodigo = Nothing
    Loop
    LeerTabCod = True
           
End Function





Public Function LeerTabla() As Boolean

Dim SQL   As String
Dim Datos()

    LeerTabla = False
    SQL = "EXEC Sp_TcLeeTod"
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If
          
    TabCodClear
             
    Do While sm_Fetch(Datos()) = 0
        Dim oCodigo As New clsCodigo
        oCodigo.Codigo = Val(Datos(1))
        oCodigo.Glosa = Trim$(Datos(2))
        TabCod.Add oCodigo
        Set oCodigo = Nothing
    Loop
    
    LeerTabla = True
          
End Function


Public Sub TabCodClear()

Dim Filas As Long
          
    For Filas = 1 To TabCod.Count
        TabCod.Remove 1
    Next Filas
          
End Sub

Public Sub Tab2List(oControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 25
          
    oControl.Clear
    For Filas = 1 To TabCod.Count
        IdGlosa = TabCod(Filas).Glosa
        oControl.AddItem IdGlosa
        oControl.ItemData(oControl.NewIndex) = TabCod(Filas).Codigo
    Next Filas
    
End Sub

Public Sub Tab2Grid(oControl As Object)
Dim Filas As Long

          oControl.Rows = 1
          For Filas = 1 To TabCod.Count
              oControl.Rows = oControl.Rows + 1
              oControl.Row = oControl.Rows - 1
              oControl.Col = 1: oControl.Text = Mid$(TabCod(Filas).Glosa, 126, 3)
              oControl.Col = 2: oControl.Text = Mid$(TabCod(Filas).Glosa, 1, 25)
          Next Filas

End Sub


