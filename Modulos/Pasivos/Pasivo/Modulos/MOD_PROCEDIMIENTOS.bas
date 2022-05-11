Attribute VB_Name = "MOD_PROCEDIMIENTOS"
Sub PROC_CENTRAR_FORMULARIO(fFormulario As Form, fFormPrincipal As Form)

   fFormulario.left = (fFormPrincipal.Width / 2) - (fFormulario.Width / 2)
   fFormulario.top = (fFormPrincipal.Height / 2) - (fFormulario.Height / 2)


End Sub

Public Sub PROC_LOG_AUDITORIA(cCodigo_Evento As String, cCodigo_Menu As String, cDetalle_Trans As String, cValor_Antiguo As String, cValor_Nuevo As String)
    
    Call PROC_GRABA_LOG_AUDITORIA("1" _
                                 , GLB_Fecha_Proceso _
                                 , GLB_Nombre_Computador _
                                 , GLB_Usuario _
                                 , "PSV" _
                                 , cCodigo_Menu _
                                 , cCodigo_Evento _
                                 , cDetalle_Trans _
                                 , " " _
                                 , cValor_Antiguo _
                                 , cValor_Nuevo)
                                 
End Sub

Sub PROC_GRABA_LOG_AUDITORIA( _
                              cEntidad As String _
                            , dFechaproc As Date _
                            , cTerminal As String _
                            , cUsuario As String _
                            , cId_Sistema As String _
                            , cCodigo_Menu As String _
                            , cEvento As String _
                            , cDetalle_Transac As String _
                            , cTablaInvolucrada As String _
                            , cValorAntiguo As String _
                            , cValorNuevo As String _
                        )

      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, cEntidad
      PROC_AGREGA_PARAMETRO GLB_Envia, dFechaproc
      PROC_AGREGA_PARAMETRO GLB_Envia, cTerminal
      PROC_AGREGA_PARAMETRO GLB_Envia, cUsuario
      PROC_AGREGA_PARAMETRO GLB_Envia, cId_Sistema
      PROC_AGREGA_PARAMETRO GLB_Envia, cCodigo_Menu
      PROC_AGREGA_PARAMETRO GLB_Envia, cEvento
      PROC_AGREGA_PARAMETRO GLB_Envia, cDetalle_Transac
      PROC_AGREGA_PARAMETRO GLB_Envia, cTablaInvolucrada
      PROC_AGREGA_PARAMETRO GLB_Envia, cValorAntiguo
      PROC_AGREGA_PARAMETRO GLB_Envia, cValorNuevo

      If FUNC_EXECUTA_COMANDO_SQL("SP_ACT_LOG_AUDITORIA", GLB_Envia) Then
      Else
        If Temporal = 0 Then
        End If
      End If

End Sub

Public Sub PROC_AGREGA_PARAMETRO(ByRef vArreglo As Variant, vParametro As Variant)
   
   On Error GoTo Errorcuenta:
   
   Cuenta = UBound(vArreglo) + 1
   ReDim Preserve vArreglo(Cuenta)
   vArreglo(Cuenta) = vParametro
   
   Exit Sub

Errorcuenta:
   
   Cuenta = 1
   Resume Next

End Sub

Sub PROC_TO_CASE(ByRef KeyAscii As Integer)
    
    If KeyAscii = 39 Or KeyAscii = 34 Then ' Revisa comillas
       KeyAscii = 0
    End If

    If KeyAscii >= 97 Or KeyAscii <= 122 Then
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End If
    
End Sub

Sub PROC_CARGA_AYUDA(oForm As Form)

'On Error GoTo ERRCARGAAYUDA

'   Dim vDatos_Retorno()

'   GLB_Envia = Array()
'   PROC_AGREGA_PARAMETRO GLB_Envia, "PSV"
'   PROC_AGREGA_PARAMETRO GLB_Envia, oForm.Name
'
'   If FUNC_EXECUTA_COMANDO_SQL("SP_CON_AYUDA_SISTEMA", GLB_Envia) Then 'GoTo ERRCARGAAYUDA
'      If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then ' GoTo ERRCARGAAYUDA
'         If Dir(vDatos_Retorno(1)) <> "" Then  'GoTo ERRCARGAAYUDA
'             App.HelpFile = vDatos_Retorno(1)
'             oForm.HelpContextID = vDatos_Retorno(2)
'         End If
'      End If
'   End If
'   Exit Sub

'ERRCARGAAYUDA:
   
'   App.HelpFile = ""
'   oForm.HelpContextID = 0

End Sub

Public Sub PROC_DETECTAR_RESOLUCION(MDIFormx As Object, Formx As Object)
   
   Dim nAncho As Integer
   Dim nAlto As Integer
   
   nAncho = GetDeviceCaps(Formx.hdc, 8)
   nAlto = GetDeviceCaps(Formx.hdc, 10)
   
   If nAncho <> 800 And nAlto <> 600 Then
      
      'MDIFormx.Picture = Formx.Picture
   
   End If
   
    Unload Formx
    
End Sub

Public Sub PROC_TITULO_MODULO(cId_Sistema As String, cVersion As String)
Dim vDatos_Retorno()
Dim cSeparador As String
 
   
   cVersion = "_" & cVersion
   
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, cId_Sistema
   PROC_AGREGA_PARAMETRO GLB_Envia, cVersion
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_TITULO_SISTEMA", GLB_Envia) Then
      MsgBox "Problema ejecutando Consulta", vbExclamation
   
   End If
   
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
      
      App.Title = vDatos_Retorno(1)
   
   End If
 
End Sub

Sub PROC_FORMATO_NUMERO_INF_BASICA()

Dim nMoneda As Double
Dim vDatos_Retorno()

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_INFORMACION_BASICA") Then  '®
      MsgBox "Problemas en la Carga de Información Basica", 64
      Exit Sub
   End If
   
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
      nMoneda = vDatos_Retorno(3)
   End If
   
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_MONEDA", GLB_Envia) Then
   
      MsgBox "Problemas al Leer Monedas", 64
      Exit Sub
      
   End If
   
   GLB_Formato_Numero = FUNC_DECIMALES(0)
   
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
   
      GLB_Formato_Numero = FUNC_DECIMALES((vDatos_Retorno(11)))
      
   End If

End Sub

Function PROC_ENCRIPTACION(cClave As String, bEncriptar As Boolean) As String

   Dim nContador  As Single
   Dim cPsw       As String
   Dim cLetras    As String
   Dim cCodigos   As String

   cLetras = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ1234567890abcdefghijklmnñopqrstuvwxyz"
   cCodigos = "RaMbKCgTrZHYFIÑPAuSiQVONmLfJWzGXEDqBUx_kpjcys{dn}veñ]htwl[\`@?><"
   cPsw = ""
   PROC_ENCRIPTACION = ""

   For nContador = 1 To Len(cClave)
 
      If bEncriptar Then
         cPsw = cPsw + Chr((Asc(Mid(cCodigos, InStr(1, cLetras, Mid(cClave, nContador, 1)), 1)) - nContador))
      Else
         cPsw = cPsw + Mid(cLetras, InStr(1, cCodigos, Chr(Asc(Mid(cClave, nContador, 1)) + nContador)), 1)
      End If
 
   Next

   PROC_ENCRIPTACION = cPsw

End Function

Public Sub PROC_ESTABLECE_UBICACION(Cantidad_Bases As Integer, ObjetoCristal As Object)

On Error GoTo Error_OnError

Dim Posicion_1 As Integer
Dim nContador
Dim Nueva_DataFile As String

   If Cantidad_Bases = 0 Then Exit Sub

   With ObjetoCristal
      
      For nContador = 0 To Cantidad_Bases - 1
            
            Posicion_1 = InStr(.DataFiles(nContador), ".")
            Nueva_DataFile = GLB_SQL_Database & Mid(.DataFiles(nContador), Posicion_1, ((Len(.DataFiles(nContador)) - Posicion_1) + 1))
            .DataFiles(nContador) = Nueva_DataFile
      
      Next
   
   End With
    
   Exit Sub
    
Error_OnError:

    MsgBox "Error número: " & Err.Number & ", Descripción: " & Err.Description, vbCritical
    Screen.MousePointer = 0
    
End Sub

Sub PROC_CENTRAR_PANTALLA(hForm As Form)

    hForm.top = (Screen.Height - hForm.Height) / 2
    hForm.left = (Screen.Width - hForm.Width) / 2

End Sub

Sub PROC_CARACTER_NUMERICO(ByRef KeyAscii As Integer)

    'si <> Enter y BackSpace
    If KeyAscii <> 13 And KeyAscii <> 8 Then
        'Si no es numerico
        If Not IsNumeric(Chr$(KeyAscii)) Then
            KeyAscii = 0
        End If
    End If

End Sub

Sub PROC_MARCA_OPERACIONES(Grilla As MSFlexGrid, nFila As Long, cCaja As String, cLetra As String)
   
   Dim nColumna As Integer
   
   With Grilla
      
      For nColumna = 0 To .Cols - 1
         
         .Row = nFila
         .Col = nColumna
         .CellBackColor = Val(cCaja)
         .CellForeColor = Val(cLetra)
      
      Next
   
   End With

End Sub


Public Sub PROC_ESTABLECE_DEFECTO(ByRef objOriginal As Object, Defecto As Variant)
Dim I As Integer
Dim nComboLenght  As Integer

   nComboLenght = 25
   

   If TypeOf objOriginal Is ComboBox Then
   
      For I = 0 To objOriginal.ListCount - 1
      
         If IsNumeric(Defecto) Then
      
            If objOriginal.ItemData(I) = Defecto Then
               objOriginal.ListIndex = I
               Exit Sub
         
            End If
      
         Else
         
            If nComboLenght < Len(objOriginal.List(I)) Then
         
               If Trim(right(objOriginal.List(I), nComboLenght)) = Defecto Then
                  objOriginal.ListIndex = I
                  Exit Sub
            
               End If
         
            Else
               
               If left(objOriginal.List(I), 1) = Defecto Then
                  objOriginal.ListIndex = I
                  Exit Sub
            
               End If
         
            End If
         
         End If
      
      Next

   ElseIf TypeOf objOriginal Is SSOption Or TypeOf objOriginal Is OptionButton Then
   
      objOriginal.Value = (Defecto = left(objOriginal.Caption, 1))

   End If

End Sub

Sub PROC_LIMPIAR_CRISTAL()

Dim nContador As Integer

   For nContador = 0 To 20
   
        FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(nContador) = ""
        FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(nContador) = ""
        
   Next nContador
   
   FRM_MDI_PASIVO.Pasivo_Rpt.WindowParentHandle = FRM_MDI_PASIVO.hwnd
   FRM_MDI_PASIVO.Pasivo_Rpt.WindowState = crptMaximized
   
End Sub

Public Sub PROC_LLENA_MESES(Cmb_Combo As Object)
   
   Cmb_Combo.Clear
   
   Cmb_Combo.AddItem "ENERO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 1
   Cmb_Combo.AddItem "FEBRERO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 2
   Cmb_Combo.AddItem "MARZO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 3
   Cmb_Combo.AddItem "ABRIL"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 4
   Cmb_Combo.AddItem "MAYO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 5
   Cmb_Combo.AddItem "JUNIO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 6
   Cmb_Combo.AddItem "JULIO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 7
   Cmb_Combo.AddItem "AGOSTO"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 8
   Cmb_Combo.AddItem "SEPTIEMBRE"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 9
   Cmb_Combo.AddItem "OCTUBRE"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 10
   Cmb_Combo.AddItem "NOVIEMBRE"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 11
   Cmb_Combo.AddItem "DICIEMBRE"
   Cmb_Combo.ItemData(Cmb_Combo.NewIndex) = 12
   
   Cmb_Combo.ListIndex = -1
   
End Sub

