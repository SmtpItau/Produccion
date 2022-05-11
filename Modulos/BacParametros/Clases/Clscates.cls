VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCategorias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim Filas&, Max&
Public ctcateg As Integer
Public ctdescrip As String
Public ctindcod As String
Public ctindtasa As String
Public ctindfech As String
Public ctindvalor As String
Public ctindglosa As String
Public tbSistema As String
Public tbcodtab As Integer
Public tbglosa As String
Public tbtipmnt As String
Public ctCategoria    As Integer
Public ctDescripcion  As String
Public ctICod         As String
Public ctITasa        As String
Public ctIFecha       As String
Public ctIValor       As String
Public ctIGlosa       As String

Public objcodmov As Object
Public objcodmov1 As Object
Public coleccion As New Collection
Public codigo As String
Public Descri As String

Private Sub Limpiar()
    ctCategoria = 0
    ctDescripcion = ""
    ctICod = ""
    ctITasa = ""
    ctIFecha = ""
    ctIValor = ""
    ctIGlosa = ""
End Sub

'FUNCIÓN QUE LEE TODAS LAS CATEGORÍAS DE
'LA TABLA MDTB
'---------------------------------------------------------------
Public Function leeCategoria(IdCategoria As Integer)
   Dim Sql$, mens1$, Mens2$, Mens3$, IdRow%, Datos()
   Dim objBuffer     As Object
   
   leeCategoria = False
     
   Envia = Array()
   AddParam Envia, IdCategoria
 
         
   If Not Bac_Sql_Execute("SP_LEECA ", Envia) Then Exit Function
        
      Call VaciarColeccion

   Do While Bac_SQL_Fetch(Datos())
      Dim objBuffer1 As New clsCategorias

      Set objBuffer1 = New clsCategorias

      With objBuffer1
             .codigo = Val(Datos(1))
             .Descri = Trim(Datos(2))
      End With

      coleccion.Add objBuffer1

      Set objBuffer1 = Nothing

   Loop
   
    leeCategoria = True

End Function

Private Sub Class_Initialize()
   
'   Set objcodmov = New clsHelpges
    Call Limpiar
End Sub

Private Sub Class_Terminate()

   'Set objcodmov = Nothing
    
End Sub


Public Sub Coleccion2Control(objControl As Object)

   Dim IdDescrip    As String
   With objControl
      .Clear
      Max = coleccion.Count
      
      For Filas = 1 To Max
         IdDescrip = coleccion(Filas).Descri
         .AddItem IdDescrip
         .ItemData(.NewIndex) = coleccion(Filas).codigo
      Next Filas

   End With

End Sub
Public Sub VaciarColeccion()
   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

Public Function Eliminar(ctCod As Integer) As Boolean
Dim Sql As String
    
    Eliminar = False
    Envia = Array()
    AddParam Envia, ctCod
     
    If Not Bac_Sql_Execute("SP_CTELIMINAR ", Envia) Then
       Exit Function
    End If
    
    Call Limpiar
    
    Eliminar = True
    
End Function


Public Function LeerPorCateg(Codcat As Integer) As Boolean


   LeerPorCateg = False
   Dim Sql As String
   Dim Datos()
   Envia = Array()
   AddParam Envia, Codcat
       
   If Not Bac_Sql_Execute("SP_BUSCA_CATE ", Envia) Then
      Exit Function
   End If
       
   Call Limpiar
    
   If Bac_SQL_Fetch(Datos()) Then
      ctCategoria = Val(Datos(1))
      ctDescripcion = Trim(Datos(2))
      ctICod = Datos(3)
      ctITasa = Datos(4)
      ctIFecha = Datos(5)
      ctIValor = Datos(6)
      ctIGlosa = Datos(7)
   End If
    
   LeerPorCateg = True
 
End Function


Public Function grabar() As Boolean
Dim Sql As String
     
    grabar = False
    Envia = Array()
    AddParam Envia, ctCategoria
    AddParam Envia, Trim(ctDescripcion)
    AddParam Envia, Trim(ctICod)
    AddParam Envia, Trim(ctITasa)
    AddParam Envia, Trim(ctIFecha)
    AddParam Envia, Trim(ctIValor)
    AddParam Envia, Trim(ctIGlosa)
    
    If Not Bac_Sql_Execute("SP_CTGRABAR ", Envia) Then
       Exit Function
    End If
    
    'Call Limpiar
    
    grabar = True
End Function
