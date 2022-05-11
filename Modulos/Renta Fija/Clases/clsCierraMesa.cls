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
Dim Datos()


Public Function Lee_Mesa() As Boolean

   Envia = Array()
   AddParam Envia, "BTR"
   
   Lee_Mesa = Bac_Sql_Execute("SP_CONTROLPROCESOSLEER", Envia)

   If Lee_Mesa Then
   
      If Bac_SQL_Fetch(Datos()) Then
      
         IniDia = Left(Datos(1), 1)
         Recompras = Left(Datos(2), 1)
         Reventas = Left(Datos(3), 1)
         Cortes = Left(Datos(4), 1)
         Devengo = Left(Datos(5), 1)
         DesconF = Left(Datos(6), 1)
         FinDia = Left(Datos(7), 1)
         FinMes = Left(Datos(8), 1)
      
      End If
   
      Lee_Mesa = Bac_Sql_Execute("SP_CONTROLCIERREMESA")
   
      If Lee_Mesa Then
      
         If Bac_SQL_Fetch(Datos()) Then
         
            CieMesa = Left(Datos(1), 1)
         
         End If
      
      
      End If
   
   End If

End Function

Public Function CierreMesa() As Boolean

   ''''''''' FALTA ACTUALIZAR CIERRE MESA
 
   Envia = Array()
   AddParam Envia, IIf(xValor = False, "0", "1")

   Call Bac_Sql_Execute("SP_ACUTALIZAMESA", Envia)

   CierreMesa = True

   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "APROB" Then
         MsgBox "Faltan operaciones por aprobar.", vbCritical
         CierreMesa = False
      ElseIf Datos(1) = "ERROR" Then
             CierreMesa = False
      End If
   End If

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
