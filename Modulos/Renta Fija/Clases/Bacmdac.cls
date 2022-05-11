VERSION 1.0 CLASS
BEGIN
  MultiUse = 0   'False
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsParametros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'MFAC : TABLA DE PARAMETROS
'-----------------------------------------------
Public ACrutprop           As Long
Public ACdigprop           As String
Public ACnomprop           As String
Public ACCodClie           As Integer
Public ACfecante           As String
Public ACfecproc           As String
Public ACfecprox           As String
Public ACsucmesa           As Integer
Public ACofimesa           As Integer
Public ACcodmonloc         As Integer
Public ACcodmondol         As Integer
Public ACcodmonuf          As Integer
Public ACcodmonobs         As Integer
Public ACnumdecimales      As Integer
Public ACpais              As Integer
Public ACplaza             As Integer
Public ACcodempresa        As Integer
Public ACSW_PD             As String
Public ACSW_FD             As String
Public ACsw_ciemefwd       As String
Public ACsw_devenfwd       As String
Public ACsw_contafwd       As String
Public ACvaloruf           As Double
Public AcValDolObs         As Double
Public ACDirProp           As String
Public ACFono              As String
Public ACFax           As String
'Sub CierredeMesa()
'
'  Dim Datos()
   
'   If Not Bac_Sql_Execute("bacFwdSuda..sp_cierremesa") Then
'
'      MsgBox "No se puede realizar el cierre de mesa", vbExclamation, "Cierre de Mesa"
'      Exit Sub'
'
'   End If'

   'Do While Bac_SQL_Fetch(Datos())
   
   '   If Datos(1) = "0" Then
   '      ACsw_ciemefwd = "0"
   '      MsgBox "Se Ha Desactivado El Cierre de Mesa", vbInformation, "MENSAJE"'

      'ElseIf Datos(1) = "1" Then
      
      '   ACsw_ciemefwd = "1"
      '   MsgBox "Se Ha Realizado El Cierre de Mesa", vbInformation, "MENSAJE"
         
      'Else
      
       '  ACsw_ciemefwd = "0"
       '  MsgBox "Existen Operaciones Con Problemas de Límites " & vbCrLf & " No se Puede Cerrar la Mesa", vbInformation, "MENSAJE"

      'End If

   'Loop
   
   'Call gsc_Parametros.DatosGenerales

'End Sub
Public Function DatosGenerales() As Boolean

   Dim Datos()

   DatosGenerales = False

   If Bac_Sql_Execute("bacFwdSuda..SP_DATOSGENERALES") Then
      
      If Bac_SQL_Fetch(Datos()) Then
         
         ACrutprop = Datos(1)
         ACdigprop = Datos(2)
         ACnomprop = Datos(3)
         ACfecante = Datos(4)
         ACfecproc = Datos(5)
         ACfecprox = Datos(6)
         ACsucmesa = Datos(7)
         ACofimesa = Datos(8)
         ACcodmonloc = Datos(9)
         ACcodmondol = Datos(10)
         ACcodmonuf = Datos(11)
         ACcodmonobs = Datos(12)
         ACnumdecimales = Datos(13)
         ACpais = Datos(14)
         ACplaza = Datos(15)
         ACcodempresa = Datos(16)
         ACSW_PD = Datos(17)
         ACSW_FD = Datos(18)
         ACsw_ciemefwd = Datos(19)
         ACsw_devenfwd = Datos(20)
         ACsw_contafwd = Datos(21)
         ACvaloruf = Datos(22)
         AcValDolObs = Datos(23)
         ACCodClie = Datos(24)
         ACDirProp = Datos(25)
         ACFono = Datos(26)
         ACFax = Datos(27)

         DatosGenerales = True
         
         'If ACsw_ciemefwd = "1" Then
         '   BACForward.Opc_21000.Checked = True
         'Else
         '   BACForward.Opc_21000.Checked = False
         'End If
         
      End If
      
   Else
      
      MsgBox "Error de Recuperaciòn de datos", vbCritical
      
   End If

End Function

