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
 

Function LeerPorGenerico(Generico As String)
Dim Sql As String
 
    LeerPorGenerico = False
    Envia = Array()
    AddParam Envia, Generico
    
    
    If Not Bac_Sql_Execute(Sql) Then
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


