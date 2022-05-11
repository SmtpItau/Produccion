VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsRecupInter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public TipOper     As String
Public Fecini        As String
Public Plazo         As String
Public FecVen     As String
Public Moneda   As String
Public Base         As String
Public valor         As String
Public MtoInicial   As String
Public Interes       As String
Public MtoFinal    As String
Public RutCar      As String
Public DigVeri      As String
Public NomCar    As String
Public TipCar       As String
Public Forpai        As String
Public Forpav       As String
Public Tipret         As String
Public Tippag       As String
Public RutCli        As String
Public CodCli       As String
Public DigCli        As String
Public NomCli     As String


Public VAL_ALTAMIRA As String

Public Function AnulaInter(sNumoper As String, TipOper As String, Optional tipo As String) As Integer
Dim Datos()

    AnulaInter = 0
    Envia = Array(CDbl(sNumoper))
    
    If TipOper = "CAP" Then
'        Sql = "SP_ANULACAPTACION "
'        Sql = Sql + sNumoper
        
        If Not Bac_Sql_Execute("SP_ANULACAPTACION", Envia) Then
            AnulaInter = 1
            Exit Function
        End If
        
    Else
'        Sql = "SP_ANULAINTERBANCARIO "
'        Sql = Sql + sNumoper
        
        If Not Bac_Sql_Execute("SP_ANULAINTERBANCARIO", Envia) Then
            AnulaInter = 1
            Exit Function
        End If
        
    End If
    
    '********** Linea -- Mkilo
    If gsBac_Lineas = "S" Then
    
        If Not Lineas_Anular("BTR", CDbl(sNumoper)) Then
'           Exit Function
        End If
        
        '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        If tipo = "ICOL" Then
            Dim oParametrosLineaICOL As New clsControlLineaIDD
    
              With oParametrosLineaICOL
                  .Modulo = "BTR"
                  .Producto = tipo
                  .Operacion = CDbl(sNumoper)
                  .Documento = CDbl(sNumoper)
                  .Correlativo = 1
                  .Accion = "R"
    
                  .RecuperaDatosLineaIDD
                  
                  If .NumeroIddAnula <> 0 Then 'solo puede ejecutar proceso si consumio linea
                    .EjecutaProcesoWsLineaIDD
                  End If
              End With
              Set oParametrosLineaICOL = Nothing
              On Error GoTo seguiranulacionICOL ' si existe error debe seguir con el proceso BAC
        End If
        '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
        
    End If
    '********* Fin
    
seguiranulacionICOL:
   
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, IIf(TipOper = "CAP", "Anulación de captaciones ", "Anulación de Interbancarios") & " número: " & sNumoper & ", anulada con éxito.")

    Call LimpiaClase
    

End Function




Public Function BuscaDatos(sNumoper As String, sTipOper As String) As Integer
Dim Datos()

    BuscaDatos = 0
    Envia = Array(CDbl(sNumoper))
    
    If sTipOper = "CAP" Then
'        Sql = "SP_BUSCACAPTACION "
'        Sql = Sql + sNumoper
        
        If Not Bac_Sql_Execute("SP_BUSCACAPTACION", Envia) Then
            BuscaDatos = 1
            Exit Function
        End If

    Else
'        Sql = "SP_BUSCAINTERBANCARIO "
'        Sql = Sql + sNumoper
        
        If Not Bac_Sql_Execute("SP_BUSCAINTERBANCARIO", Envia) Then
            BuscaDatos = 1
            Exit Function
        End If

    End If

    Call LimpiaClase

    Do While Bac_SQL_Fetch(Datos())
        TipOper = Datos(1)
        If TipOper = "NO" Then
            MsgBox Datos(2), vbExclamation, gsBac_Version
            BuscaDatos = 1
            Call LimpiaClase
            Exit Function
        End If
        Fecini = Datos(2)
        Plazo = Datos(3)
        FecVen = Datos(4)
        Moneda = Datos(5)
        Base = Datos(6)
        valor = Val(Datos(7))
        MtoInicial = Val(Datos(8))
        Interes = Val(Datos(9))
        MtoFinal = Val(Datos(10))
        RutCar = Datos(11)
        DigVeri = Datos(12)
        NomCar = Datos(13)
        TipCar = Datos(14)
        Forpai = Datos(15)
        Forpav = Datos(16)
        Tipret = Datos(17)
        Tippag = Datos(18)
        RutCli = Datos(19)
        DigCli = Datos(20)
        NomCli = Datos(21)
        CodCli = Val(Datos(20))
        
        VAL_ALTAMIRA = ""
        If sTipOper = "CAP" Then
            VAL_ALTAMIRA = IIf(Val(Datos(22)) > 0, "SI", "NO")
        End If
        
    Loop

End Function

Public Sub LimpiaClase()

    TipOper = ""
    Fecini = ""
    Plazo = ""
    FecVen = ""
    Moneda = ""
    Base = ""
    valor = ""
    MtoInicial = ""
    Interes = ""
    MtoFinal = ""
    RutCar = ""
    DigVeri = ""
    NomCar = ""
    TipCar = ""
    Forpai = ""
    Forpav = ""
    Tipret = ""
    Tippag = ""
    RutCli = ""
    DigCli = ""
    NomCli = ""
    
End Sub


