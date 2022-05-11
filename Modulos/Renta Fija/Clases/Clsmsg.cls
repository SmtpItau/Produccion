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
Public MSG_CLConeccion    As Integer
Public MSG_CLBorrar       As Integer
Public MSG_CLGrabar       As Integer
Public MSG_ClValRut       As Integer
Public MSG_ClValCodigo    As Integer
Public MSG_ClValNombre    As Integer
Public MSG_CLValDireccion As Integer
Public MSG_CLValComuna    As Integer
Public MSG_CLValTipCli    As Integer
Public MSG_CLValSecEcon   As Integer
Public MSG_CLGrabarOK     As Integer
Public MSG_CLBorrarOK     As Integer
Public MSG_CLPregunta     As Integer

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


Public Function BACLoadResString(ByVal IdNumero As Double, ByRef IdMsg As String, ByRef IdValor As String)

    Select Case IdNumero
    
            Case 10001: IdMsg = "No se puede conectar a tabla de clientes": IdValor = "ST"

            Case 10002: IdMsg = "No se puede eliminar este cliente": IdValor = "ST"

            Case 10003: IdMsg = "No se puede grabar este cliente": IdValor = "ST"

            Case 10004: IdMsg = "El rut del cliente es incorrecto": IdValor = "VA"

            Case 10005: IdMsg = "El Código del cliente ya existe": IdValor = "VA"

            Case 10006: IdMsg = "No ha ingresado nombre del cliente": IdValor = "VA"

            Case 10007: IdMsg = "No ha ingresado direcci¢n del cliente": IdValor = "VA"

            Case 10008: IdMsg = "No ha ingresado comuna del cliente": IdValor = "VA"

            Case 10009: IdMsg = "No ha ingresado tipo de cliente": IdValor = "VA"

            Case 10010: IdMsg = "No ha ingresado setor econ¢mico del cliente": IdValor = "VA"

            Case 10011: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"

            Case 10012: IdMsg = "Registro ha sido eliminado": IdValor = "OK"

            Case 10013: IdMsg = "Seguro de eliminar cliente": IdValor = "PR"

       
            Case 11001: IdMsg = "No se puede conectar a tabla de emisores": IdValor = "ST"

            Case 11002: IdMsg = "No se puede grabar registro en la tabla de emisores": IdValor = "ST"

            Case 11003: IdMsg = "No se puede eliminar registro de la tabla de emisores": IdValor = "ST"
            
            Case 11004: IdMsg = "El rut el emisor es incorrecto": IdValor = "VA"
            
            Case 11005: IdMsg = "No ha ingresado nombre": IdValor = "VA"
            
            Case 11006: IdMsg = "No ha ingresado gen‚rico": IdValor = "VA"
            
            Case 11007: IdMsg = "No ha ingresado direcci¢n": IdValor = "VA"
            
            Case 11008: IdMsg = "No ha ingresado comuna": IdValor = "VA"
            
            Case 11009: IdMsg = "No ha ingresado tipo de emisor": IdValor = "VA"
            
            Case 11010: IdMsg = "C¢digo de emisor ya existe": IdValor = "VA"
            
            Case 11011: IdMsg = "Gen‚rico ya existe": IdValor = "VA"
            
            Case 11012: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 11013: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 11014: IdMsg = "Seguro de eliminar emisor": IdValor = "PR"
            
            Case 12001: IdMsg = "No se puede conectar a tablas de uso general": IdValor = "ST"
            
            Case 12002: IdMsg = "No se puede grabar registro en tablas generales": IdValor = "ST"
            
            Case 12003: IdMsg = "No se puede eliminar registro en tablas generales": IdValor = "ST"
            
            Case 12004: IdMsg = "No se puede grabar registro en tablas generales. Error en Begin Trans": IdValor = "ST"
            
            Case 12005: IdMsg = "No se puede eliminar registro en tablas generales. Error en RollBack Trans": IdValor = "ST"
            
            Case 12006: IdMsg = "No se puede grabar registro en tablas generales. Error en RollBack Trans": IdValor = "ST"
            
            Case 12007: IdMsg = "No se puede grabar registro en tablas generales. Error en Commit Trans": IdValor = "ST"
            
            Case 12008: IdMsg = "Algunos c¢digos no est n ingresados": IdValor = "VA"
            
            Case 12009: IdMsg = "No ha seleccionado elemento de la lista": IdValor = "VA"
            
            Case 12010: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 13001: IdMsg = "No se puede conectar a tabla de monedas": IdValor = "ST"
            
            Case 13002: IdMsg = "No se puede grabar registro en la tabla de monedas": IdValor = "ST"
            
            Case 13003: IdMsg = "No se puede eliminar registro de la tabla monedas": IdValor = "ST"
            
            Case 13004: IdMsg = "El c¢digo de moneda incorrecto": IdValor = "VA"
            
            Case 13005: IdMsg = "No ha ingresado glosa de moneda": IdValor = "VA"
            
            Case 13006: IdMsg = "No ha ingresado nemot‚cnico": IdValor = "VA"
            
            Case 13007: IdMsg = "No ha ingresado s¡mbolo": IdValor = "VA"
            
            Case 13008: IdMsg = "Nemot‚cnico ya existe": IdValor = "VA"
            
            Case 13009: IdMsg = "S¡mbolo de Moneda ya existe": IdValor = "VA"
            
            Case 13010: IdMsg = "C¢digo BCR ya existe": IdValor = "VA"
            
            Case 13011: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 13012: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 13013: IdMsg = "Seguro de eliminar moneda": IdValor = "PR"
            
            Case 14001: IdMsg = "No se puede conectar a tabla de due¤o de cartera": IdValor = "ST"
            
            Case 14002: IdMsg = "No se puede grabar registro en tabla de d. de cartera": IdValor = "ST"
            
            Case 14003: IdMsg = "No se puede eliminar registro en tabla de d. de cartera": IdValor = "ST"
            
            Case 14004: IdMsg = "El rut de due¤o de cratera es incorrecto": IdValor = "VA"
            
            Case 14005: IdMsg = "No ha ingresado descripci¢n de due¤os de cartera": IdValor = "VA"
            
            Case 14006: IdMsg = "No ha ingresado c¢digo de due¤os de cartera": IdValor = "VA"
            
            Case 14007: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 14008: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 14009: IdMsg = "Seguro de eliminar due¤o de cartera": IdValor = "PR"
            
            Case 15001: IdMsg = "No se puede conectar a tabla de valores de monedas": IdValor = "ST"
            
            Case 15002: IdMsg = "No se puede grabar registros de valores de monedas": IdValor = "ST"
            
            Case 15003: IdMsg = "No se puede grabar registros de valores de monedas, error en Begin Trans": IdValor = "ST"
            
            Case 15004: IdMsg = "No se puede grabar registros de valores de monedas, error en Rollback Trans": IdValor = "ST"
            
            Case 15005: IdMsg = "No se puede grabar registros de valores de monedas, error en Commit Trans": IdValor = "ST"
            
            Case 15006: IdMsg = "No ha elegido mes": IdValor = "VA"
            
            Case 15007: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 16001: IdMsg = "No se puede conectar a tabla de feriados": IdValor = "ST"
            
            Case 16002: IdMsg = "No se puede grabar registro en tabla de feriados": IdValor = "ST"
            
            Case 16003: IdMsg = "No ha seleccionado el mes": IdValor = "VA"
            
            Case 16004: IdMsg = "No ha seleccionado la plaza": IdValor = "VA"
            
            Case 16005: IdMsg = "El a¤o est  en blanco": IdValor = "VA"
            
            Case 16006: IdMsg = "Existen mas de 10 dias feriados": IdValor = "VA"
            
            Case 16007: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 17001: IdMsg = "No se puede conectar a tabla de familias": IdValor = "ST"
            
            Case 17002: IdMsg = "No se puede grabar registro de familias": IdValor = "ST"
            
            Case 17003: IdMsg = "No se puede eliminar registro de familias": IdValor = "ST"
            
            Case 17004: IdMsg = "No ha ingresado familia": IdValor = "VA"
            
            Case 17005: IdMsg = "No ha ingresado descripci¢n de familia": IdValor = "VA"
            
            Case 17006: IdMsg = "No ha ingresado c¢digo de familia": IdValor = "VA"
            
            Case 17007: IdMsg = "No ha ingresado rutina": IdValor = "VA"
            
            Case 17008: IdMsg = "No ha ingresado nominales": IdValor = "VA"
            
            Case 17009: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 17010: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 17011: IdMsg = "Seguro de eliminar familia": IdValor = "PR"
            
            Case 18001: IdMsg = "No se puede conectar a tabla de serie": IdValor = "ST"
            
            Case 18002: IdMsg = "No se puede grabar registro en tabla de serie": IdValor = "ST"
            
            Case 18003: IdMsg = "No se puede eliminar registro en tabla de serie": IdValor = "ST"
            
            Case 18004: IdMsg = "No ha ingresado familia": IdValor = "VA"
            
            Case 18005: IdMsg = "No ha ingresado m scara": IdValor = "VA"
            
            Case 18006: IdMsg = "No ha ingresado rut del emisor": IdValor = "VA"
            
            Case 18007: IdMsg = "No ha ingresado moneda": IdValor = "VA"
            
            Case 18008: IdMsg = "No ha ingresado base": IdValor = "VA"
            
            Case 18009: IdMsg = "N£mero de cupones debe ser mayor a cero": IdValor = "VA"
            
            Case 18010: IdMsg = "N£mero de amortizaci¢n debe ser mayor a cero": IdValor = "VA"
            
            Case 18011: IdMsg = "N£mero de amortizaci¢n debe ser mayor al n£mero de cupones": IdValor = "VA"
            
            Case 18012: IdMsg = "No ha ingresado fecha de emisi¢n": IdValor = "VA"
            
            Case 18013: IdMsg = "No ha ingresado fecha de vencimiento": IdValor = "VA"
            
            Case 18014: IdMsg = "Fecha vencimiento debe ser mayor a fecha emisi¢n": IdValor = "VA"
            
            Case 18015: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 18016: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 18017: IdMsg = "Seguro de eliminar registro de serie": IdValor = "PR"
            
            
            Case 19001: IdMsg = "No se puede conectar a tabla de desarrollo._@ST"
            
            Case 19002: IdMsg = "No se puede grabar registros en tabla de desarrollo": IdValor = "ST"
            
            Case 19003: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 20001: IdMsg = "No se puede conectar a tabla de premios._@ST"
            
            Case 20002: IdMsg = "No se puede grabar registros en tabla de premios": IdValor = "ST"
            
            Case 20003: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            
            Case 21001: IdMsg = "No se puede conectar a tabla de P. de Cuentas._@ST"
            
            Case 21002: IdMsg = "No se puede grabar registros en tabla de P. de Cuentas": IdValor = "ST"
            
            Case 21003: IdMsg = "No se puede eliminar registro en tabla de P. de Cuentas": IdValor = "ST"
            
            Case 21004: IdMsg = "No ha ingresado Cuenta": IdValor = "VA"
            
            Case 21005: IdMsg = "No ha ingresado Tipo": IdValor = "VA"
            
            Case 21006: IdMsg = "No ha ingresado Descripcion": IdValor = "VA"
            
            Case 21007: IdMsg = "No ha ingresado Cuenta Padre": IdValor = "VA"
            
            Case 21008: IdMsg = "Registro ha sido eliminado": IdValor = "OK"
            
            Case 21009: IdMsg = "Informaci¢n grabada correctamente": IdValor = "OK"
            
            Case 21010: IdMsg = "Seguro de eliminar registro de P. de Cuentas": IdValor = "PR"
            
    End Select

End Function

Public Sub Valores()
'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Clientes
'**
'*/ ----------------------------------------------------------------------------------------
MSG_CLConeccion = 10001     ', "No se puede conectar a tabla de clientes.-"
MSG_CLBorrar = 10002        ', "No se puede eliminar este cliente.-"
MSG_CLGrabar = 10003        ', "No se puede grabar este cliente.-"
MSG_ClValRut = 10004        ', "El rut del cliente es incorrecto.-"
MSG_ClValCodigo = 10005     ', "El Código del cliente ya existe.-"
MSG_ClValNombre = 10006     ', "No ingres¢ nombre del cliente.-"
MSG_CLValDireccion = 10007  ', "No ingres¢ direcci¢n del cliente.-"
MSG_CLValComuna = 10008     ', "No ingres¢ comuna del cliente.-"
MSG_CLValTipCli = 10009     ', "No ingres¢ tipo de cliente.-"
MSG_CLValSecEcon = 10010    ', "No ingres¢ setor econ¢mico del cliente.-"
MSG_CLGrabarOK = 10011      ', "Registro cliente ha sido grabado.-"
MSG_CLBorrarOK = 10012      ', "Registro cliente ha sido eliminado.-"
MSG_CLPregunta = 10013      ', "Seguro de eliminar cliente" : idvalor = "PR"

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
MSG_EMPregunta = 11014      ', "Seguro de eliminar emisor" : idvalor = "PR"
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
MSG_DCPregunta = 14009      ', "Seguro de eliminar due¤o de cartera" : idvalor = "PR"

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Valores de Monedas
'**
'*/ ----------------------------------------------------------------------------------------
MSG_VMConeccion = 15001      ', "No se puede conectar a tabla de valores de monedas" : idvalor = "ST"
MSG_VMGrabar = 15002         ', "No se puede grabar registros de valores de monedas" : idvalor = "ST"
MSG_VMGrabarBegin = 15003    ', "No se puede grabar registros de valores de monedas, error en Begin Trans" : idvalor = "ST"
MSG_VMGrabarRollback = 15004 ', "No se puede grabar registros de valores de monedas, error en Rollback Trans" : idvalor = "ST"
MSG_VMGrabarCommit = 15005   ', "No se puede grabar registros de valores de monedas, error en Commit Trans" : idvalor = "ST"
MSG_VMValMes = 15006         ', "No ha elegido mes" : idvalor = "VA"
MSG_VMGrabarOK = 15007       ', "Valores de monedas se grabaron exitosamente" : idvalor = "OK"

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Feriados
'**
'*/ ----------------------------------------------------------------------------------------
MSG_FEConeccion = 16001      ', "No se puede conectar a tabla de feriados" : idvalor = "ST"
MSG_FEGrabar = 16002         ', "No se puede grabar registro en tabla de feriados" : idvalor = "ST"
MSG_FEValMes = 16003         ', "No ha seleccionado el mes" : idvalor = "VA"
MSG_FEValPlaza = 16004       ', "No ha seleccionado la plaza" : idvalor = "VA"
MSG_FEValAno = 16005         ', "El a¤o est  en blanco" : idvalor = "VA"
MSG_FEValDiasFer = 16006     ', "Existen mas de 10 dias feriados" : idvalor = "VA"
MSG_FEGrabarOK = 16007       ', "Registros de feriados se grabaron exitosamente" : idvalor = "OK"


'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Familias
'**
'*/ ----------------------------------------------------------------------------------------
MSG_FAConeccion = 17001       ', "No se puede conectar a tabla de familias" : idvalor = "ST"
MSG_FAGrabar = 17002          ', "No se puede grabar registro de familias" : idvalor = "ST"
MSG_FAEliminar = 17003        ', "No se puede eliminar registro de familias" : idvalor = "ST"
MSG_FAVALSerie = 17004        ', "No ha ingresado familia" : idvalor = "VA"
MSG_FAVALDescripcion = 17005  ', "No ha ingresado descripci¢n de familia" : idvalor = "VA"
MSG_FAVALCodFamilia = 17006   ', "No ha ingresado c¢digo de familia" : idvalor = "VA"
MSG_FAVALRutina = 17007       ', "No ha ingresado rutina" : idvalor = "VA"
MSG_FAVALNominales = 17008    ', "No ha ingresado nominales" : idvalor = "VA"
MSG_FAGrabarOK = 17009        ', "Registro de familia grabado exitosamente" : idvalor = "OK"
MSG_FAEliminarOK = 17010      ', "Registro de familia Eliminado exitosamente" : idvalor = "OK"
MSG_FAPregunta = 17011        ', "Seguro de eliminar familia" : idvalor = "PR"

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Series
'**
'*/ ----------------------------------------------------------------------------------------
MSG_SEConeccion = 18001      ', "No se puede conectar a tabla de serie" : idvalor = "ST"
MSG_SEGrabar = 18002         ', "No se puede grabar registro en tabla de serie" : idvalor = "ST"
MSG_SEEliminar = 18003       ', "No se puede eliminar registro en tabla de serie" : idvalor = "ST"
MSG_SEVALFamilia = 18004     ', "No ha ingresado familia" : idvalor = "VA"
MSG_SEVALMascara = 18005     ', "No ha ingresado m scara" : idvalor = "VA"
MSG_SEVALRutEmisor = 18006   ', "No ha ingresado rut del emisor" : idvalor = "VA"
MSG_SEVALMoneda = 18007      ', "No ha ingresado moneda" : idvalor = "VA"
MSG_SEVALBase = 18008        ', "No ha ingresado base" : idvalor = "VA"
MSG_SEVALCupon = 18009       ', "N£mero de cupones debe ser mayor a cero" : idvalor = "VA"
MSG_SEVALNumAmort = 18010    ', "N£mero de amortizaci¢n debe ser mayor a cero" : idvalor = "VA"
MSG_SEVALNumAmort1 = 18011   ', "N£mero de amortizaci¢n debe ser mayor al n£mero de cupones" : idvalor = "VA"
MSG_SEVALFecEmi = 18012      ', "No ha ingresado fecha de emisi¢n" : idvalor = "VA"
MSG_SEVALFecVen = 18013      ', "No ha ingresado Fecha de vencimiento" : idvalor = "VA"
MSG_SEVALFEmision = 18014    ', "Fecha vencimiento debe ser mayor a fecha emisi¢n" : idvalor = "VA"
MSG_SEGrabarOK = 18015       ', "Registro de serie grabado exitosamente" : idvalor = "OK"
MSG_SEEliminarOK = 18016     ', "Registro de serie eliminado exitosamente" : idvalor = "OK"
MSG_SEPregunta = 18017       ', "Seguro de eliminar registro de serie" : idvalor = "PR"


'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Desarrollo
'**
'*/ ----------------------------------------------------------------------------------------
MSG_TDConeccion = 19001       ', "No se puede conectar a tabla de desarrollo._@ST"
MSG_TDGrabar = 19002          ': idmsg = "No se puede grabar registros en tabla de desarrollo" : idvalor = "ST"
MSG_TDGrabarOK = 19003        ', "Grabaci¢n se realiz¢ con ‚xito" : idvalor = "OK"

'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Premios
'**
'*/ ----------------------------------------------------------------------------------------
MSG_TPConeccion = 20001       ', "No se puede conectar a tabla de premios._@ST"
MSG_TPGrabar = 20002          ', "No se puede grabar registros en tabla de premios" : idvalor = "ST"
MSG_TPGrabarOK = 20003        ', "Grabaci¢n se realiz¢ con ‚xito" : idvalor = "OK"


'/* ----------------------------------------------------------------------------------------
'**
'**              Contantes Globales para Los Mensajes de Plan de Cuentas
'**
'*/ ----------------------------------------------------------------------------------------

MSG_PCConeccion = 21001       ', "No se puede conectar a tabla de P. de Cuentas._@ST"
MSG_PCGRabar = 21002          ', "No se puede grabar registros en tabla de P. de Cuentas" : idvalor = "ST"
MSG_PCEliminar = 21003        ', "No se puede eliminar registro en tabla de P. de Cuentas" : idvalor = "ST"
MSG_PCValCuenta = 21004       ', "No ha ingresado Cuenta" : idvalor = "VA"
MSG_PCValTipo = 21005         ', "No ha ingresado Tipo" : idvalor = "VA"
MSG_PCValDescripcion = 21006  ', "No ha ingresado Descripcion" : idvalor = "VA"
MSG_PCValPadre = 21007        ', "No ha ingresado Cuenta Padre" : idvalor = "VA"
MSG_PCEliminarOK = 21008      ', "Registro ha sido eliminado" : idvalor = "OK"
MSG_PCGrabarOK = 21009        ', "Informaci¢n grabada correctamente" : idvalor = "OK"
MSG_PCPregunta = 21010        ', "Seguro de eliminar registro de P. de Cuentas" : idvalor = "PR"


End Sub

Public Function BacLeeMensaje(IdNumero As Long)
Dim IdPosicion As Integer
Dim IdMsg      As String
Dim IdMensaje  As String
Dim IdValor    As String
    
    Call BACLoadResString(IdNumero, IdMsg, IdValor)
        
    Select Case IdValor
           Case "ST"
                MsgBox IdMsg, vbCritical, gsBac_Version
           Case "VA"
                'MsgBox IdMensaje, vbExclamation, "BAC Trader"
                MsgBox IdMsg, vbInformation, gsBac_Version
           Case "OK"
                MsgBox IdMsg, vbInformation, gsBac_Version
    End Select
    
    
End Function


Public Function BacPreguntaMensaje(IdNumero As Long) As Integer
Dim IdPosicion As Integer
Dim IdMsg      As String
Dim IdMensaje  As String
Dim IdValor    As String

    Call BACLoadResString(IdNumero, IdMsg, IdValor)
    
    BacPreguntaMensaje = False
    
    If (MsgBox(IdMsg, vbYesNo + vbQuestion, gsBac_Version) = vbYes) Then
       BacPreguntaMensaje = True
    End If
    
End Function




Public Function BacMsgError()
Dim Msg As String

    Msg = "Error # " & Str(err.Number) & " se generó por "
    Msg = Msg & err.Source & Chr(13) & err.Description
    MsgBox Msg
       
End Function


