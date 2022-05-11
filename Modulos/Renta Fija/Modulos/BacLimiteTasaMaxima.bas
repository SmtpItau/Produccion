Attribute VB_Name = "BacLimiteTasaMaxima"
Option Explicit
Global MontoCI As Double
Global TasaCI As Double
Global PlazoCI As Double
Global MonedaCI As String
Global ColocaIB As Boolean
Function Codigo_Producto(Producto As String) As String
    Dim SQL_VALIDA As String
    Dim DATOS()
    
    SQL_VALIDA = "BACTRADERBOSTON..SP_Valida_Lista_Producto " & _
             "'" & Producto & "'"

    If Not Bac_Sql_Execute(SQL_VALIDA) Then
       MsgBox " Error al Cargar la Información", 16, TITSISTEMA
       Exit Function
    End If
    If Bac_SQL_Fetch(DATOS()) Then
       Codigo_Producto = DATOS(1)
    End If

End Function
Function Valida_Tasa_Maxima(Monto As Double, Tasa As Double, Plazo As Double, Moneda As String, RutCli As Double, CodCli As Integer, Form) As Boolean
On Error GoTo Errores

    Dim Tasa_Maxima As Double
    Dim SQL_VALIDA As String
    Dim texto1 As String
    Dim texto2 As String
    Dim DATOS()

    Valida_Tasa_Maxima = False
    
    If Moneda = "UF" Then
        Monto = Format(Monto, FDecimal)
    ElseIf Moneda = "CLP" Then
        Monto = Format((Monto / gsValor_UF), FDecimal)
        Tasa = Tasa '' VGS 28/07/2006 * 12
    Else
       Monto = Format(((Monto * gsValor_DO) / gsValor_UF), FDecimal)
    End If

    
    SQL_VALIDA = "BacParamSuda..Sp_Valida_Compra_Compacto " & _
             "'" & Moneda & "'" & "," & _
             "" & Plazo & "," & _
             "" & RutCli & "," & _
             "" & CodCli & "," & _
             "" & BacCtrlTransMonto2(CDbl(Monto)) & ""
    
    If Not Bac_Sql_Execute(SQL_VALIDA) Then
        MsgBox "Error al Cargar la Información de Maxima Convencional", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    If Bac_SQL_Fetch(DATOS()) Then
    
        If DATOS(1) = "SI" Then
            Valida_Tasa_Maxima = True
            ' Es una Institucion Financiera
            Exit Function
        Else
            Tasa_Maxima = DATOS(2)
        End If
    Else
        Valida_Tasa_Maxima = False
        MsgBox "No Existe Tasa Maxima Convencional Para los Datos Ingresados", vbCritical, TITSISTEMA
        Exit Function
    End If
    
    texto1 = IIf(Moneda = "CLP", "Operacion No Reajustable", "Operacion Reajustable")
    
    If Moneda = "CLP" Then
        texto2 = IIf(Plazo < 90, "Menor a 90 Días.", "Mayor o Igual 90 Días.")
    Else
        texto2 = IIf(Plazo < 365, "Menor a un Año.", "Mayor o Igual Año.")
    End If
    
    If Tasa > Tasa_Maxima Then
        Valida_Tasa_Maxima = False
        'MsgBox "La Tasa Ingresada es Mayor a la Tasa Maxima Convencional: " & Chr(10) & Chr(13) & "Plazo desde " & Str(Val(datos(3))) & " hasta " & Str(Val(datos(4))) & " - Tasa " & Format(datos(2), "#0.000"), vbCritical, TITSISTEMA
         MsgBox "La Tasa Ingresada es Mayor a la Tasa Maxima Convencional " & Chr(10) & Chr(13) & "Para " & texto1 & " " & texto2, vbCritical, TITSISTEMA
        Exit Function
    End If
    
    Valida_Tasa_Maxima = True
    Exit Function
    
Errores:
        MsgBox err.Description, 16, TITSISTEMA
        Valida_Tasa_Maxima = False
        
End Function
