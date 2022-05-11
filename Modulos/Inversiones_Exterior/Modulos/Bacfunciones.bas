Attribute VB_Name = "BacFunciones"
Option Explicit
Public gstrODBC_SCN As String

Sub PROC_LLENA_COMBOS(COMBO As Object, Opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String, Optional cParametro6 As String, Optional cParametro7 As String)
Dim Datos()

    envia = Array()
    AddParam envia, Opcion
    AddParam envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
    AddParam envia, IIf(Trim(cParametro6) <> "", Trim(cParametro6), "")
    AddParam envia, IIf(Trim(cParametro7) <> "", Trim(cParametro7), "")
        
    If Not Bac_Sql_Execute("sp_con_info_combo", envia) Then
        MsgBox "Problemas al Intentar llanar el combo", vbCritical + vbOKOnly
        Exit Sub
    End If
    
    COMBO.Clear
    
    If bTodos = True Then
        COMBO.AddItem "< TODOS (AS) >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
               
        COMBO.AddItem Datos(6) & Space(110) & Datos(2)
                        
    Loop
    
    If COMBO.ListCount > 0 Then
        COMBO.ListIndex = 0
    End If
End Sub
Public Sub LlenaComboOperadores(ByRef COMBO As ComboBox)
'JBH, 22-12-2009.   Llena combo con Operadores
Dim nomSp As String
Dim xUsuario As String
Dim xNombre As String
Dim l1 As Integer
Dim l2 As Integer
Dim Linea As String
Dim dif As Integer
Dim Datos()
nomSp = "bacparamsuda.dbo.sp_CargaOperadores"
envia = Array()
If Not Bac_Sql_Execute(nomSp, envia) Then
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
    COMBO.AddItem (Linea)
Loop
End Sub
Public Function ActualizaDigitador(ByVal numdoc As Double) As Boolean
'JBH, 22-12-2009.  Actualiza el digitador en tabla text_mvt_dri para el documento [MONUMOPER]
Dim Datos()
envia = Array()
Dim nomSp As String
nomSp = "dbo.sp_ActualizaDigitadorMvtDri"
AddParam envia, gsBac_User
AddParam envia, numdoc
If Bac_Sql_Execute(nomSp, envia) Then
    ActualizaDigitador = True
Else
    ActualizaDigitador = False
End If
End Function
Public Function ControlAtribuciones() As Boolean
 Dim oHabilita  As Boolean
   Dim Sqldatos()

   envia = Array()
   AddParam envia, gsBac_User
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONTROL_ATRIBUCIONES", envia) Then
      oHabilita = True
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      oHabilita = Sqldatos(1)
   End If
   ControlAtribuciones = oHabilita
End Function

Public Function Func_Cartera(COMBO As ComboBox, Sistema As String)
Dim SQL   As String
Dim Datos()
Dim i As Integer
    
COMBO.Clear

COMBO.AddItem "< TODAS >"
COMBO.ItemData(COMBO.NewIndex) = 0


envia = Array()

    AddParam envia, Sistema

    SQL = "BACPARAMSUDA..Sp_LeeCarteraSistema"
   If Not Bac_Sql_Execute(SQL, envia) Then
      Screen.MousePointer = vbDefault
      Exit Function
   Else
      Do While Bac_SQL_Fetch(Datos())
           
           COMBO.AddItem UCase(Datos(2))
           COMBO.ItemData(COMBO.NewIndex) = Val(Datos(1))
           
      Loop
   End If

If COMBO.ListCount > 0 Then COMBO.ListIndex = 0

End Function

Public Function BacPad(sCadena As String, nLargo As Integer) As String

    Dim nCarac          As Integer

    If Len(sCadena) >= nLargo Then
        BacPad = Mid$(sCadena, 1, nLargo)

    Else
       BacPad = sCadena + Space$(nLargo - Len(sCadena))

    End If

End Function

Public Function bacTranMontoSql(nMonto As Variant) As String
Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   bacTranMontoSql = "0.0"

   sCadena = CStr(nMonto)

   iPosicion = InStr(1, sCadena, gsBac_PtoDec)

   If iPosicion = 0 Then
      bacTranMontoSql = sCadena

   Else
      bacTranMontoSql = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)

   End If

End Function

Function BACFinMES(Fecha) As Boolean
BACFinMES = False

    If Day(CDate(Fecha)) = 30 And (Month(CDate(Fecha)) = 11 Or Month(CDate(Fecha)) = 4 Or Month(CDate(Fecha)) = 6 Or Month(CDate(Fecha)) = 11) Then
        BACFinMES = True
    ElseIf Day(CDate(Fecha)) = 31 And (Month(CDate(Fecha)) = 1 Or Month(CDate(Fecha)) = 3 Or Month(CDate(Fecha)) = 5 Or Month(CDate(Fecha)) = 7 Or Month(CDate(Fecha)) = 31 Or Month(CDate(Fecha)) = 10 Or Month(CDate(Fecha)) = 12) Then
        BACFinMES = True
    ElseIf (Day(CDate(Fecha)) = 28 Or Day(CDate(Fecha)) = 29) And Month(CDate(Fecha)) = 2 Then
        BACFinMES = True
        
    End If
End Function


'Function Monto_a_Peso(Operacion, Moneda, Monto) As Double
'
'    Dim ValorDolar As Double
'    Dim Ref As String
'    Dim Paridad As Double
'    Dim Sql        As String
'    Dim Datos()
'
'    If BACFinMES(gsBac_Fecp) Then
'        If Operacion = "CP" Then
'            ValorDolar = gsBac_DolarObs
'        Else
'            ValorDolar = gsBac_DolarMesAnt
'        End If
'    Else
'            ValorDolar = gsBac_DolarMesAnt
'    End If
'
'    If Moneda = 994 Or Moneda = 13 Then
'        Monto_a_Peso = Round(Monto * ValorDolar, 0)
'    ElseIf Moneda <> 998 Or Moneda <> 999 Then
'
'        envia = Array()
'        AddParam envia, Moneda
'        AddParam envia, Format(gsBac_Fecp, "YYYYMMDD")
'
'        If Not Bac_Sql_Execute("Sp_LeerMonedasValor", envia) Then
'            Exit Function
'        End If
'
'        If Bac_SQL_Fetch(Datos()) Then
'            Ref = Datos(9)
'            Paridad = IIf(IsNull(Datos(16)), 1, Datos(16))
'        End If
'        If Ref = "D" Then
'            Monto_a_Peso = Round((Monto / Paridad) * ValorDolar, 0)
'        Else
'            Monto_a_Peso = Round((Monto * Paridad) * ValorDolar, 0)
'        End If
'
'    End If
'
'
'End Function
Function Monto_a_Peso(Operacion, Moneda, Monto) As Double
    
    Dim ValorDolar As Double
    Dim ValorTipoCambio As Double
    Dim Ref As String
    Dim Paridad As Double
    Dim SQL        As String
    Dim Datos()
    
    'Montos a peso con valor dolar hoy , solicitado por banco
   
    If Month(gsBac_Fecx) <> Month(gsBac_Fecp) Then
        If Operacion = "CP" Then
            ValorDolar = gsBac_DolarObs
        Else
            ValorDolar = gsBac_DolarMesAnt
        End If
    Else
            ValorDolar = gsBac_DolarMesAnt
    End If

    If Moneda = 994 Or Moneda = 13 Then
        Monto_a_Peso = Round(Monto * ValorDolar, 0)
    
    ElseIf Moneda = 999 Then
         Monto_a_Peso = Round(Monto, 0)
         
    Else
        ValorTipoCambio = 0
        envia = Array()
        AddParam envia, Moneda
        AddParam envia, Format(gsBac_Fecp, "YYYYMMDD")
        
        If Not Bac_Sql_Execute("SP_LEERMONEDASVALOR", envia) Then
            Exit Function
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
            ValorTipoCambio = Datos(12)
            
        End If
        
            Monto_a_Peso = Round(Monto * ValorTipoCambio, 0)
        
    End If
    

End Function

Sub Grabar_Log(xSistema As String, xUsuario As String, xFechaProc As Date, xEvento As String)
Dim Datos()
    
    If Len(xEvento) > 255 Then
        xEvento = Right(xEvento, 255)
    End If
    
   envia = Array()
   AddParam envia, xSistema
   AddParam envia, xUsuario
   AddParam envia, xFechaProc
   AddParam envia, xEvento
            
    If Bac_Sql_Execute("SP_GRABAR_LOG", envia) Then
        If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = "NO" Then
                MsgBox "Problemas al grabar log", vbOKOnly + vbExclamation
            End If
        End If
    End If
    
End Sub

Public Sub GRABA_LOG_AUDITORIA(Entidad, FechaProc, Terminal, Usuario, IdSistema, codigoMenu, CodigoEvento, _
 DetalleModificacion, TablaInvolucrada, ValorAntiguo, ValorNuevo As String)

 envia = Array()

 AddParam envia, Entidad
 AddParam envia, FechaProc
 'AddParam Envia, FechaSis
 'AddParam Envia, HoraProc
 AddParam envia, Terminal
 AddParam envia, Usuario
 AddParam envia, IdSistema
 AddParam envia, codigoMenu
 AddParam envia, CodigoEvento
 AddParam envia, DetalleModificacion
 AddParam envia, TablaInvolucrada
 AddParam envia, ValorAntiguo
 AddParam envia, ValorNuevo
 

 If Not Bac_Sql_Execute(gsSQL_Database_comun & "..sp_log_auditoria ", envia) Then
     MsgBox "Problemas al Grabar Log de Auditoria.", vbCritical
 Else
     'grabacion exitosa
 End If
 
End Sub
Function BacUltimoDia(cFecha As String, cAdelante As String) As String
   Dim nDia      As Integer
   Dim nMes      As Integer
   Dim nYear     As Integer
   Dim dFecha1   As String
   
   nMes = DatePart("m", cFecha)
   nDia = 1
   nYear = DatePart("yyyy", cFecha)
   
   If cAdelante = "SI" Then
           
      nMes = nMes + 1
      If nMes > 12 Then
         nMes = 1
         nYear = nYear + 1
      End If
      
   End If
   
   dFecha1 = Str(nDia) + "/" + Str(nMes) + "/" + Str(nYear)
   dFecha1 = Format$(dFecha1, "DD/MM/YYYY")
   dFecha1 = Format(DateAdd("d", -1, dFecha1), "dd/MM/YYYY")
   
   BacUltimoDia = dFecha1

End Function
'Trae datos de una moneda a partir del codigo
'Public Function LeerMonedasPorCodigo(Codigo As Integer, Fecha As String) As Boolean
'
'   Dim Sql        As String
'   Dim DATOS()
'
'   LeerMonedasPorCodigo = False
'   envia = Array()
'   AddParam envia, Codigo
'   AddParam envia, Format(Fecha, "YYYYMMDD")
'
'
'   If Not Bac_Sql_Execute("Sp_LeerMonedasValor", envia) Then
'      Exit Function
'   End If
'
'   'Call Limpiar
'
'   If Bac_SQL_Fetch(DATOS()) Then
'
'      mncodigo = Val(DATOS(1))
'      mnglosa = DATOS(2)
'      mnnemo = DATOS(3)
'      mnfactor = Val(DATOS(4))
'      mnredondeo = Val(DATOS(5))
'      mncodbanco = Val(DATOS(6))
'      mncodsuper = DATOS(7)
'      mnbase = Val(DATOS(8))
'      mnrefusd = DATOS(9)
'      mnlocal = DATOS(10)
'      mnextranj = DATOS(11)
'      mnvalor = DATOS(12)
'      MNREFMERC = DATOS(13)
'      'mntipval = Val(Datos(14))
'      LeerMonedasPorCodigo = True
'
'   End If
'
'End Function
'
Public Function FUNC_BUSCA_VALOR_MONEDA(Moneda As Integer, Fecha As String) As Double
Dim Datos()

    FUNC_BUSCA_VALOR_MONEDA = 0#
    
    If Moneda <> 13 And Moneda <> 999 Then  ' VB+- 25/07/2000 se excluye moneda 13 pues es dolar dolar y tipo cambio es 1
'        Sql = "SP_VMLEERIND "
'        Sql = Sql & Moneda & ",'"
'        Sql = Sql & Format(Fecha, feFECHA) & "'"

        envia = Array(CDbl(Moneda), Format(Fecha, feFECHA))
              
        If Not Bac_Sql_Execute("SP_VMLEERIND", envia) Then
            Exit Function
        End If
    
        If Not Bac_SQL_Fetch(Datos()) Then
            Exit Function
        End If
    
        If CDbl(Datos(1)) = 0 Then
            MsgBox "Tipo de cambio, para la moneda seleccionada es de valor 0, verifique tipos de cambios del día", vbExclamation, "Inversiones Exterior"
            Exit Function
        End If
    
        FUNC_BUSCA_VALOR_MONEDA = Val(Datos(1))
    Else
        FUNC_BUSCA_VALOR_MONEDA = 1
    End If
    

End Function

Function llena_combo_forma_pago(moneda1 As Integer, moneda2 As Integer, COMBO As ComboBox)
    Dim Datos()
    Dim i
    COMBO.Clear

   envia = Array()
    AddParam envia, moneda1
    AddParam envia, moneda2
    If Bac_Sql_Execute("SVC_OPE_FMA_PAG", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            COMBO.AddItem Datos(6)
            COMBO.ItemData(COMBO.NewIndex) = Val(Datos(5))
        Loop
    End If
    
    If COMBO.ListCount > 0 Then
            For i = 0 To COMBO.ListCount - 1
               If COMBO.ItemData(i) = 111 Or COMBO.ItemData(i) = 122 Then
                  COMBO.ListIndex = i
                  Exit For
               End If
            Next
        End If
    
End Function

' ============================================================================================
Function BacPunto(txtObjeto As Object, xkeyascii As Integer, xEntero As Integer, xRedondeo As Integer) As Integer
' ============================================================================================
'   Función     : BacPunto
'   Objetivo    : Validar el ingreso de decimales
'   Autor       : Miguel Gajardo
'   Fecha       : 15/05/2000
' ============================================================================================
If Not IsNumeric(Chr(xkeyascii)) And Chr(xkeyascii) <> "." And Chr(xkeyascii) <> "," And xkeyascii <> 8 And xkeyascii <> 13 Then
  xkeyascii = 0
End If
       If Chr(xkeyascii) = "." Or Chr(xkeyascii) = "," Then
            If InStr(1, txtObjeto.Text, ".") <> 0 Then
              xkeyascii = 0
            End If
        End If
        If InStr(1, txtObjeto.Text, ".") <> 0 Then
            If Len(Mid(txtObjeto.Text, InStr(1, txtObjeto.Text, "."))) > xRedondeo And xkeyascii <> 8 And xkeyascii <> 13 Then
              xkeyascii = 0
            End If
        Else
            If Len(txtObjeto.Text) >= xEntero And xkeyascii <> 8 And xkeyascii <> 13 And Chr(xkeyascii) <> "." And Chr(xkeyascii) <> "," Then
                 xkeyascii = 0
            End If
        End If
        If (Chr(xkeyascii) = "." Or Chr(xkeyascii) = ",") And xRedondeo = 0 Then
           xkeyascii = 0
        End If
        
    BacPunto = xkeyascii
End Function

Function Encript(xClave As String, xEncriptar As Boolean) As String
Dim X As Single
Dim xPsw As String
Dim Letras As String
Dim Codigos As String

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐ"
'Codigos = "ÿ[¦´«]#$%&úß¡?ý}<_>§æØáø×ƒ®ÇéåêëèïîÐABCDEFGHIJKLMNOPQRSTUVWXYWZ1234567890"

'Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyz"
'Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><"

Letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzÑñ#$%&()*+/=[\]_{}"
Codigos = "RaMbKCgTrZHYFIPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}ve]htwl[\`@?><Ññ1234567890;:.'~¿"


xPsw = ""
Encript = ""

For X = 1 To Len(xClave)
 
 If xEncriptar Then
    xPsw = xPsw + Chr((Asc(Mid(Codigos, InStr(1, Letras, Mid(xClave, X, 1)), 1)) - X))
 Else
    xPsw = xPsw + Mid(Letras, InStr(1, Codigos, Chr(Asc(Mid(xClave, X, 1)) + X)), 1)
 End If
 
Next

Encript = xPsw

End Function

Public Function Bloqueado(xUsuario As String) As Boolean
Dim Datos()
Bloqueado = False
   If Bac_Sql_Execute("Sp_TraeBloqueo_Usuario", Array(xUsuario)) Then
       If Bac_SQL_Fetch(Datos()) Then
          If Datos(1) = "1" Then
             Bloqueado = True
             Exit Function
          End If
       End If
   End If
End Function

Function Bloquea_Usuario(xBloquea As Boolean, xUsuario As String) As Boolean
   Bloquea_Usuario = False
   envia = Array(xUsuario, IIf(xBloquea, 1, 0))
   
   If Not Bac_Sql_Execute("SP_BLOQUEA_GEN_USUARIO", envia) Then
      Exit Function
   End If
   Bloquea_Usuario = True
   
End Function



Function Ceros(Dato As String, Largo As Integer) As String
Dim i%
Dim cero%

cero = (Largo - Len(Dato))
For i = 1 To cero
  Ceros = Ceros + "0"
Next i

End Function
Function ESPACIOS(Dato As String, Largo As Integer) As String

    ESPACIOS = 0
    
    If Len(Dato) <= Largo Then
        ESPACIOS = Space((Largo - Len(Dato)))
    End If

End Function
Public Function Trae_Nom_Campos(Nom_Tabla As String, ByRef Arr As String, Optional Sin_Campos As String) As Boolean
Dim C_Sql As String
Dim Datos()
Dim Ind As Integer
Dim Arreglo()

Trae_Nom_Campos = True
Arr = ""
If miSQL.SQL_Execute("Sp_Traecampos '" & CStr(Nom_Tabla) & "'") = 0 Then
  Ind = 1
  Do While Bac_SQL_Fetch(Datos())
    If InStr(Sin_Campos, Datos(Ind)) < 1 Then Arr = Arr & Datos(Ind) & Chr(9)
  Loop
End If

End Function
Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
         
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas

Dim iPos%
Dim iLen%
         
    If Trim$(sCadena$) = "" Then
       sCadena$ = "0"
    End If
    
    iPos% = 1
    
    iLen% = Len(sFind$)
    
    Do While True
        iPos% = InStr(1, sCadena$, sFind$)
        If iPos% = 0 Then
                Exit Do
        End If
        sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    Loop
    
    BacStrTran = Trim$(CStr(sCadena$))
         
End Function


Public Function posiciona_texto(grilla As Control, Texto As Control)

    Texto.Top = grilla.Top + grilla.CellTop
    Texto.Left = grilla.Left + grilla.CellLeft
    Texto.Width = grilla.CellWidth
    Texto.Height = grilla.CellHeight
    
    Texto.Text = ""
    Texto.Visible = True
    
    Texto.SetFocus


End Function
  
Public Function gfunFormatRut(ByVal rut As String) As String

    Dim Largo           As Integer
    Dim Rec             As Integer
    Dim Aux             As String
    Dim Pal             As String
    
    If Trim(rut) = "" Then
        gfunFormatRut = ""
        Exit Function
    End If
    gfunFormatRut = rut
    For Rec = 1 To Len(gfunFormatRut)
        If Mid(gfunFormatRut, Rec, 1) <> "-" Then
            Aux = Aux & Mid(gfunFormatRut, Rec, 1)
        End If
    Next
    
    Largo = Len(Aux)
    If Largo < 10 Then
        Pal = ""
        For Rec = 1 To (10 - Largo)
            Pal = Pal & "0"
        Next
        gfunFormatRut = Pal & Aux
    Else
        gfunFormatRut = Aux
    End If
End Function
Public Function rutConGuion(ByVal rut As String) As String
 'El Rut 0124862175 lo entrega como 012486217-5
   rutConGuion = Left(rut, 9) & "-" & Right(rut, 1)
End Function
Public Function gfunCapturaDeErrores(Optional formulario As String)
    Dim Msg                 As String
    Dim errBucle            As Error
    Dim NombreFormulario    As String
    
    NombreFormulario = formulario
    Msg = "Error Número : " & err.Number & Chr(13) & Chr(13)
    Msg = Msg & "Descripción   : "
    Select Case err.Number
        Case 3146:
            Msg = ""
            For Each errBucle In Errors
                Msg = Msg & "Error Número : " & errBucle.Number & Chr(13)
                Msg = Msg & "Descripción   : " & errBucle.Description & Chr(13)
                Msg = Msg & "Origen                             Datos : " & errBucle.Source & Chr(13) & Chr(13)
            Next
        Case 5:
            Msg = err.Description
            Msg = Msg & ". Debe revisar el procedimiento al que se hace referencia..."
        Case 20504:
             Msg = Msg & "El Reporte No Existe."
        Case 20510:
             Msg = Msg & "El Nombre de la Fórmula No Existe o es Inválido."
        Case 20513:
             Msg = Msg & "La Impresora No Existe."
        Case 20514:
             Msg = Msg & "El Nombre del Archivo de Impresión ya Existe."
        Case 20515:
             Msg = Msg & "Error en la Fórmula."
        Case 20526:
             Msg = Msg & "No hay Impresora Seleccionada por Defecto en Windows."
        Case 20527:
             Msg = Msg & "Error en la Conexión o en Procedimitnto con SQL Server."
        Case 20529:
             Msg = Msg & "El Disco Lleno."
        Case 20532, 20534:
             Msg = Msg & "La Base de Datos esta Corrupta."
        Case 20536:
             Msg = Msg & "Los Parámetros son Incorrectos."
        Case 20544:
             Msg = Msg & "El Reporte esta siendo Usado por otro Usuario."
        Case 20553:
             Msg = Msg & "El Parámetro pasado al Reporte es Invalido."
        Case Else
             Msg = Msg & err.Description
    End Select
    If Trim(NombreFormulario) = "" Then
        MsgBox (Msg), vbCritical + vbOKOnly, Trim(App.EXEName)
    Else
        MsgBox (Msg), vbCritical + vbOKOnly, Trim(NombreFormulario)
  
    End If
End Function
Public Sub Inicio()
    On Error GoTo Inicio
    Dim strErr                  As String
    Dim Msg                     As String
    Dim strRespuesta            As String
    Dim f                 As Date
    Dim db As DataBase

    'Cadena ODBC para la Conexión al Servidor
    gstrODBC_SCN = "ODBC;"
    gstrODBC_SCN = gstrODBC_SCN & "DSN=db_certi;"
    gstrODBC_SCN = gstrODBC_SCN & "SERVER=SERV_MMD;"
    gstrODBC_SCN = gstrODBC_SCN & "DATABASE=BTRADER;"
    gstrODBC_SCN = gstrODBC_SCN & "UID=bacuser;"
    gstrODBC_SCN = gstrODBC_SCN & "PWD= bacuser;"
     'Crea el WorkSpace para realizar conexión
'    With db
'       .DefaultType = dbUseODBC
'        .DefaultUser = "bacuser"
'        .DefaultPassword = "bacuser"
'        .LoginTimeout = 10
'    End With
'    Set GWorEspacioDeTrabajo = db.Workspaces(0)
'    With GWorEspacioDeTrabajo
'       .DefaultCursorDriver = dbUseClientBatchCursor
'        Set db = .OpenConnection("", dbDriverNoPrompt, False, gstrODBC_SCN)
'        Set BaseDeDatos = .OpenConnection("", dbDriverNoPrompt, False, gstrODBC_SCN)
'    End With
  
    
    Exit Sub
    
Inicio:
    Select Case err
        Case Is > 0
            strErr = gstrODBC_SCN

           MsgBox ("Conexión No Establecida " & Chr$(13) & Chr$(13) & strErr)
            End
    End Select
    
End Sub
Public Function gfunDVerificador(ByVal Numero As String) As String
    On Error GoTo gfunDVerificador
    Const Max = 8
    'Vectores Donde son Almacenados los Digitos Del Rut.
        Dim rut(1 To Max)       As String
        Dim MultRut(1 To Max)   As String
    'Variable Para el FOR(Recorrido).
    Dim Rec                 As Integer
    'Variable Para el Almacemamiento.
    Dim Suma                As Integer
    Dim Resto               As Integer
    Dim Dv                  As Integer
    'Variable Para determinar la cantidad de espacios a ingresar.
    Dim ESPACIOS            As Integer
    Dim Aux                 As String
    Dim Cont                As Integer
    Dim Msg                 As String
    Dim Simbol              As Integer
    Dim Verificacion        As Double
    
    gfunDVerificador = ""
    Verificacion = CDbl(Numero)
    If Verificacion = 0 Then Exit Function
    
    Cont = 0
    For Rec = 1 To Max
        If Mid(Numero, Rec, 1) <> "-" Then
            Aux = Aux & Mid(Numero, Rec, 1)
        Else
            Exit For
        End If
    Next
    
    If Len(Aux) <= 7 Then
        ESPACIOS = Max - Len(Aux)
        Aux = Space(ESPACIOS) & Aux
    ElseIf Len(Aux) >= 8 Then
        Aux = Left(Aux, 8)
    End If
    
    'Traspaso del rut a un Vector
        For Rec = Max To 1 Step -1
            rut(Rec) = Mid(Aux, Rec, 1)
            If rut(Rec) = " " Then
                rut(Rec) = 0
            End If
        Next
    
    'Multiplicacion De los elementos del vector
        For Rec = 1 To 2
            MultRut(Rec) = rut(Rec) * (4 - Rec)
        Next
        For Rec = 3 To Max
            MultRut(Rec) = rut(Rec) * (10 - Rec)
        Next
        
    'Suma de todos los elementos multiplicados
        For Rec = 1 To Max
            Suma = Suma + MultRut(Rec)
        Next
        
    'Proseso de Verificacion
        Resto = Suma Mod 11
        Dv = 11 - Resto
        If Dv = 10 Then
            'Select Case Right(Numero, 1)
                'Case "K": gfunDVerificador = "K"
                'Case "k": gfunDVerificador = "k"
            'End Select
            gfunDVerificador = "K"
        ElseIf Dv = 11 Then
            gfunDVerificador = "0"
        Else
            gfunDVerificador = Dv
        End If
        Exit Function
        
gfunDVerificador:
        Exit Function
        'CapturaError (Err)
End Function
Public Function gfunRutConGuion(ByVal rut As String) As String
    'El Rut 0124862175 lo entrega como 012486217-5
    gfunRutConGuion = Left(rut, 9) & "-" & Right(rut, 1)
End Function
Public Function gfunRutSinCerosLeft(rut$) As String
    'El Rut 0124862175 lo entrega como 124862175, esto para ser revisado por la
    'rutina del digito verificador
    
    On Error Resume Next
    Dim Rec         As Integer
    Dim desde       As Integer
    Dim Pal         As String
    
    gfunRutSinCerosLeft = ""
    Pal = Left(rut$, 9)
    
    For Rec = 1 To Len(Pal)
        If Mid(Pal, Rec, 1) <> "0" Then
            desde = Rec
            Exit For
        End If
    Next
    gfunRutSinCerosLeft = Mid(Pal, desde)
End Function


Public Function BacNumero(ByRef vNumero As Variant)

    'valido si el valor no es numerico...
    If Not IsNumeric(vNumero) Then

        'devuelvo el valor 0...
        vNumero = 0
    End If

End Function
'+++COLTES, jcamposd 20171206
Function DIAS365(Fecha_inicial As Date, Fecha_final As Date)
Dim año_ini As Variant, año_format As Variant, año_fin As Variant
Dim d1, d2, d3

' Comprobar si el año inicial es bisiesto y contar días del primer año
    año_ini = Year(Fecha_inicial)
    año_ini = "29/02/" & año_ini
    If IsDate(año_ini) = False Then
        d1 = 0
    Else
        If Fecha_inicial <= FormatDateTime(año_ini, vbShortDate) And FormatDateTime(año_ini, vbShortDate) <= Fecha_final Then
            d1 = 1
        Else
            d1 = 0
        End If
    End If
'Verifica si la fecha final pasa el año de la fecha inicial
    If Year(Fecha_inicial) <> Year(Fecha_final) Then
        año_ini = Year(Fecha_inicial)
        año_ini = "31/12/" & año_ini
        año_format = Day(Fecha_inicial) & "/" & Month(Fecha_inicial) & "/" & Year(Fecha_inicial)
        d1 = DateValue(año_ini) - DateValue(año_format) - d1
     Else
        d1 = Fecha_final - Fecha_inicial - d1
     End If

' comprobar si hay años intermedios y contar días
    If Year(Fecha_final) - Year(Fecha_inicial) - 1 > 0 Then
        d2 = (Year(Fecha_final) - Year(Fecha_inicial) - 1) * 365
    Else
        d2 = 0
    End If

' Comprobar si el año final es bisiesto y contar días del ultimo año
    If Year(Fecha_inicial) <> Year(Fecha_final) Then
        año_fin = Year(Fecha_final)
        año_fin = "29/02/" & año_fin
        If IsDate(año_fin) = False Then
            d3 = 0
        Else
            If Fecha_final <= FormatDateTime(año_fin, vbShortDate) Then
                d3 = 0
            Else
                d3 = 1
            End If
        End If
        año_fin = Year(Fecha_final) - 1
        año_fin = "31/12/" & año_fin
        año_format = Day(Fecha_final) & "/" & Month(Fecha_final) & "/" & Year(Fecha_final)
        d3 = DateValue(año_format) - DateValue(año_fin) - d3
    Else
        d3 = 0
    End If

    DIAS365 = d1 + d2 + d3

End Function
'---COLTES, jcamposd 20171206
