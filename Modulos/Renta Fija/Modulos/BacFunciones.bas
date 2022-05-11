Attribute VB_Name = "BacFunciones"
Option Explicit

Global gsMONEDA_Codigo As Long
Global gsMONEDA_Meno As String
Global gsMONEDA_Decimales As Long
Global gsMONEDA_Nacional As String
Dim Sql              As String
Dim Datos()

Public Function ActualizaDigitador(ByVal numdoc As Double) As Boolean
'JBH, 22-12-2009.  Actualiza el digitador en tabla mdmo para el documento [numdoc]
Dim Datos()
Envia = Array()
Dim nomSp As String
nomSp = "dbo.SP_ACTUALIZADIGITADORMDMO"
AddParam Envia, gsBac_User
AddParam Envia, numdoc
If Bac_Sql_Execute(nomSp, Envia) Then
    ActualizaDigitador = True
Else
    ActualizaDigitador = False
End If
End Function
Public Sub LlenaComboOperadores(ByRef Combo As ComboBox)
'JBH, 22-12-2009
'Llena combo con Operadores
Dim nomSp As String
Dim xUsuario As String
Dim xNombre As String
Dim l1 As Integer
Dim l2 As Integer
Dim Linea As String
Dim dif As Integer
Dim Datos()
nomSp = "bacparamsuda.DBO.SP_CARGAOPERADORES"
Envia = Array()
If Not Bac_Sql_Execute(nomSp, Envia) Then
    Screen.MousePointer = 0
    Exit Sub
End If
Do While Bac_SQL_Fetch(Datos)
    xUsuario = Datos(1)
    xNombre = Datos(2)
    l1 = Len(xUsuario)
    l2 = Len(xNombre)
    dif = 110 - l2
    Linea = xNombre & Space(dif) & xUsuario
    Combo.AddItem (Linea)
Loop
End Sub
Public Function ControlAtribuciones() As Boolean
 Dim oHabilita  As Boolean
   Dim SqlDatos()
   
   Envia = Array()
   AddParam Envia, gsBac_User
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONTROL_ATRIBUCIONES", Envia) Then
      oHabilita = True
   End If
   If Bac_SQL_Fetch(SqlDatos()) Then
      oHabilita = SqlDatos(1)
   End If
   ControlAtribuciones = oHabilita
End Function
Public Sub Proc_Buscar_Valor_Combo(oCombo As Object, cValor As String)
    
    Dim nContador   As Integer

    For nContador = 0 To oCombo.ListCount - 1
    
        If Trim(Right(oCombo.List(nContador), 10)) = Trim(cValor) Then
            oCombo.ListIndex = nContador
            Exit Sub
        End If
    
    Next nContador
    
    
    oCombo.ListIndex = -1


End Sub

Sub PROC_LLENA_COMBOS(Combo As Object, opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String, Optional cParametro6 As String)
'   PROC_LLENA_COMBOS(Codigo_Categoria As Double, COMBO As Object, bTodos As Boolean)
Dim DATOS()
Envia = Array()
'Corregido para LD1-COR-035
If (opcion <> 1111) Then
    Envia = Array()
    AddParam Envia, opcion
    AddParam Envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam Envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam Envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam Envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam Envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
    AddParam Envia, IIf(Trim(cParametro6) <> "", Trim(cParametro6), "")

    If Not Bac_Sql_Execute("BacTraderSuda.dbo.SP_CON_INFO_COMBO", Envia) Then
        If opcion = 11 Then
            ' LD1-COR-035 FUSION CORPBANCA - ITAU
            ' Esta opcion es Volcker Rule
            MsgBox "Este usuario no tiene definido Volcker Rule. No se puede realizar la grabación", vbCritical
            Combo.Enabled = False
            
            Exit Sub
      
        Else
            MsgBox "Problemas al Intentar llanar el combo", vbCritical
            Exit Sub
        End If
    End If
    
    Combo.Clear
    
    If bTodos = True Then
        Combo.AddItem "< TODOS [AS] >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Combo.AddItem Datos(6) & Space(110) & Datos(2)
    Loop
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = 0
    End If


    Else
     Envia = Array()
     AddParam Envia, opcion
          If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
                   MsgBox "Problemas al Intentar llanar el combo", vbCritical
                 Exit Sub
             End If
    If (bTodos = False) Then
     Combo.Clear
     End If
      
        Do While Bac_SQL_Fetch(DATOS())
            Combo.AddItem DATOS(2) & Space(110) & DATOS(1)
        Loop
        If Combo.ListCount > 0 Then
            Combo.ListIndex = 0
        End If


End If


'''''    Envia = Array()
'''''    AddParam Envia, Codigo_Categoria
'''''
'''''    If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
'''''        MsgBox "Problemas al Intentar llanar el combo"
'''''        Exit Sub
'''''    End If
'''''
'''''    Combo.Clear
'''''
'''''    If bTodos = True Then
'''''       Combo.AddItem "TODOS" & Space(80)
'''''    End If
'''''
'''''
'''''    Do While Bac_SQL_Fetch(Datos())
'''''        Combo.AddItem Datos(6) & Space(80) & Datos(2)
'''''    Loop
'''''
'''''    If Combo.ListCount > 0 Then
'''''        Combo.ListIndex = 0
'''''    End If
'''''

End Sub

Function DiaSemana(xFecha As Date) As String
Dim cDia As Integer

        cDia = DatePart("w", xFecha)
        
        Select Case cDia
            Case 1:
                DiaSemana = "Domingo"
            Case 2:
                DiaSemana = "Lunes"
            Case 3:
                DiaSemana = "Martes"
            Case 4:
                DiaSemana = "Miercoles"
            Case 5:
                DiaSemana = "Jueves"
            Case 6:
                DiaSemana = "Viernes"
            Case 7:
                DiaSemana = "Sabado"
      End Select

End Function




Function FUNC_Decimales_de_Moneda(vMoneda As Variant) As Long
Dim Datos()
   If Not IsNumeric(vMoneda) Then
      vMoneda = Val(vMoneda)
   End If
If Bac_Sql_Execute("SP_CON_INFORMACION_MONEDA", Array(vMoneda)) Then
    Do While Bac_SQL_Fetch(Datos())
        gsMONEDA_Codigo = Datos(1)
        gsMONEDA_Meno = Datos(2)
        gsMONEDA_Decimales = Datos(3)
        gsMONEDA_Nacional = IIf(Datos(4) = 0, "S", "N")
        FUNC_Decimales_de_Moneda = Datos(3)
    Loop
Else
    MsgBox "Problemas con la conneccion de al servidor", vbExclamation
End If

End Function
Function IsMenor(ByVal Numero&, ByVal Menor&)


If Numero& < Menor& Then
   IsMenor = Menor&
Else
   IsMenor = Numero&
End If


End Function

Function MONTO_ESCRITO(n As Double) As String

ReDim uni(15) As String
ReDim Dec(9) As String
Dim z, Num, Var   As Variant
Dim c, D, u, v, i As Integer
Dim k

If n = 0 Or n > 1E+17 Then
   MONTO_ESCRITO = IIf(n = 0, "CERO", "*")
   Exit Function
End If

uni(1) = "UN"
uni(2) = "DOS"
uni(3) = "TRES"
uni(4) = "CUATRO"
uni(5) = "CINCO"
uni(6) = "SEIS"
uni(7) = "SIETE"
uni(8) = "OCHO"
uni(9) = "NUEVE"
uni(10) = "DIEZ"
uni(11) = "ONCE"
uni(12) = "DOCE"
uni(13) = "TRECE"
uni(14) = "CATORCE"
uni(15) = "QUINCE"

Dec(3) = "TREINTA"
Dec(4) = "CUARENTA"
Dec(5) = "CINCUENTA"
Dec(6) = "SESENTA"
Dec(7) = "SETENTA"
Dec(8) = "OCHENTA"
Dec(9) = "NOVENTA"

Num = String$(19 - Len(Str(Trim(n))), Space(1))
Num = Num + Trim(Str(n))
i = 1
z = ""

Do While True
   k = Mid(Num, 18 - (i * 3 - 1), 3)

   If k = Space(3) Then
      Exit Do
   End If

   c = Val(Mid(k, 1, 1))
   D = Val(Mid(k, 2, 1))
   u = Val(Mid(k, 3, 1))
   v = Val(Mid(k, 2, 2))

   If i > 1 Then
      If (i = 2 Or i = 4) And Val(k) > 0 Then
         z = " MIL " + z
      End If
      If i = 3 And Val(Mid(Num, 7, 6)) > 0 Then
         If Val(k) = 1 Then
            z = " MILLON " + z
         Else
            z = " MILLONES " + z
         End If
      End If
      If i = 5 And Val(k) > 0 Then
         If Val(k) = 1 Then
            z = " BILLON " + z
         Else
            z = " BILLONES " + z
         End If
      End If
   End If

   If v > 0 Then
      Select Case v
             Case 0 To 15
                  z = uni(v) + z
             Case 0 To 19
                  z = " DIECI" + uni(u) + z
             Case 20
                  z = " VEINTE " + z
             Case 0 To 29
                  z = " VEINTI" + uni(u) + z
             Case Else
                  If u = 0 Then
                     z = Dec(D) + z
                  Else
                     z = Dec(D) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If c > 0 Then
      If c = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If c = 2 Or c = 3 Or c = 4 Or c = 6 Or c = 8 Then
         z = uni(c) + "CIENTOS " + z
      End If
      If c = 5 Then
         z = " QUINIENTOS " + z
      End If
      If c = 7 Then
         z = " SETECIENTOS " + z
      End If
      If c = 9 Then
         z = " NOVECIENTOS " + z
      End If
   End If

   i = i + 1
Loop

MONTO_ESCRITO = Trim(z)
End Function









Sub Proc_fmt_Numerico(texto As Control, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String)

   Dim PosPto%

   If Tecla = 13 Or Tecla = 27 Then
      Exit Sub

   End If

   If Tecla = 45 And Signo = "+" Then
      Tecla = 0

   End If

   If Tecla <> 8 And (Tecla < 48 Or Tecla > 57) Then
      If NDecs = 0 Then
         Tecla = 0

      ElseIf Tecla <> 46 And Tecla <> 45 Then
         Tecla = 0

      End If

   End If

   If Tecla = 45 And Signo = "-" Then  ' Signo negativo
      If InStr(texto.Text, "-") > 0 Then
         Tecla = 0

      ElseIf texto.SelStart > 0 Then
         If Mid(texto.Text, texto.SelStart, 1) <> "" Then
            Tecla = 0

         End If

      End If

   End If

   PosPto% = InStr(texto.Text, ".")

   If PosPto% > 0 And Tecla = 46 Then
      Tecla = 0
      Exit Sub

   End If

   If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
      PosPto% = PosPto% + 1

      If Len(Mid(texto.Text, PosPto%, NDecs)) = NDecs And Tecla <> 8 Then
         Tecla = 0

      Else
         Exit Sub

      End If

   End If

   If PosPto% > 0 And texto.SelStart < PosPto% And Tecla <> 8 Then
      If Len(Mid(texto.Text, 1, PosPto% - 1)) >= NEnteros Then
         Tecla = 0

      End If

   ElseIf PosPto% = 0 And Tecla <> 8 And Chr(Tecla) <> "." Then
      If Len(texto.Text) >= NEnteros Then
         Tecla = 0

      End If

   End If

End Sub



Public Function ActivarBarra()

   With BacTrader.Pnl_Entidad
      .FloodPercent = 0
      .FloodType = 1
      .FloodShowPct = True
      .Tag = .ForeColor

   End With

End Function

Public Function BACChBl(cText As String)

    If cText = "" Then
        BACChBl = 0
    Else
        BACChBl = cText
    End If

End Function

Public Function DesactivarBarra()

   With BacTrader.Pnl_Entidad
      .FloodPercent = 0
      .FloodType = 0
      .FloodShowPct = False
      .ForeColor = .Tag

   End With

   BacTrader.Pnl_Entidad.Caption = Mid$(gsBac_Clien, 1, 30)

End Function

Public Function ActualizarBarra(nPos As Double, nLar As Double)

   Dim nPorcent      As Double

   nPorcent = (nPos / nLar) * 100

   With BacTrader.Pnl_Entidad
      .FloodPercent = nPorcent

      If nPorcent >= 45 And .ForeColor <> &HFFFFFF Then
         .ForeColor = &HFFFFFF

      ElseIf nPorcent < 45 And .ForeColor <> &H0 Then
         .ForeColor = &H0

      End If

      .Refresh

   End With

End Function

Function BacPad(Dato As Variant, Pos As String, Largo As Integer) As String

   Dato = CStr(Dato)

   If Trim(Pos$) = "" Then
      Pos$ = "I"

   End If

   If Largo < Len(Trim(Dato)) Then
      BacPad = Mid(Trim(Dato), 1, Largo)
      Exit Function

   End If

   If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
      BacPad = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)

   Else                          'DERECHA
      BacPad = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")

   End If

   'BacPad = Mid(BacPad, 1, Largo)

End Function

Public Function BacStrcero(sValor As Variant, nLargo As Integer) As String

   Dim sCadena       As String
   Dim i             As Integer

   For i = 1 To nLargo
      sCadena = sCadena + "0"

   Next i

   sValor = Trim(CStr(sValor))
   BacStrcero = Mid$(sCadena, 1, nLargo - Len(sValor)) + sValor

End Function


'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
' Function que retorna caracteres alineados segun especificacion
' D   = Caraceteres alineados hacia la derecha
' I   = Caraceteres alineados hacia la Izquierda
'----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Function GFun_Concatena(ByVal Valor As Variant, ByVal Largo%, ByVal Caracter$, ByVal Alineado$) As String

Dim xLen%
Dim xResta%
Dim ValorAux      As Variant

ValorAux = Trim(Valor)
    xLen = Len(ValorAux)

If xLen% > Largo% Then
   
   GFun_Concatena = Mid(ValorAux, 1, Largo%)
   Exit Function
   
End If

xResta% = Largo% - xLen%

If Alineado <> "D" Then
    GFun_Concatena = String(xResta%, Caracter) + ValorAux
Else
    GFun_Concatena = ValorAux + String(xResta, Caracter)
End If

End Function

Public Function Func_Limpiar_Estr_Grabar()

   With BacGrabar
         .TipOper = ""
         .Rutcart = gsBac_CartRUT
         .DigCart = gsBac_CartDV
         .NomCart = gsBac_CartNOM
         .TipCart = 1
      .ForPagoIni = 0
     .ForPagoVcto = 0
     .VamosVienen = "V"
      .RutCliente = 0
      .DigCliente = ""
      .NomCliente = ""
      .CodCliente = 1
          .Observ = ""
       .CtaCteIni = ""
      .CtaCtevcto = ""

   End With

End Function


Public Function BacCheckSemana(dFecha As Date, cTexto As Object) As String

   Dim nDia          As Integer

   cTexto.ForeColor = vbBlue

   nDia = DatePart("w", dFecha)

   Select Case nDia
   Case 1
      cTexto.ForeColor = vbRed

   Case 7
      cTexto.ForeColor = vbRed

   End Select

   BacCheckSemana = BacDiaSemana(dFecha)

End Function

Function BacDiaSemana(dFecha As Date) As String

   Dim nDia          As Integer

   nDia = DatePart("w", dFecha)

   Select Case nDia
   Case 1
      BacDiaSemana = "Domingo"

   Case 2
      BacDiaSemana = "Lunes"

   Case 3
      BacDiaSemana = "Martes"

   Case 4
      BacDiaSemana = "Miercoles"

   Case 5
      BacDiaSemana = "Jueves"

   Case 6
      BacDiaSemana = "Viernes"

   Case 7
      BacDiaSemana = "Sabado"

   End Select

End Function

Public Sub Func_Buscar_Moneda_Producto(nCodigo As Integer, objControl As Object)

   Dim nPos          As Integer

   objControl.Clear

   Sql = "EXECUTE sp_busca_moneda_producto 'BTR', " & nCodigo

   If miSQL.SQL_Execute(Sql) <> 0 Then
      MsgBox "Problemas al cargar las monedas", vbExclamation, "Cargatura de Monedas"
      Exit Sub

   End If

   Do While miSQL.SQL_Fetch(Datos()) = 0
      objControl.AddItem Datos(2)
      objControl.ItemData(objControl.NewIndex) = Datos(1)

      If Datos(1) = "999" Then
         nPos = objControl.ListCount - 1

      End If

   Loop

   If nPos >= 0 Then
      objControl.ListIndex = nPos

   End If

End Sub

Function BacProxHabil(xFecha As String) As String

   Dim dFecha As String
    
   dFecha = xFecha
   dFecha = Format(DateAdd("d", 1, dFecha), "DD/MM/YYYY")

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), "DD/MM/YYYY")

   Loop

   BacProxHabil = dFecha

End Function

Function BacAnteHabil(xFecha As String) As String

   Dim dFecha As String
    
   dFecha = xFecha
   dFecha = Format(DateAdd("d", -1, dFecha), "DD/MM/YYYY")

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", -1, dFecha), "DD/MM/YYYY")

   Loop

   BacAnteHabil = dFecha

End Function

Public Function ClienteBloqueado(ByVal Sistema As String, ByVal nRut As Double, ByVal nCod As Double, ByRef codBloqueo As Double, ByRef motBloqueo As String) As Boolean
    Dim nomSp As String
    Dim estBloqueo As String
    ClienteBloqueado = True
    codBloqueo = -1
    motBloqueo = ""
    Dim Datos()
    Envia = Array()
    AddParam Envia, 0
    AddParam Envia, nRut
    AddParam Envia, nCod
    AddParam Envia, "L"
    nomSp = "BacParamsuda.dbo.SP_MNT_BLOQUEOS_CLIENTES"
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Function
    End If
    If Not Bac_SQL_Fetch(Datos()) Then
        'No se encontró el cliente en Bloqueos, se asume no bloqueado
        motBloqueo = ""
        ClienteBloqueado = False
        Exit Function
    End If
    estBloqueo = Datos(9)
    If estBloqueo = "N" Then
        ClienteBloqueado = False
    Else
        codBloqueo = CDbl(Datos(10))
        motBloqueo = "CAUSA DE BLOQUEO: " & Datos(11)
    End If
End Function
Function GrabaBloqueoCliente(ByVal codSistema As String, ByVal codProducto As String, ByVal NumOp As Double, ByVal tipoOp As String, ByVal qBloqueo As Double, ByVal qMotivo As String) As Boolean
    Dim nomSp As String
    Dim Datos()
    Envia = Array()
    GrabaBloqueoCliente = False
    nomSp = "BacParamsuda.dbo.SP_GRABA_BLOQUEOCLIENTE_CF"
    AddParam Envia, codSistema
    AddParam Envia, codProducto
    AddParam Envia, NumOp
    AddParam Envia, tipoOp
    AddParam Envia, qMotivo
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "OK" And Datos(2) = "OK" Then
            GrabaBloqueoCliente = True
        End If
    End If
End Function

