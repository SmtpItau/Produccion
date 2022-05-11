Attribute VB_Name = "modControlPT"
Global modoOperacionCPT As String
Public Function ConsultaModoOperacionControlPT() As String
    modoOperacionCPT = "N"  'Por defecto será Normal
    Dim leido As String
    Dim DATOS()
    Dim sp As String
    sp = "Bacparamsuda..sp_RetModoControlPreciosTasas"
    If Not Bac_Sql_Execute(sp) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(DATOS())
        leido = UCase(DATOS(1))
        Exit Do
    Loop
    If leido <> "S" And leido <> "N" Then
        modoOperacionCPT = "N"
    Else
        modoOperacionCPT = leido
    End If
End Function

