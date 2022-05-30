Attribute VB_Name = "BacMenu"
Option Explicit

Private Sub BAC_CheckButton(oControl As Object)

   Dim iComando      As Integer
   Dim iOpcionMenu   As Integer

   On Error GoTo LabelError:

   For iComando = 0 To 7
      BacControlWindows 10

      iOpcionMenu = Val(BacForward.cmd(iComando).Tag)

      BacForward.cmd(iComando).Tag = LoadResString(iComando)

      BacForward.cmd(iComando).Enabled = False

      If iOpcionMenu >= 1000 Then
         If oControl(iOpcionMenu).Enabled Then
            BacForward.cmd(iComando).Enabled = True

         End If

      End If

Proximo:

      Call MNU_LoadButton(BacForward.cmd(iComando))

   Next iComando

   On Error GoTo 0

   Exit Sub

LabelError:
   GoTo Proximo

End Sub

Private Sub BAC_CheckMenu(oControl As Object, iOpcion As Long)

   Dim iButton       As Integer
   Dim iOpcionMenu   As Long

   On Error GoTo LabelError:

   oControl(iOpcion).Enabled = True
   
   On Error GoTo 0

   Exit Sub

LabelError:
   iButton = 0

End Sub

Private Sub BAC_CheckMenuEnabled(oControl As Object, nInicio As Integer)

   Dim nLin          As Integer

   For nLin = nInicio To nInicio + (oControl.Count - 1)
      If oControl(nLin).Caption <> "-" Then
         oControl(nLin).Enabled = False

      End If
   
   Next nLin

End Sub

Public Sub MNU_EventClick(wOpcion%)
      
   BacToolTip.Hide
   Screen.MousePointer = vbHourglass

   Call gsc_Parametros.DatosGenerales

   BacControlWindows 5
     
   Select Case wOpcion%
                   
   ' Operaciones.-
   Case 1001:           'Inicio del Día

   Case 1002:           'Vencimientos
     ' BacOperVencidas.Show vbNormal%
     'Impresion_Entidades ("VencimientosDia")

   Case 2001            'Seguro de Cambio
      BacIrfNueVentana "SCAMA"
   
   Case 2002            'Arbitrajes
      BacIrfNueVentana "ARBRA"
      
   Case 2003            'Seguro de Inflación
      BacIrfNueVentana "SEINA"
      
   Case 2004            'Sinteticos
      BacIrfNueVentana "SINTA"
      
   Case 2005            '1446
      BacIrfNueVentana "1446A"
      
   Case 2007:           'Cierre de Mesa
      Call gsc_Parametros.CierredeMesa
      
   Case 2008:           'Swaps
      BacOpeSwap.Show vbNormal%

   Case 3001:           'Posición por Vencimiento
      BacConPosVen.Show vbNormal%

   Case 3002:           'Posición Por Cliente
      BacConPosCli.Show vbNormal%

   Case 3003:           'Vencimientos Proyectados
      BacConVenPro.Show vbNormal%

   Case 3005:           'Vencimientos del día
      Impresion_Entidades ("VencimientosDia")
      'BacOperVencidas.Show vbNormal%

   Case 4101:           'Contrato con Empresas

   Case 4102:           'Condiciones Generales

   Case 4103:           'Contrato Empresas UF/$

   Case 4104:           'FAX de Confirmación
      BacFaxConfirm.Show vbNormal%

   Case 4105:           'Contrato Interbancario
      BacFiltraContratos.Caption = "Contratos Interbancarios"
      BacFiltraContratos.Show vbNormal%

   Case 4107:           'Capítulo VII Anexo 1
      BacFiltraFechas.Tag = "CapVIIAI"
      BacFiltraFechas.Show vbNormal%
   
   Case 4201:           'Movimiento Diario Seguro de Cambio
      Impresion_Entidades ("MovDiaSegCambio")
     
   Case 4202:           'Movimiento Diario Arbitrajes a Futuro
      Impresion_Entidades ("MovDiaArbitrajes")
     
   Case 4203:           'Movimiento Diario Futuro UF/$
      Impresion_Entidades ("MovDiaUf/Clp")
    
   Case 4204:           'Movimiento Historico Seguro de Cambio

   Case 4206:           'Movimiento Historico Arbitraje a Futuro

   Case 4207:           'Movimiento Historico Futuro UF/$

   Case 4301:           'Cartera Operaciones a Futuro

   Case 4302:           'Cartera Operaciones Sintéticas

   Case 4303:           'Cartera de Operaciones a Futuro Calzadas por Producto ( Calce )
       Call BacLeeOperacionCalcePro
     
   Case 4304:           'Cartera de Operaciones a Futuro Abiertas por Producto ( Descalce )
      Call BacLeeOperacionDescpro
     
   Case 4305:           'Cartera de Operaciones UF/$ a Futuro Calzadas ( Calce )
      Call BacLeeOperacionCalce
   
   Case 4306:           'Cartera de Operaciones UF/$ a Futuro Abiertas ( Descalce )
      Call BacLeeOperacionDescalce

   Case 4307:           'Cartera Derivados
      Call BacCarteraOperDerivados

   Case 4309:           'Cartera Compras Seguro de Cambios
      Impresion_Entidades ("SegurosCambioCom")
   
   Case 4310:           'Cartera Ventas Seguro de Cambios
      Impresion_Entidades ("SegurosCambioVen")

   Case 4311:           'Cartera Compra Futuro UF/$
      Impresion_Entidades ("SegurosInflacionCom")

   Case 4312:           'Cartera Venta Futuro UF/$
      Impresion_Entidades ("SegurosInflacionVen")

   Case 4313:           'Cartera Arbitraje a Futuro
      Impresion_Entidades ("CarteraArbitrajes")
      
   Case 4315:           'Cartera Operaciones 1446
      Impresion_Entidades ("Cartera1446")
      
   Case 4316:           'Cartera Operaciones de Posición
      Impresion_Entidades ("CarteraSinteticos")
                           

   Case 4401:           'Operaciones Seguros de Cambio MTM
       Call BacOpeMTM
   
   Case 4402:            'Operaciones Anuladas
       BacFiltraFechas.Tag = "OperAnul"
       BacFiltraFechas.Show vbNormal%

   Case 5001:           'Paridades Bid-Ask
'      BacBidAsk.Show vbNormal%
   
   Case 5002:           'Devengamiento y Valorización
   
      If gsc_Parametros.ACsw_ciemefwd = "1" Then
         Bac_TE.Show
         
      Else
         MsgBox "No se ha realizado el cierre de mesa", vbExclamation, "Devengamiento y Valorización"

      End If
      
   Case 5003:           'Contabilidad
      
   Case 6001:           'Apoderados
       BacMntApoderados.Show vbNormal%
     ' BacMntCl.Show vbNormal%

   Case 6002:           'Operadores
      BacMntOp.Show vbNormal%

   Case 6003:           'Montos Maximos Por Operadores
      BacMontoMaxOper.Show vbNormal%

   Case 6004:           ' Moneda por producto
      BacMntMP.Show vbNormal%

   Case 6005:            'Cartera
      BacMntCr.Show vbNormal%

   
   Case 6007:           'Paridades
        BacMntVe.Show vbNormal%
        
   Case 6008:          ' Generador de UF
      BacMntIp.Show vbNormal%

   Case 6009:           'Periodos
      BacMntPe.Show vbNormal%

   Case 6011:           'Mantenedor de Tasas
      BacMntTm.Show vbNormal%

   'Case 6012:           'Mantenedor plan de cuentas
      'BacMntPC.Show vbNormal%

   Case 7001:           'Fin de Día
   
      If gsc_Parametros.ACsw_ciemefwd = "1" Then
         BacFindia.Show vbModal%

      Else
         MsgBox "No se ha realizado el cierre de mesa", vbExclamation, "Fin de Día"

      End If
   
   Case 0
      BacForward.Arrange vbTileVertical
      
   Case 0
      BacForward.Arrange vbTileHorizontal
      
   Case 991
      BacForward.Arrange vbCascade
      
   Case 992
      BacForward.Arrange vbArrangeIcons
      
   Case 994
      BacAcercaDe.Show vbModal%

   End Select
   
   Screen.MousePointer = vbDefault
     
End Sub

Private Sub MNU_LoadHook()

   '
   ' Hook de los mensajes.-
   '------------------------

   'BacForward.MsgHook1.HwndHook = BacForward.hWnd
   'BacForward.MsgHook1.Message(WM_COMMAND) = True
   'BacForward.MsgHook1.Message(WM_MENUSELECT) = True
  
End Sub

Public Sub MNU_MicroHelp(wParam%)
      
   On Error GoTo hnd_Error
   
   'BacForward.PnlEstado = LoadResString(wParam%)
   Exit Sub
       
hnd_Error:

   'BacForward.PnlEstado = " BacForward  -  Versión Beta 7.01"
       
End Sub
Public Sub MNU_SetButton(nIndex%, bFlag%)
      
   If BacForward.cmd(nIndex%).Enabled <> bFlag% Then
      BacForward.cmd(nIndex%).Enabled = bFlag%
   
   End If
   
   MNU_LoadButton BacForward.cmd(nIndex%)
      
End Sub

Public Function BAC_MenuUser(cUser$) As Boolean

   Dim Sql        As String
   Dim iOpcion    As Long
   Dim iGrupo     As Long
   Dim Datos()

   BAC_MenuUser = False

   Call BAC_CheckMenuEnabled(BacForward.mnuInicio, 1001)
   Call BAC_CheckMenuEnabled(BacForward.mnuOperaciones, 2001)
'   Call BAC_CheckMenuEnabled(BacForward.mnuOpeAnticipo, 2701)
   Call BAC_CheckMenuEnabled(BacForward.mnuConsulta, 3001)
   Call BAC_CheckMenuEnabled(BacForward.mnuInforme, 4001)
   Call BAC_CheckMenuEnabled(BacForward.mnuInformeBCCH, 4101)
   Call BAC_CheckMenuEnabled(BacForward.mnuInformeMovimiento, 4201)
   Call BAC_CheckMenuEnabled(BacForward.mnuInformeCartera, 4301)
   Call BAC_CheckMenuEnabled(BacForward.mnuInformeOtros, 4401)
   Call BAC_CheckMenuEnabled(BacForward.mnuProceso, 5001)
   Call BAC_CheckMenuEnabled(BacForward.mnuAdministracion, 6001)
   Call BAC_CheckMenuEnabled(BacForward.mnuCierre, 7001)

   Sql = "EXECUTE  sp_mnulogin '" & cUser$ & "'"

   If SQL_Execute(Sql) = 0 Then

      Do While SQL_Fetch(Datos()) = 0
                     
         iOpcion = Val(Datos(4))
         iGrupo = Val(Datos(5))

         Select Case iGrupo
         Case 1         'Menú Principal
            Call BAC_CheckMenu(BacForward.mnuForward, iOpcion)

         Case 2         'SubMenú Inicio de día
            Call BAC_CheckMenu(BacForward.mnuInicio, iOpcion)

         Case 3         'SubMenú Operaciones
            Call BAC_CheckMenu(BacForward.mnuOperaciones, iOpcion)

         Case 4         'SubMenú Anticipos
'            Call BAC_CheckMenu(BacForward.mnuOpeAnticipo, iOpcion)

         Case 5         'SubMenú Consultas
            Call BAC_CheckMenu(BacForward.mnuConsulta, iOpcion)

         Case 6         'SubMenú Informe
            Call BAC_CheckMenu(BacForward.mnuInforme, iOpcion)

         Case 7         'SubMenú BCCH
            Call BAC_CheckMenu(BacForward.mnuInformeBCCH, iOpcion)

         Case 8         'SubMenú Movimiento
            Call BAC_CheckMenu(BacForward.mnuInformeMovimiento, iOpcion)

         Case 9         'SubMenú Cartera
            Call BAC_CheckMenu(BacForward.mnuInformeCartera, iOpcion)

         Case 10        'SubMenú Otros Informes
            Call BAC_CheckMenu(BacForward.mnuInformeOtros, iOpcion)

         Case 11        'SubMenú Proceso
            Call BAC_CheckMenu(BacForward.mnuProceso, iOpcion)

         Case 12        'SubMenú Administracion
            Call BAC_CheckMenu(BacForward.mnuAdministracion, iOpcion)

         Case 13        'SubMenu Cierre
            Call BAC_CheckMenu(BacForward.mnuCierre, iOpcion)

         End Select

      Loop

      Call BAC_CheckButton(BacForward.mnuOperaciones)

'      Call MNU_LoadMenu
'      Call MNU_LoadTool
'      Call MNU_LoadHook

      BacForward.PnlInfo.Visible = True
      BacForward.PnlTools.Visible = True


      BAC_MenuUser = True
            
   End If
   
   Screen.MousePointer = 11
   
End Function

Private Sub MNU_LoadTool()

   Dim hMenu%, iMenu%, sMenu$, iCont%, Button As Control

   hMenu% = GetMenu(BacForward.hWnd%)
   iMenu% = 0
   sMenu$ = ""

   For iCont% = 0 To 11
      BacControlWindows 10

      Set Button = BacForward.cmd(iCont%)

      sMenu$ = Button.Tag

      Button.Tag = LoadResString(iCont%)
      Button.Enabled = False
      
      Do While sMenu$ <> ""
         iMenu% = Val(BacExtraer(sMenu$))

         If GetMenuState(hMenu%, iMenu%, MF_BYCOMMAND) <> -1 Then
            Button.Enabled = True
            Exit Do
         
         End If
         
      Loop
      
      Call MNU_LoadButton(Button)
   
   Next iCont%

   BacForward.PnlInfo.Visible = True
   BacForward.PnlTools.Visible = True
   
End Sub
Private Sub MNU_LoadButton(cmd As Control)
        
   Dim cBitmap$
   cBitmap$ = "cmd" & cmd.Index & "_" & Abs(cmd.Enabled)
   cmd.Picture = LoadResPicture(cBitmap$, vbResBitmap)
   cmd.Refresh
    
End Sub


Private Sub MNU_LoadMenu()
       
   Dim hWnd%, hMenu%, hChild%, nOk%
   
   hWnd% = BacForward.hWnd%
   Call MNU_UnloadMenu(hWnd%)
   
   
   hMenu% = CreateMenu()
   Call MNU_BuildMenu(hMenu%, "0")
   
   'Tools menu
   hChild% = CreatePopupMenu()
   nOk% = AppendMenu(hMenu%, MF_ENABLED Or MF_POPUP, hChild%, Chr$(8) + "&?")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_STRING, 10001, "Mosaico &Horizontal")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_STRING, 10002, "Mosaico &Vertical")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_STRING, 10003, "&Cascada")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_STRING, 10004, "&Organizar Iconos")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_SEPARATOR, 0, "")
   nOk% = AppendMenu(hChild%, MF_ENABLED Or MF_STRING, 10005, "Acerca de...")
   nOk% = SetMenu(hWnd%, hMenu%)
   
End Sub

Private Sub MNU_BuildMenu(hParent%, pLevel$)

   Static cLevel$, cText$, cType$, iOption%
      
   Dim Datos(), cNext$, hChild%, nOk%
       
   Do While True
         
      If SQL_Fetch(Datos()) = 0 Then
         cLevel$ = Datos(1)
         cText$ = Datos(2)
         cType$ = Datos(3)
         iOption% = Val(Datos(4))
      
      Else
         cLevel$ = "*"
      
      End If
         

NextLevel:

      '------
      If Mid$(cLevel$, 1, Len(pLevel$)) <> pLevel$ Then
         Exit Sub
      
      End If
      '------
      
      '------
      If cType$ = "M" Then
         cNext$ = Mid$(cLevel$, 1, Len(pLevel$) + 2)
         hChild% = CreatePopupMenu()
         nOk% = AppendMenu(hParent%, MF_ENABLED Or MF_POPUP, hChild%, cText$)
         Call MNU_BuildMenu(hChild%, cNext$)
         GoTo NextLevel
      
      End If
      '------
      
      '------
      If cType$ = "O" Then
         nOk% = AppendMenu(hParent%, MF_ENABLED Or MF_STRING, iOption%, cText$)
      
      End If
      '------
      
      '------
      If cType$ = "S" Then
         nOk% = AppendMenu(hParent%, MF_ENABLED Or MF_SEPARATOR, 0, "")
      
      End If
      '------
    
    Loop

End Sub

Public Sub MNU_UnloadMenu(hWnd%)

   Dim hMenu%, nOk%

   hMenu% = GetMenu(hWnd%)
   nOk% = DestroyMenu(hMenu%)
   DrawMenuBar hWnd%

End Sub


