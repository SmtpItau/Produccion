VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "GEN_MENSAJE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Sub VerificaRelacion(ByVal xModulo As String, ByVal nNumDerivado As Long, ByVal xEvento As Long)
   Dim SQLDatos()
   Dim SqlContactos()

   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, nNumDerivado
   AddParam Envia, xModulo
   AddParam Envia, CDbl(xEvento)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_VERIFICA_RELACION", Envia) Then
      Call MsgBox("Ha ocurrido un error en la verificación de Créditos asociados.", vbExclamation, App.Title)
   End If
   Do While Bac_SQL_Fetch(SQLDatos())
      Call SendMail(SQLDatos(1), SQLDatos(2), SQLDatos(3), SQLDatos(4))
   Loop

   Let Screen.MousePointer = vbDefault
End Sub

Private Function SendMail(ByVal Contacto As String, ByVal Email As String, ByVal Mensaje As String, ByVal Firma As String)
   On Error Resume Next
   Dim Enviar      As Object
   Dim ObjCorreo   As Object

   Set ObjCorreo = CreateObject("Outlook.Application")
   Set Enviar = ObjCorreo.CreateItem(0)

   Enviar.To = Email
   Enviar.CC = ""
   Enviar.Subject = Mensaje
   Enviar.Body = "Estimado " & Contacto & "," & vbCrLf & vbTab & Mensaje & vbCrLf & vbCrLf & "Atte." & vbCrLf & Firma
   Enviar.Importance = 1
   Enviar.send

   Set ObjCorreo = Nothing
   Set Enviar = Nothing

   On Error GoTo 0
End Function

