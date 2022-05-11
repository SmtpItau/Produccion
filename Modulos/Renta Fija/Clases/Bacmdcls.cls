VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public ObjCliente As Object
Public Coleccion As New Collection

Public Sub VaciarColeccion()
Dim FILAS&, Max&
          
    Max& = Coleccion.Count
    For FILAS& = 1 To Max&
        Coleccion.Remove 1
    Next FILAS&
          
End Sub

Public Sub Coleccion2Control(objControl As Object)
Dim FILAS   As Long
Dim IDGLOSA As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max = Coleccion.Count
    For FILAS = 1 To Max
        IDGLOSA = Coleccion(FILAS).clnombre
        objControl.AddItem IDGLOSA
        objControl.ItemData(objControl.NewIndex) = Coleccion(FILAS).clrut
    Next FILAS
    
End Sub
Public Function LeerClientes(IdNombre As String, Solo_Bancos As String) As Boolean
Dim IdRow As Integer
Dim Datos()
 
    LeerClientes = False
'    Sql = "SP_CLLEERNOMBRES1 '" & IdNombre & "'"

        Envia = Array(IdNombre)
        AddParam Envia, Solo_Bancos
          
    If Not Bac_Sql_Execute("SP_CLLEERNOMBRES1", Envia) Then
        Exit Function
    End If
       
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsCliente
        
        If (Solo_Bancos = "S" And Val(Datos(10)) <= 2) Or Solo_Bancos = "N" Then
        
            With objBuf
                .clrut = Val(Datos(1))
                .cldv = Datos(2)
                .clcodigo = Val(Datos(3))
                .clnombre = Datos(4)
                .clgeneric = Datos(5)
                .cldirecc = Datos(6)
                .clcomuna = Val(Datos(7))
                .clregion = Val(Datos(8))
                .clcompint = Val(Datos(9))
                .cltipcli = Val(Datos(10))
                .clfecingr = Datos(11)
                .clctacte = Datos(12)
                .clfono = Datos(13)
                .clfax = Datos(14)
            End With
            Coleccion.Add objBuf
            Set objBuf = Nothing
            
        End If
        
    Loop
    
    LeerClientes = True

End Function


Public Function LeerGenericos(IdNombre As String) As Boolean
Dim IdRow   As Integer
Dim Datos()
 
    LeerGenericos = False
    IdRow = 0
'    Sql = "SP_CLLEERGENERICOS '" & IdNombre & "'"
    Envia = Array(CDbl(IIf(IdNombre <> "", IdNombre, 0)))
          
    If Not Bac_Sql_Execute("SP_CLLEERGENERICOS", Envia) Then
       Exit Function
    End If
       
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsCliente
        With objBuf
            .clrut = Val(Datos(1))
            .cldv = Datos(2)
            .clcodigo = Val(Datos(3))
            .clnombre = Datos(4)
            .clgeneric = Datos(5)
            .cldirecc = Datos(6)
            .clcomuna = Val(Datos(7))
            .clregion = Val(Datos(8))
            .clcompint = Val(Datos(9))
            .cltipcli = Val(Datos(10))
            .clfecingr = Datos(11)
            .clctacte = Datos(12)
            .clfono = Datos(13)
            .clfax = Datos(14)
        End With
        IdRow = 1

        Coleccion.Add objBuf
        Set objBuf = Nothing
      
    Loop
    
    If IdRow = 0 Then
        Call LeerClientes("", "N")
    End If
    LeerGenericos = True

End Function





Private Sub Class_Initialize()

    Set ObjCliente = New clsCliente
    
End Sub


Private Sub Class_Terminate()

    Set ObjCliente = Nothing
    
End Sub


