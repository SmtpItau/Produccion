VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCierraMesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public IniDia     As String
Public Recompras  As String
Public Reventas   As String
Public Cortes     As String
Public Devengo    As String
Public DesconF    As String
Public FinDia     As String
Public FinMes     As String
Public CieMesa    As String
Public xValor     As Boolean
Dim datos()


Public Function Lee_Mesa() As Boolean

   envia = Array()
   AddParam envia, "BTR"
   
   Lee_Mesa = Bac_Sql_Execute("Sp_ControlProcesosLeer", envia)

   If Lee_Mesa Then
   
      If Bac_SQL_Fetch(datos()) Then
      
         IniDia = Left(datos(1), 1)
         Devengo = Left(datos(2), 1)
         FinDia = Left(datos(4), 1)
      
      
      End If
   
      Lee_Mesa = Bac_Sql_Execute("Sp_ControlCierreMesa")
   
      If Lee_Mesa Then
      
         If Bac_SQL_Fetch(datos()) Then
         
            CieMesa = Left(datos(1), 1)
         
         End If
      
      
      End If
   
   End If

End Function

Public Function CierreMesa() As Boolean

   ''''''''' FALTA ACTUALIZAR CIERRE MESA

   envia = Array()
   AddParam envia, IIf(xValor = False, "0", "1")

   CierreMesa = Bac_Sql_Execute("Svc_gen_act_mes", envia)

End Function

Private Sub Limpiar()

         IniDia = ""
         Recompras = ""
         Reventas = ""
         Cortes = ""
         Devengo = ""
         DesconF = ""
         FinDia = ""
         FinMes = ""
         CieMesa = ""

End Sub



Private Sub Class_Initialize()
         
         Call Limpiar

End Sub
