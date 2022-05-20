VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsMsg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Clientes
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_opConeccion    As Long
Public MSG_opBorrar       As Long
Public MSG_opGrabar       As Long
Public MSG_opValCodigo    As Long
Public MSG_opValNombre    As Long
Public MSG_opGrabarOK     As Long
Public MSG_opBorrarOK     As Long
Public MSG_opPregunta     As Long

Public MSG_crConeccion    As Long
Public MSG_crBorrar       As Long
Public MSG_crGrabar       As Long
Public MSG_crValCodigo    As Long
Public MSG_crValNombre    As Long
Public MSG_crGrabarOK     As Long
Public MSG_crBorrarOK     As Long
Public MSG_crPregunta     As Long

Public MSG_clBorrarOK     As Long
Public MSG_clPregunta     As Long

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Emisores
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_EMConeccion     As Integer
Public MSG_EMGrabar        As Integer
Public MSG_EMBorrar        As Integer
Public MSG_EMValRut        As Integer
Public MSG_EMValNombre     As Integer
Public MSG_EMValGenerico   As Integer
Public MSG_EMValDirec      As Integer
Public MSG_EMValComuna     As Integer
Public MSG_EMVALTipoEmisor As Integer
Public MSG_EMVALCodigoR    As Integer
Public MSG_EMVALGenericoR  As Integer
Public MSG_EMGrabarOK      As Integer
Public MSG_EMBorrarOK      As Integer
Public MSG_EMPregunta      As Integer
'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Tablas de Uso General
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_TGConeccion       As Integer
Public MSG_TGGrabar          As Integer
Public MSG_TGBorrar          As Integer
Public MSG_TGBegin           As Integer
Public MSG_TGBorrarRollBack  As Integer
Public MSG_TGGrabarRollback  As Integer
Public MSG_TGCommit          As Integer
Public MSG_TGValCodigos      As Integer
Public MSG_TGValElemento     As Integer
Public MSG_TGGrabarOK        As Integer


'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Monedas
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_MNConeccion       As Integer
Public MSG_MNGrabar          As Integer
Public MSG_MNBorrar          As Integer
Public MSG_MNValCodMon       As Integer
Public MSG_MNValGlosa        As Integer
Public MSG_MNValNemo         As Integer
Public MSG_MNValSimbolo      As Integer
Public MSG_MNVALNemoR        As Integer
Public MSG_MNVALSimboloR     As Integer
Public MSG_MNVALCodSupR      As Integer
Public MSG_MNGrabarOK        As Integer
Public MSG_MNBorrarOK        As Integer
Public MSG_MNPregunta        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Dueños de Carteras
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_DCConeccion       As Integer
Public MSG_DCGrabar          As Integer
Public MSG_DCBorrar          As Integer
Public MSG_DCValrut          As Integer
Public MSG_DCValDescrip      As Integer
Public MSG_DCValcodigo       As Integer
Public MSG_DCGrabarOK        As Integer
Public MSG_DCBorrarOK        As Integer
Public MSG_DCPregunta        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Valores de Monedas
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_VMConeccion       As Integer
Public MSG_VMGrabar          As Integer
Public MSG_VMGrabarBegin     As Integer
Public MSG_VMGrabarRollback  As Integer
Public MSG_VMGrabarCommit    As Integer
Public MSG_VMValMes          As Integer
Public MSG_VMGrabarOK        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Feriados
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_FEConeccion       As Integer
Public MSG_FEGrabar          As Integer
Public MSG_FEValMes          As Integer
Public MSG_FEValPlaza        As Integer
Public MSG_FEValAno          As Integer
Public MSG_FEValDiasFer      As Integer
Public MSG_FEGrabarOK        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Familias
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_FAConeccion       As Integer
Public MSG_FAGrabar          As Integer
Public MSG_FAEliminar        As Integer
Public MSG_FAVALSerie        As Integer
Public MSG_FAVALDescripcion  As Integer
Public MSG_FAVALCodFamilia   As Integer
Public MSG_FAVALRutina       As Integer
Public MSG_FAVALNominales    As Integer
Public MSG_FAGrabarOK        As Integer
Public MSG_FAEliminarOK      As Integer
Public MSG_FAPregunta        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Series
'**
'*/ ----------------------------------------------------------------------------------------

Public MSG_SEConeccion       As Integer
Public MSG_SEGrabar          As Integer
Public MSG_SEEliminar        As Integer
Public MSG_SEVALFamilia      As Integer
Public MSG_SEVALMascara      As Integer
Public MSG_SEVALRutEmisor    As Integer
Public MSG_SEVALMoneda       As Integer
Public MSG_SEVALBase         As Integer
Public MSG_SEVALCupon        As Integer
Public MSG_SEVALNumAmort     As Integer
Public MSG_SEVALNumAmort1    As Integer
Public MSG_SEVALFecEmi       As Integer
Public MSG_SEVALFecVen       As Integer
Public MSG_SEVALFEmision     As Integer
Public MSG_SEGrabarOK        As Integer
Public MSG_SEEliminarOK      As Integer
Public MSG_SEPregunta        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Desarrollo
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_TDConeccion       As Integer
Public MSG_TDGrabar          As Integer
Public MSG_TDGrabarOK        As Integer

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Premios
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_TPConeccion       As Integer
Public MSG_TPGrabar          As Integer
Public MSG_TPGrabarOK        As Integer


'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Plan de Cuentas
'**
'*/ ----------------------------------------------------------------------------------------
Public MSG_PCConeccion       As Integer
Public MSG_PCGRabar          As Integer
Public MSG_PCEliminar        As Integer
Public MSG_PCValCuenta       As Integer
Public MSG_PCValTipo         As Integer
Public MSG_PCValDescripcion  As Integer
Public MSG_PCValPadre        As Integer
Public MSG_PCEliminarOK      As Integer
Public MSG_PCGrabarOK        As Integer
Public MSG_PCPregunta        As Integer

Public Sub Valores()
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Clientes
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_opConeccion = 100011     ', "No se puede conectar a tabla de clientes.-"
   MSG_opBorrar = 100021        ', "No se puede eliminar este cliente.-"
   MSG_opGrabar = 100031        ', "No se puede grabar este cliente.-"
   MSG_opValCodigo = 100051     ', "El Código del opiente ya existe.-"
   MSG_opValNombre = 100061     ', "No ingres¢ nombre del cliente.-"
   MSG_opGrabarOK = 100111      ', "Registro cliente ha sido grabado.-"
   MSG_opBorrarOK = 100121      ', "Registro cliente ha sido eliminado.-"
   MSG_opPregunta = 100131      ', "Seguro de eliminar cliente.-@PR"
   
   MSG_crConeccion = 100012     ', "No se puede conectar a tabla de cartera.-"
   MSG_crBorrar = 100022        ', "No se puede eliminar esta cartera.-"
   MSG_crGrabar = 100032        ', "No se puede grabar esta cartera.-"
   MSG_crValCodigo = 100052     ', "El Código de la cartera ya existe.-"
   MSG_crValNombre = 100062     ', "No ingresó nombre de la cartera.-"
   MSG_crGrabarOK = 100112      ', "Registro cartera ha sido grabado.-"
   MSG_crBorrarOK = 100122      ', "Registro cartera ha sido eliminado.-"
   MSG_crPregunta = 100132      ', "Seguro de eliminar cartera.-@PR"
   
   MSG_clBorrarOK = 100141      ', "Registro cliente ha sido eliminado.-"
   MSG_clPregunta = 100142      ', "Seguro de eliminar cliente.-@PR"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Emisores
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_EMConeccion = 11001     ', "No se puede conectar a tabla de emisores.-"'
   MSG_EMGrabar = 11002        ', "No se puede grabar registro en la tabla de emisores.-"
   MSG_EMBorrar = 11003        ', "No se puede eliminar registro de la tabla de emisores.-"
   MSG_EMValRut = 11004        ', "El rut el emisor es incorrecto._"
   MSG_EMValNombre = 11005     ', "No ha ingresado nombre.-"
   MSG_EMValGenerico = 11006   ', "No ha ingresado genérico.-"
   MSG_EMValDirec = 11007      ', "No ha ingresado dirección.-"
   MSG_EMValComuna = 11008     ', "No ha ingresado comuna.-"
   MSG_EMVALTipoEmisor = 11009 ', "No ha ingresado Tipo de Emisor.-"
   MSG_EMVALCodigoR = 11010    ', "Código de emisor ya existe.-"
   MSG_EMVALGenericoR = 11011  ', "Genérico ya existe.-"
   MSG_EMGrabarOK = 11012      ', "El registro de emisor se grab¢ con éxito.-"
   MSG_EMBorrarOK = 11013      ', "El registro de emisor ha sido eliminado.-"
   MSG_EMPregunta = 11014      ', "Seguro de eliminar emisor.-@PR"
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Tablas de Uso General
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_TGConeccion = 12001      ', "No se puede conectar a tablas de uso general.-"
   MSG_TGGrabar = 12002         ', "No se puede grabar registro en tablas generales.-"
   MSG_TGBorrar = 12003         ', "No se pudo eliminar registro en tablas generales.-"
   MSG_TGBegin = 12004          ', "No se puede grabar registro en tablas generales. Error en Begin Trans.-"
   MSG_TGBorrarRollBack = 12005 ', "No se puede eliminar registro en tablas generales. Error en RollBack Trans.-"
   MSG_TGGrabarRollback = 12006 ', "No se puede grabar registro en tablas generales. Error en RollBack Trans.-"
   MSG_TGCommit = 12007         ', "No se puede grabar registro en tablas generales. Error en Commit Trans.-"
   MSG_TGValCodigos = 12008     ', "Algunos c¢digos no est n ingresados.-"
   MSG_TGValElemento = 12009    ', "No ha seleccionado elemento de la lista.-"
   MSG_TGGrabarOK = 12010       ', "Grabaci¢n se realiz¢ con éxito.-"
   
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Monedas
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_MNConeccion = 13001     ', "No se puede conectar a tabla de monedas.-"
   MSG_MNGrabar = 13002        ', "No se Puede grabar registro en la tabla de monedas.-"
   MSG_MNBorrar = 13003        ', "No se puede eliminar registro de la tabla monedas.-"
   MSG_MNValCodMon = 13004     ', "El c¢digo de moneda incorrecto.-"
   MSG_MNValGlosa = 13005      ', "No ha ingresado glosa de moneda.-"
   MSG_MNValNemo = 13006       ', "No ha ingresado nemot‚cnico.-"
   MSG_MNValSimbolo = 13007    ', "No ha ingresado s¡mbolo.-"
   MSG_MNVALNemoR = 13008      ', "Nemotécnico ya existe.-"
   MSG_MNVALSimboloR = 13009   ', "Símbolo ya existe.-"
   MSG_MNVALCodSupR = 13010    ', "Código BCR ya existe.-"
   MSG_MNGrabarOK = 13011      ', "Registro de moneda ha sido grabado.-"
   MSG_MNBorrarOK = 13012      ', "Registro de moneda ha sido eliminado.-"
   MSG_MNPregunta = 13013      ', "Seguro de eliminar moneda.-"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Dueños de Carteras
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_DCConeccion = 14001     ', "No se puede conectar a tabla de due¤o de cartera.-"
   MSG_DCGrabar = 14002        ', "No se puede grabar registro en tabla de d. de cartera.-"
   MSG_DCBorrar = 14003        ', "No se puede eliminar registro en tabla de d. de cartera.-"
   MSG_DCValrut = 14004        ', "El rut de due¤o de cratera es incorrecto.-"
   MSG_DCValDescrip = 14005    ', "No ha ingresado descripci¢n de due¤os de cartera.-"
   MSG_DCValcodigo = 14006     ', "No ha ingresado c¢digo de due¤os de cartera.-"
   MSG_DCGrabarOK = 14007      ', "Registro de due¤os de cartera ha sido grabado.-"
   MSG_DCBorrarOK = 14008      ', "Registro de due¤os de cartera ha sido eliminado.-"
   MSG_DCPregunta = 14009      ', "Seguro de eliminar due¤o de cartera.-@PR"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Valores de Monedas
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_VMConeccion = 15001      ', "No se puede conectar a tabla de valores de monedas.-@ST"
   MSG_VMGrabar = 15002         ', "No se puede grabar registros de valores de monedas.-@ST"
   MSG_VMGrabarBegin = 15003    ', "No se puede grabar registros de valores de monedas, error en Begin Trans.-@ST"
   MSG_VMGrabarRollback = 15004 ', "No se puede grabar registros de valores de monedas, error en Rollback Trans.-@ST"
   MSG_VMGrabarCommit = 15005   ', "No se puede grabar registros de valores de monedas, error en Commit Trans.-@ST"
   MSG_VMValMes = 15006         ', "No ha elegido mes.-@VA"
   MSG_VMGrabarOK = 15007       ', "Valores de monedas se grabaron exitosamente.-@OK"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Feriados
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_FEConeccion = 16001      ', "No se puede conectar a tabla de feriados.-@ST"
   MSG_FEGrabar = 16002         ', "No se puede grabar registro en tabla de feriados.-@ST"
   MSG_FEValMes = 16003         ', "No ha seleccionado el mes.-@VA"
   MSG_FEValPlaza = 16004       ', "No ha seleccionado la plaza.-@VA"
   MSG_FEValAno = 16005         ', "El a¤o est  en blanco.-@VA"
   MSG_FEValDiasFer = 16006     ', "Existen mas de 10 dias feriados.-@VA"
   MSG_FEGrabarOK = 16007       ', "Registros de feriados se grabaron exitosamente.-@OK"
   
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Familias
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_FAConeccion = 17001       ', "No se puede conectar a tabla de familias.-@ST"
   MSG_FAGrabar = 17002          ', "No se puede grabar registro de familias.-@ST"
   MSG_FAEliminar = 17003        ', "No se puede eliminar registro de familias.-@ST"
   MSG_FAVALSerie = 17004        ', "No ha ingresado familia.-@VA"
   MSG_FAVALDescripcion = 17005  ', "No ha ingresado descripci¢n de familia.-@VA"
   MSG_FAVALCodFamilia = 17006   ', "No ha ingresado c¢digo de familia.-@VA"
   MSG_FAVALRutina = 17007       ', "No ha ingresado rutina.-@VA"
   MSG_FAVALNominales = 17008    ', "No ha ingresado nominales.-@VA"
   MSG_FAGrabarOK = 17009        ', "Registro de familia grabado exitosamente.-@OK"
   MSG_FAEliminarOK = 17010      ', "Registro de familia Eliminado exitosamente.-@OK"
   MSG_FAPregunta = 17011        ', "Seguro de eliminar familia.-@PR"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Series
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_SEConeccion = 18001      ', "No se puede conectar a tabla de serie.-@ST"
   MSG_SEGrabar = 18002         ', "No se puede grabar registro en tabla de serie.-@ST"
   MSG_SEEliminar = 18003       ', "No se puede eliminar registro en tabla de serie.-@ST"
   MSG_SEVALFamilia = 18004     ', "No ha ingresado familia.-@VA"
   MSG_SEVALMascara = 18005     ', "No ha ingresado m scara.-@VA"
   MSG_SEVALRutEmisor = 18006   ', "No ha ingresado rut del emisor.-@VA"
   MSG_SEVALMoneda = 18007      ', "No ha ingresado moneda.-@VA"
   MSG_SEVALBase = 18008        ', "No ha ingresado base.-@VA"
   MSG_SEVALCupon = 18009       ', "N£mero de cupones debe ser mayor a cero.-@VA"
   MSG_SEVALNumAmort = 18010    ', "N£mero de amortizaci¢n debe ser mayor a cero.-@VA"
   MSG_SEVALNumAmort1 = 18011   ', "N£mero de amortizaci¢n debe ser mayor al n£mero de cupones.-@VA"
   MSG_SEVALFecEmi = 18012      ', "No ha ingresado fecha de emisi¢n.-@VA"
   MSG_SEVALFecVen = 18013      ', "No ha ingresado Fecha de vencimiento.-@VA"
   MSG_SEVALFEmision = 18014    ', "Fecha vencimiento debe ser mayor a fecha emisi¢n.-@VA"
   MSG_SEGrabarOK = 18015       ', "Registro de serie grabado exitosamente.-@OK"
   MSG_SEEliminarOK = 18016     ', "Registro de serie eliminado exitosamente.-@OK"
   MSG_SEPregunta = 18017       ', "Seguro de eliminar registro de serie.-@PR"
   
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Desarrollo
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_TDConeccion = 19001       ', "No se puede conectar a tabla de desarrollo._@ST"
   MSG_TDGrabar = 19002          ' , "No se puede grabar registros en tabla de desarrollo.-@ST"
   MSG_TDGrabarOK = 19003        ', "Grabaci¢n se realiz¢ con ‚xito.-@OK"
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Premios
   '**
   '*/ ----------------------------------------------------------------------------------------
   MSG_TPConeccion = 20001       ', "No se puede conectar a tabla de premios._@ST"
   MSG_TPGrabar = 20002          ', "No se puede grabar registros en tabla de premios.-@ST"
   MSG_TPGrabarOK = 20003        ', "Grabaci¢n se realiz¢ con ‚xito.-@OK"
   
   
   '/* ----------------------------------------------------------------------------------------
   '**
   '**              Contantes Globales para Los Mensajes de Plan de Cuentas
   '**
   '*/ ----------------------------------------------------------------------------------------
   
   MSG_PCConeccion = 21001       ', "No se puede conectar a tabla de P. de Cuentas._@ST"
   MSG_PCGRabar = 21002          ', "No se puede grabar registros en tabla de P. de Cuentas.-@ST"
   MSG_PCEliminar = 21003        ', "No se puede eliminar registro en tabla de P. de Cuentas.-@ST"
   MSG_PCValCuenta = 21004       ', "No ha ingresado Cuenta.-@VA"
   MSG_PCValTipo = 21005         ', "No ha ingresado Tipo.-@VA"
   MSG_PCValDescripcion = 21006  ', "No ha ingresado Descripcion.-@VA"
   MSG_PCValPadre = 21007        ', "No ha ingresado Cuenta Padre.-@VA"
   MSG_PCEliminarOK = 21008      ', "Registro ha sido eliminado.-@OK"
   MSG_PCGrabarOK = 21009        ', "Informaci¢n grabada correctamente.-@OK"
   MSG_PCPregunta = 21010        ', "Seguro de eliminar registro de P. de Cuentas.-@PR"

End Sub
Public Function BacLeeMensaje(IdNumero As Long)

   Dim IdPosicion As Integer
   Dim IdMsg      As String
   Dim IdMensaje  As String
   Dim IdValor    As String

   IdMsg = LoadMensaje(IdNumero)

   IdPosicion = InStr(1, IdMsg, "@", 1)
    
   If IdPosicion = 0 Then
      Exit Function

   End If
    
   IdMensaje = Mid$(IdMsg, 1, IdPosicion - 1)

   IdValor = Mid$(IdMsg, IdPosicion + 1, 2)

   Select Case IdValor
   Case "ST"
      MsgBox IdMensaje, vbCritical

   Case "VA"
      'MsgBox IdMensaje, vbExclamation, "Bac Trader"
      MsgBox IdMensaje, vbInformation

   Case "OK"
      MsgBox IdMensaje, vbInformation

   End Select

End Function

Public Function BacPreguntaMensaje(IdNumero As Long) As Integer

   Dim IdPosicion As Integer
   Dim IdMsg      As String
   Dim IdMensaje  As String
   Dim IdValor    As String

   IdMsg = LoadMensaje(IdNumero)

   IdPosicion = InStr(1, IdMsg, "@", 1)

   If IdPosicion = 0 Then
      Exit Function

   End If

   IdMensaje = Mid$(IdMsg, 1, IdPosicion - 1)

   BacPreguntaMensaje = False

   If (MsgBox(IdMensaje, vbYesNo + vbQuestion) = vbYes) Then
   
      BacPreguntaMensaje = True

   End If

End Function

Public Function BacMsgError()

   Dim Msg As String

   Msg = ""
   Msg = "Error # " & Str(err.Number) & " se generó por "
   Msg = Msg & err.Source & Chr(13) & err.Description

   MsgBox Msg, vbCritical

End Function

Public Function LoadMensaje(iden As Long) As String

   Select Case iden
   Case 100011: LoadMensaje = "No se puede conectar a tabla de operadores.-@ST"
   Case 100021: LoadMensaje = "No se puede eliminar este operador.-@ST"
   Case 100031: LoadMensaje = "No se puede grabar este operador.-@ST"
   Case 100051: LoadMensaje = "El Código del operador ya existe.-@VA"
   Case 100061: LoadMensaje = "No ingresó nombre del operador.-@VA"
   Case 100111: LoadMensaje = "Registro del operador ha sido grabado.-@OK"
   Case 100121: LoadMensaje = "Registro del operador ha sido eliminado.-@OK"
   Case 100131: LoadMensaje = "Está seguro de eliminar al operador.-@OK"
   Case 100012: LoadMensaje = "No se puede conectar a tabla de carteras.-@ST"
   Case 100022: LoadMensaje = "No se puede eliminar esta cartera.-@ST"
   Case 100032: LoadMensaje = "No se puede grabar este cartera.-@ST"
   Case 100052: LoadMensaje = "El Código de la cartera ya existe.-@VA"
   Case 100062: LoadMensaje = "No ingresó nombre del cartera.-@VA"
   Case 100112: LoadMensaje = "Registro de la cartera ha sido grabado.-@OK"
   Case 100122: LoadMensaje = "Registro de la cartera ha sido eliminado.-@OK"
   Case 100132: LoadMensaje = "Está seguro de eliminar la cartera.-@OK"
   Case 100141: LoadMensaje = "Registro del cliente ha sido eliminado.-@OK"
   Case 100142: LoadMensaje = "Está seguro de eliminar al cliente.-@OK"
   Case 13003: LoadMensaje = "No se puede eliminar el registro de tabla de monedas.-@OK"
   Case 13012: LoadMensaje = "Registro de moneda ha sido eliminado.-@OK"
   Case 13013: LoadMensaje = "Seguro de eliminar moneda.-@OK"
   
   
   
   End Select

End Function
