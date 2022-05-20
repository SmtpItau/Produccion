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
Public clrut As Integer
Public clcodigo As Integer
Public cldatatec As String
Public clbolsa As String

Public clNomSinacofi As String
Public clNumSinacofi As Integer
Public objCliente As Object
Public coleccion As New Collection


Public Sub VaciarColeccion()

   Dim Filas&, Max&

   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 40
   Dim Max        As Long
   Dim Var$
   With objControl
      .Clear
      Max = coleccion.Count
      Var = "1"
      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).clnombre
         .AddItem IdGlosa
         .ItemData(.NewIndex) = coleccion(Filas).clrut
         Var = "2"
      Next Filas
   End With

End Sub
'Consulta clientes segun su tipo y son ordenados alfabeticamente y llena una colección
Public Function LeerClientes(IdNombre As String, Solo_Bancos As String) As Boolean
Dim Sql   As String
Dim IdRow As Integer
Dim Datos()
 
    LeerClientes = False
    Envia = Array()
    AddParam Envia, IdNombre
          
    If IdNombre <> "CASA MATRIZ TODAS" Then
          
      If Not BAC_SQL_EXECUTE("sp_clleernombres1", Envia) Then
         Exit Function
      End If
      
    Else
      
      AddParam Envia, 0
      If Not BAC_SQL_EXECUTE("Sp_Ayuda_Clientes", Envia) Then
         Exit Function
      End If
      
    End If
       
    Call VaciarColeccion
    Dim objBuf As New clsCliente
    Do While BAC_SQL_FETCH(Datos())
        
        If IdNombre <> "CASA MATRIZ TODAS" Then
        
            If (Solo_Bancos = "S" And Val(Datos(10)) = 1) Or Solo_Bancos = "N" Then
            
               With objBuf
                    .clrut = Datos(1)
                    .cldv = Datos(2)
                    .clcodigo = Datos(3)
                    .clnombre = Datos(4)
                    .clgeneric = Datos(5)
                    .cldirecc = Datos(6)
                    .clcomuna = Datos(7)
                    .clregion = Datos(8)
                    .clcompint = Datos(9)
                    .cltipcli = Datos(10)
                    .clfecingr = Datos(11)
                    .clctacte = Datos(12)
                    .clfono = Datos(13)
                    .clfax = Datos(14)
                    
                    
                End With
                coleccion.Add objBuf
                Set objBuf = Nothing
                
            End If
        
        Else
            
            With objBuf
               .clrut = Datos(4)
               .cldv = Datos(5)
               .clcodigo = Datos(2)
               .clnombre = Datos(3)
            End With
            coleccion.Add objBuf
            Set objBuf = Nothing
            
        End If
        
    Loop
    
    LeerClientes = True

End Function

Private Sub Class_Terminate()

   Set objCliente = Nothing
    
End Sub

Private Sub Class_Initialize()

    Set objCliente = New clsCliente
    
End Sub


Public Function BorrarSINACOFI() As Boolean

    BorrarSINACOFI = False
    Envia = Array()
    AddParam Envia, clrut
    
    If Not BAC_SQL_EXECUTE("sp_BorraSinacofiMDCL ", Envia) Then
        Exit Function
    End If

    BorrarSINACOFI = True

End Function

'Private Sub Limpiar()
'
'    emcodigo = 0
'    emrut = 0
'    emdv = ""
'    emnombre = ""
'    emgeneric = ""
'    emdirecc = ""
'    emcomuna = 0
'    emtipo = ""
'
'End Sub

