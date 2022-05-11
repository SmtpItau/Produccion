VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEmisores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objEmisor As Object
Public Coleccion As New Collection

Public Sub VaciarColeccion()
Dim FILAS&, Max&
          
    Max& = Coleccion.Count
    For FILAS& = 1 To Max&
        Coleccion.Remove 1
    Next FILAS&
          
End Sub
Public Function LeerEmisores(IdNombre As String, cOrigen As String) As Boolean
Dim Datos()
Dim cEntra As Boolean

    LeerEmisores = False
'    Sql = "SP_EMLEERNOMBRES '" & IdNombre & "'"

    Envia = Array(IdNombre)
          
    If Not Bac_Sql_Execute("SP_EMLEERNOMBRES", Envia) Then
        Exit Function
    End If
       
    'Elimino todos los miembros de la colección
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsEmisor
        With objBuf
        
            cEntra = False
            
            If cOrigen = "O" And Val(Datos(8)) = 2 Then
                cEntra = True
            ElseIf cOrigen = "T" Then
                cEntra = True
            End If
            
            If cEntra Then
                .emcodigo = Val(Datos(1))
                .emrut = Val(Datos(2))
                .emdv = Datos(3)
                .emnombre = Datos(4)
                .emgeneric = Datos(5)
                .emdirecc = Datos(6)
                .emcomuna = Datos(7)
                .emtipo = Datos(8)
            End If
        End With
        If cEntra Then
            Coleccion.Add objBuf
            Set objBuf = Nothing
        End If
    Loop
    
    LeerEmisores = True

End Function
Public Function LeerEmisoresFM(IdNombre As String, cOrigen As String) As Boolean
Dim Datos()
Dim cEntra As Boolean

    LeerEmisoresFM = False
'    Sql = "SP_EMLEERNOMBRES '" & IdNombre & "'"

    Envia = Array(IdNombre)
          
    If Not Bac_Sql_Execute("SP_EMLEERNOMBRESFM", Envia) Then
        Exit Function
    End If
       
    'Elimino todos los miembros de la colección
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuf As New clsEmisor
        With objBuf
        
            cEntra = False
            
            If cOrigen = "O" And Val(Datos(8)) = 2 Then
                cEntra = True
            ElseIf cOrigen = "T" Then
                cEntra = True
            End If
            
            If cEntra Then
                .emcodigo = Val(Datos(1))
                .emrut = Val(Datos(2))
                .emdv = Datos(3)
                .emnombre = Datos(4)
                .emgeneric = Datos(5)
                .emdirecc = Datos(6)
                .emcomuna = Datos(7)
                .emtipo = Datos(8)
            End If
        End With
        If cEntra Then
            Coleccion.Add objBuf
            Set objBuf = Nothing
        End If
    Loop
    
    LeerEmisoresFM = True

End Function


Public Sub Coleccion2Control(objControl As Object)
Dim FILAS   As Long
Dim IDGLOSA As String * 40
Dim Max     As Long
          
    objControl.Clear
    Max& = Coleccion.Count
    For FILAS = 1 To Max&
        IDGLOSA = Coleccion(FILAS).emnombre
        objControl.AddItem IDGLOSA
        objControl.ItemData(objControl.NewIndex) = Coleccion(FILAS).emrut
    Next FILAS
    
End Sub



Private Sub Class_Initialize()

    Set objEmisor = New clsEmisor
    
End Sub


Private Sub Class_Terminate()

    Set objEmisor = Nothing
    
End Sub


