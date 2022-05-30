Attribute VB_Name = "BacValidaClave"
Option Explicit

Global nTipoClave   As String
Global dFechaExpiracion  As Date
Global oBligacion        As Boolean
Global nDiasClave   As Long


'cs req.4116
Public Function CompruebaPWD(xTipoUs As String, Key As Integer) As Boolean

Dim I       As Integer
Dim cadena  As String

CompruebaPWD = True
   
If Key <> 13 And Key <> 8 And Key <> 27 Then

   CompruebaPWD = False
   
   Select Case xTipoUs
      
      Case "A"
               If (UCase(Chr(Key)) >= "A" And UCase(Chr(Key)) <= "Z") Or IsNumeric(Chr(Key)) = True Or InStr("#$%&()*+/=[\]_{}", Chr(Key)) > 0 Then
                  CompruebaPWD = True
               End If
      
      Case "C"
               If (UCase(Chr(Key)) >= "A" And UCase(Chr(Key)) <= "Z") Then
                  CompruebaPWD = True
               End If
      
      Case "N"
      
               CompruebaPWD = IsNumeric(Chr(Key))
      
   End Select

End If


End Function

Public Function ValidaAlfanumerico(Valor As String)
   Dim cont_num   As Integer
   Dim cont_alf   As Integer
   Dim cont_may   As Integer
   Dim I          As Integer

   ValidaAlfanumerico = False
   cont_num = 0
   cont_alf = 0
   cont_may = 0
   
   For I = 1 To Len(Valor)
      
      If IsNumeric(Mid(Valor, I, 1)) Then
         cont_num = cont_num + 1
      End If
      
      If InStr("ABCDEFGHIJKLMNÑOPQRSTWVXYZabcdefghijklmnÑopqrstwvxyz", Mid(Valor, I, 1)) > 0 Then
         cont_alf = cont_alf + 1
      End If
      
      If InStr("ABCDEFGHIJKLMNÑOPQRSTWVXYZ", Mid(Valor, I, 1)) > 0 Then
         cont_may = cont_may + 1
      End If
      
   Next I
    
   If cont_alf > 0 And cont_num > 0 And cont_may > 0 Then
      ValidaAlfanumerico = True
   End If
   
End Function


Public Function expira(xFechaExpira As Date) As Boolean

    'cs req.4146
    Dim FecExpiraAnt
    
    If Format(gsBAC_Fecp, FEFecha) > Format(xFechaExpira, FEFecha) Then
       expira = True
       Exit Function
    End If
    
    expira = False

    FecExpiraAnt = Entrega_Fecha_Aviso(Fecha_Expira, 3)

    If Format(FecExpiraAnt, FEFecha) < Format(gsBAC_Fecp, FEFecha) Then
       If MsgBox("Su clave va expirar el día " & xFechaExpira & ".  ¿ Desea Cambiar la Password ?", vbQuestion + vbYesNo, App.Title) = vbYes Then
          oBligacion = False
          Call Cambio_Password.Show(vbModal)
          xFechaExpira = FecExpiraAnt
       End If
    End If

Exit Function
Err_Fecha_Exp:
   MsgBox "Problemas en la fecha de Expiración", vbCritical, TITSISTEMA

End Function

Public Function Entrega_Fecha_Aviso(dFecha As Date, ByVal nDias As Long) As Date
    
    'cs req.4146
    Dim nContadior  As Long
    Dim ContVuelta    As Long
    Dim Fecha       As String
    
    nContadior = 0
    ContVuelta = 0
    Fecha = DateAdd("D", -1, dFecha)
    
    Do While (1 = 1)
        ContVuelta = ContVuelta + 1
        If BacEsHabil(Fecha) = True Then
            nContadior = nContadior + 1
        End If
        If nContadior = nDias Then
            Exit Do
        Else
            Fecha = DateAdd("D", -1, Fecha)
        End If
        
        If ContVuelta > 30 Then
            Call MsgBox("Favor revisar tabla de feriados.", vbExclamation, App.Title)
            Exit Do
        End If
    Loop
    
    Entrega_Fecha_Aviso = Fecha
End Function


'cs req.4116
Public Function Busca_Tipo_Clave(cUsuario As String) As Boolean
   Dim DATOS()
   nTipoClave = ""
     
   Envia = Array()
   Envia = Array(cUsuario)
   If Not Bac_Sql_Execute("BACPARAMSUDA.dbo.SP_LEE_USUARIOS ", Envia) Then
      Exit Function
   End If

   If Bac_SQL_Fetch(DATOS()) Then
      nTipoClave = DATOS(1)
   End If

End Function
