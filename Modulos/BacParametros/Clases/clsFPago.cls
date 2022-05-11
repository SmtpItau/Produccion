VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsForPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim SQL$, Datos(), i&
Public Codigo           As Integer
Public Glosa            As String
Public Perfil           As String
Public CodGen           As Integer
Public Glosa2           As String
Public cc2756           As String
Public AfectaCorr       As String
Public DiasValor        As Integer
Public NumCheque        As String
Public CtaCte           As String
Public iDiasLineas      As Integer
Public CodigoBolsa      As String

Public Sub Limpiar()
   Codigo = 0
   Glosa = ""
   Perfil = ""
   CodGen = 0
   Glosa2 = ""
   cc2756 = ""
   AfectaCorr = ""
   DiasValor = 0
   NumCheque = ""
   CtaCte = ""
   iDiasLineas = 0
End Sub

Public Function LeerxCodigo(iCodigo%) As Boolean
   
   LeerxCodigo = False
   
   Envia = Array()
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("SP_LEER_FORMAPAGO", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Codigo = Val(Datos(1))
      Glosa = Datos(2)
      Glosa2 = Datos(3)
      Perfil = Datos(4)
      CodGen = Val(Datos(5))
      cc2756 = Datos(6)
      AfectaCorr = Datos(7)
      DiasValor = Val(Datos(8))
      NumCheque = Datos(9)
      CtaCte = Datos(10)
      iDiasLineas = Val(Datos(11))
      CodigoBolsa = Datos(12)
   End If
   LeerxCodigo = True
End Function

Public Function Eliminar(iCodigo%) As Boolean
    
   Eliminar = False
   
   Envia = Array()
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("SP_BORRAR_FORMAPAGO", Envia) Then
      MsgBox "Error en la Eliminacion", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Val(Datos(1)) < 0 Then
         MsgBox Datos(2), vbExclamation, TITSISTEMA
      Else
         Eliminar = True
         MsgBox Datos(2), vbInformation, TITSISTEMA
      End If
   End If
   
End Function

Public Function Grabar() As Boolean
   Dim Datos()
   
   Grabar = False
   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Codigo
   AddParam Envia, Glosa
   AddParam Envia, Perfil
   AddParam Envia, CodGen
   AddParam Envia, Glosa2
   AddParam Envia, cc2756
   AddParam Envia, AfectaCorr
   AddParam Envia, DiasValor
   AddParam Envia, NumCheque
   AddParam Envia, CtaCte
   AddParam Envia, CDbl(iDiasLineas)
   AddParam Envia, CodigoBolsa
   
   If Not Bac_Sql_Execute("SP_GRABAR_FORMAPAGO ", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Hubo Problemas", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Screen.MousePointer = vbDefault
      If Val(Datos(1)) < 0 Then
         MsgBox Datos(2), vbExclamation, TITSISTEMA
      Else
         MsgBox Datos(2), vbInformation, TITSISTEMA
         Grabar = True
      End If
   End If
End Function

Public Function GrabarxMoneda(iMoneda%, iMonPago, iFPago%, sActiva$) As Boolean
    i = Screen.MousePointer
    Screen.MousePointer = 11

    GrabarxMoneda = False
    
    If Val(sActiva) <> 1 Then
        sActiva = "0"
    End If
    
    Envia = Array()
    AddParam Envia, "PCS"
    AddParam Envia, iMoneda
    AddParam Envia, iMonPago
    AddParam Envia, iFPago
    AddParam Envia, sActiva
    
    GrabarxMoneda = (Bac_Sql_Execute("SP_GRABAR_DOCPAGOMONEDA 'PCS'"))
        
    If Bac_SQL_Fetch(Datos()) Then
        If Val(Datos(1)) <> 0 Then
            Screen.MousePointer = 0
            GrabarxMoneda = False
            MsgBox Datos(2), vbCritical, TITSISTEMA
            Exit Function
        End If
    End If
    
    Screen.MousePointer = i

End Function

Public Function CargaObjectos(Obj As Object, Optional iTipo) As Boolean
   
   CargaObjectos = False

   If IsMissing(iTipo) Then
      iTipo = 0
   End If

   Envia = Array()
   AddParam Envia, "0"
   If Not Bac_Sql_Execute("SP_LEER_FORMAPAGO", Envia) Then
      MsgBox "Problemas al Leer Formas de Pago", vbCritical, TITSISTEMA
      Exit Function
   End If
   If iTipo = 1 Then
      Obj.Rows = 2
   Else
      Obj.Clear
   End If
   If iTipo = 1 Then
      Obj.Redraw = False
   End If
    
   Do While Bac_SQL_Fetch(Datos())
      If iTipo = 1 Then
         Obj.Row = Obj.Rows - 1
         Obj.TextMatrix(Obj.Row, 0) = Val(Datos(1))
         Obj.TextMatrix(Obj.Row, 1) = " "
         Obj.TextMatrix(Obj.Row, 2) = UCase(Datos(2))
         Obj.Rows = Obj.Rows + 1
      Else
         Obj.AddItem RELLENA_STRING(UCase(Datos(2)), "D", 40) & Space(1) & Datos(1) ' - Len(Datos(1))) & Trim(Datos(1))
         Obj.ItemData(Obj.NewIndex) = Val(Datos(1))
      End If
      CargaObjectos = True
   Loop
   If Not CargaObjectos Then
      If iTipo = 1 Then
         Obj.Redraw = True
      End If
      Exit Function
   End If
   If iTipo = 1 Then
      Obj.Redraw = True
   End If
End Function

Public Function CargaxMoneda(iMoneda%, iMonPago%, Obj As Object, Optional iTipo) As Boolean

   CargaxMoneda = False
    
   If IsMissing(iTipo) Then
      iTipo = 0
   End If
    
   Envia = Array()
   AddParam Envia, iMoneda
   AddParam Envia, iMonPago
   AddParam Envia, 0
   AddParam Envia, "1"
   If Not Bac_Sql_Execute("SP_LEER_DOCPAGOMONEDA", Envia) Then
      MsgBox "Problemas al Leer Formas de Pago por Moneda", vbCritical, TITSISTEMA
      Exit Function
   End If
   If iTipo = 0 Then
      Obj.Clear
   End If
   Do While Bac_SQL_Fetch(Datos())
      If iTipo = 1 Then
         For i = 1 To Obj.Rows - 1
            If Val(Obj.TextMatrix(i, 0)) = Val(Datos(5)) Then
               Obj.TextMatrix(i, 1) = IIf(Val(Datos(7)) <> 0, "X", "")
            End If
         Next i
      Else
         Obj.AddItem Datos(6)
         Obj.ItemData(Obj.NewIndex) = Val(Datos(5))
      End If
      CargaxMoneda = True
   Loop
End Function
