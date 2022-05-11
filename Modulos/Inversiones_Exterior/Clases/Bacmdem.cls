VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEmisor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

 'MDEM : TABLA DE EMISORES
 '-----------------------------------------------
 Public emcodigo   As Currency 'numeric 10,0
 Public emrut      As Long     'numeric  9,0
 Public emdv       As String
 Public emnombre   As String
 Public emgeneric  As String
 Public emdirecc   As String
 Public emcomuna   As String
 Public emregion   As String
 Public emciudad   As String
 Public emtipo     As String
  
 




Public Function Eliminar(oRut As Long) As Boolean

    Eliminar = False
    
'    Sql = "SP_EMELIMINAR " & emrut

    envia = Array(CDbl(emrut))
    
    If Not Bac_Sql_Execute("[BacTraderSuda].[dbo].SP_EMELIMINAR", envia) Then
       Exit Function
    End If
    
    Call Limpiar
    Eliminar = True
    
End Function



Public Function Grabar() As Boolean

    Grabar = False
'    Sql = "SP_EMGRABAR "
'    Sql = Sql & emcodigo & ","
'    Sql = Sql & emrut & ","
'    Sql = Sql & "'" & emdv & "',"
'    Sql = Sql & "'" & emnombre & "',"
'    Sql = Sql & "'" & emgeneric & "',"
'    Sql = Sql & "'" & emdirecc & "',"
'    Sql = Sql & emcomuna & ","
'    Sql = Sql & "'" & emtipo & "'"
    
    envia = Array(CDbl(emcodigo), _
            CDbl(emrut), _
            emdv, _
            emnombre, _
            emgeneric, _
            emdirecc, _
            CDbl(emcomuna), _
            emtipo)
            
    If Not Bac_Sql_Execute("SP_EMGRABAR", envia) Then
        Exit Function
    End If
    
    Call Limpiar
    Grabar = True
    
End Function


Function LeerPorGenerico(Generico As String)
 
    LeerPorGenerico = False
    
'    Sql = "SP_EMLEERGEN '" & Generico & "'"

    envia = Array(Generico)
    
    If Not Bac_Sql_Execute("[BacTraderSuda].[dbo].SP_EMLEERGEN", envia) Then
       Exit Function
    End If
    
    Call Limpiar
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        emcodigo = Val(Datos(1))
        emrut = Val(Datos(2))
        emdv = Datos(3)
        emnombre = Datos(4)
        emgeneric = Datos(5)
        emdirecc = Datos(6)
        emcomuna = Val(Datos(7))
        emtipo = Datos(8)
    End If
    
    LeerPorGenerico = True
    
End Function

Public Function LeerPorRut(eRut As Long, cOrigen As String) As Boolean
Dim cEntra As Boolean

    LeerPorRut = False
    
'    Sql = "SP_EMLEERRUT " & eRut

    envia = Array(CDbl(eRut))
    
    If Not Bac_Sql_Execute("[BacTraderSuda].[dbo].SP_EMLEERRUT", envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
        cEntra = False
        If cOrigen = "O" And Val(Datos(8)) = 2 Then
            cEntra = True
        ElseIf cOrigen = "T" Then
            cEntra = True
        End If
            
        If cEntra Then
            emcodigo = Val(Datos(1))
            emrut = Val(Datos(2))
            emdv = Datos(3)
            emnombre = Datos(4)
            emgeneric = Datos(5)
            emdirecc = Datos(6)
            emcomuna = Val(Datos(7))
            emtipo = Datos(8)
        End If
    End If
    LeerPorRut = True
    
End Function




Private Sub Limpiar()
     
    emcodigo = 0
    emrut = 0
    emdv = ""
    emnombre = ""
    emgeneric = ""
    emdirecc = ""
    emcomuna = 0
    emtipo = ""

End Sub

Private Sub Class_Initialize()

    Call Limpiar
    
End Sub


