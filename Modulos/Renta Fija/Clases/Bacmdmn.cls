VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMoneda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'MDMN : TABLA DE MONEDAS
'-----------------------------------------------
Public mncodmon   As Integer  'numeric  3,0
Public mnnemo     As String
Public mnsimbol   As String
Public mndescrip  As String
Public mnredondeo As Integer  'numeric  1,0
Public mnbase     As Integer  'numeric  3,0
Public mntipmon   As String
Public mnperiodo  As Integer  'numeric  2,0
Public mncodsuper As Integer  'numeric  3,0
Public Function Eliminar(CodMon As Integer) As Boolean
    
    Eliminar = False
    
'    Sql = "SP_MNELIMINAR " & CodMon

    Envia = Array(CDbl(CodMon))
        
    If Not Bac_Sql_Execute("SP_MNELIMINAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Eliminar = True
    
End Function









Public Function Grabar() As Boolean

    Grabar = False
    
'    Sql = "SP_MNGRABAR "
'    Sql = Sql & mncodmon & ","
'    Sql = Sql & "'" & mnnemo & "',"
'    Sql = Sql & "'" & mnsimbol & "',"
'    Sql = Sql & "'" & mndescrip & "',"
'    Sql = Sql & mnredondeo & ","
'    Sql = Sql & mnbase & ","
'    Sql = Sql & "'" & mntipmon & "',"
'    Sql = Sql & mnperiodo & ","
'    Sql = Sql & mncodsuper
    
    Envia = Array(CDbl(mncodmon), _
            mnnemo, _
            mnsimbol, _
            mndescrip, _
            CDbl(mnredondeo), _
            CDbl(mnbase), _
            mntipmon, _
            CDbl(mnperiodo), _
            CDbl(mncodsuper))
    
    If Not Bac_Sql_Execute("SP_MNGRABAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
    
End Function






Public Function LeerPorCodigo(CodMon As Integer) As Boolean
    
    LeerPorCodigo = False
    
'    Sql = "SP_MNLEER " & CodMon
    
    Envia = Array(CDbl(CodMon))
    
    If Not Bac_Sql_Execute("SP_MNLEER", Envia) Then
       Exit Function
    End If

    Call Limpiar
    
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        mncodmon = Val(Datos(1))
        mnnemo = Datos(2)
        mnsimbol = Datos(3)
        mndescrip = Datos(4)
        mnredondeo = Val(Datos(5))
        mnbase = Val(Datos(6))
        mntipmon = Datos(7)
        mnperiodo = Val(Datos(8))
        mncodsuper = Val(Datos(9))
    End If
       
    LeerPorCodigo = True
    
End Function



Public Sub Limpiar()
    
    mncodmon = 0
    mnnemo = ""
    mnsimbol = ""
    mndescrip = ""
    mnredondeo = 0
    mnbase = 0
    mntipmon = ""
    mnperiodo = 0
    mncodsuper = 0
   
End Sub


