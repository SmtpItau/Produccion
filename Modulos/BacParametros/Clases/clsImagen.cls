VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsImagen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public Sub PutImageInDB(ByVal File As String, ByVal dui As String, ByVal nEstado As Integer, opcion As Integer)
    Dim b() As Byte
    Dim ff  As Long
    Dim n   As Long
    Dim cnn As New ADODB.Connection
    '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'Let cnn.ConnectionString = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";User Id=" & gsSQL_Login & ";Password=" & gsSQL_Password & ";Connect Timeout=" & giSQL_LoginTimeOut
    Let cnn.ConnectionString = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";trusted_connection=yes;Connect Timeout=" & giSQL_LoginTimeOut
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    Call cnn.Open

    If Len(File) = 0 And nEstado = 1 Then
        Exit Sub
    End If

    On Error GoTo ErrHandler

    ff = FreeFile

    Open File For Binary Access Read As ff

    n = LOF(ff)

    If n Then
        ReDim b(1 To n) As Byte
        Get ff, , b()
    End If
    Close ff

    If opcion = 1 Then
        cnn.Execute "UPDATE dbo.Contratos_ParametrosGenerales SET LOGO=0x" & BinaryToHex(b()) & " WHERE RUTENTIDAD='" & dui & "'"
    ElseIf opcion = 2 Then
        cnn.Execute "UPDATE dbo.Contratos_ParametrosGenerales SET BannerCorto=0x" & BinaryToHex(b()) & " WHERE RUTENTIDAD='" & dui & "'"
    ElseIf opcion = 3 Then
        cnn.Execute "UPDATE dbo.Contratos_ParametrosGenerales SET BannerLargo=0x" & BinaryToHex(b()) & " WHERE RUTENTIDAD='" & dui & "'"
    ElseIf opcion = 4 Then
        cnn.Execute "UPDATE dbo.Contratos_ParametrosGenerales SET BannerLargoContrato=0x" & BinaryToHex(b()) & " WHERE RUTENTIDAD='" & dui & "'"
    End If

    Call MsgBox("Imagen se ha actualizado correctamente.", vbInformation, App.Title)
    Call cnn.Close

Exit Sub
ErrHandler:

    Call MsgBox("ERROR: " & Err.Description, vbExclamation, App.Title)
    Call cnn.Close

End Sub

Private Sub GetRandomFileName(ByRef File As String)
    Randomize Timer
    File = App.Path & IIf(Strings.Right$(App.Path, 1) = "\", "", "\") & Format(Rnd() * 1000000, "00000000") & ".tmp"
End Sub

Private Function BinaryToHex(Binary)
  Dim c1 As Long, Out, OneByte
  
  'Para cada byte fuente
  For c1 = 1 To LenB(Binary)
    'Convierte el byte a hex
    OneByte = Hex(AscB(MidB(Binary, c1, 1)))
    
    'Agrega cero para bytes < 0x10
    If Len(OneByte) = 1 Then OneByte = "0" & OneByte
    
    'Concatena el byte al stream de salida
    Out = Out & OneByte
  Next
  
  'Establece el valor de salida
  BinaryToHex = Out
End Function

Public Function GetImageFromField(ByVal dui As String, opcion As Integer) As StdPicture
   'Dim rs      As Recordset
    Dim b()     As Byte
    Dim ff      As Long
    Dim File    As String
    Dim cnn     As New ADODB.Connection
    Dim rs      As New ADODB.Recordset
    Dim Var     As String
    '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    'Let cnn.ConnectionString = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";User Id=" & gsSQL_Login & ";Password=" & gsSQL_Password & ";Connect Timeout=" & giSQL_LoginTimeOut
    Let cnn.ConnectionString = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";trusted_connection=yes;Connect Timeout=" & giSQL_LoginTimeOut
    '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    Call cnn.Open
    
    If opcion = 1 Then
        rs.Open "SELECT Logo FROM dbo.Contratos_ParametrosGenerales WHERE RutEntidad='" & dui & "'", cnn, adOpenDynamic, adLockReadOnly
    ElseIf opcion = 2 Then
        rs.Open "SELECT BannerCorto FROM dbo.Contratos_ParametrosGenerales WHERE RutEntidad='" & dui & "'", cnn, adOpenDynamic, adLockReadOnly
    ElseIf opcion = 3 Then
        rs.Open "SELECT BannerLargo FROM dbo.Contratos_ParametrosGenerales WHERE RutEntidad='" & dui & "'", cnn, adOpenDynamic, adLockReadOnly
    ElseIf opcion = 4 Then
        rs.Open "SELECT BannerLargoContrato FROM dbo.Contratos_ParametrosGenerales WHERE RutEntidad='" & dui & "'", cnn, adOpenDynamic, adLockReadOnly
    End If
    
    If rs.EOF = False Then
        On Error GoTo ErrHandler
        Call GetRandomFileName(File)
        ff = FreeFile
        Open File For Binary Access Write As ff
        If opcion = 1 Then
            Var = campo(rs("Logo"))
            If Var <> "" Then
                b() = rs("Logo")
            End If
        ElseIf opcion = 2 Then
            Var = campo(rs("BannerCorto"))
            If Var <> "" Then
                b() = rs("BannerCorto")
            End If
        ElseIf opcion = 3 Then
            Var = campo(rs("BannerLargo"))
            If Var <> "" Then
                b() = rs("BannerLargo")
            End If
        ElseIf opcion = 4 Then
            Var = campo(rs("BannerLargoContrato"))
            If Var <> "" Then
                b() = rs("BannerLargoContrato")
            End If
        End If
        Put ff, , b()
        Close ff
        Erase b
        If Var <> "" Then
            Set GetImageFromField = LoadPicture(File)
        End If
        Kill File
    Else
        Set GetImageFromField = Nothing
    End If
    
    If rs.State = adStateOpen Then
        rs.Close
        cnn.Close
    End If
    
    Exit Function

ErrHandler:
    MsgBox "ERROR: " & Err.Description, vbExclamation, "Aplicación"
End Function

Public Function campo(ByVal xCampo) As String

If VarType(xCampo) = 1 Or VarType(xCampo) = 0 Or VarType(xCampo) = 9 Then
   campo = ""
Else
   campo = xCampo
End If

End Function

