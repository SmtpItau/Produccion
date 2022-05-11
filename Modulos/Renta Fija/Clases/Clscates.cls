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
Dim FILAS&, Max&

Public ctCategoria    As Integer
Public ctDescripcion  As String
Public ctICod         As String
Public ctITasa        As String
Public ctIFecha       As String
Public ctIValor       As String
Public ctIGlosa       As String

Public objcodmov As Object
Public objcodmov1 As Object
Public Coleccion As New Collection
Public Codigo As String
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
Dim mens1$, Mens2$, Mens3$, IdRow%, Datos()
Dim objBuffer     As Object
   
   leeCategoria = False
         
'   Sql = "SP_LEECA " & IdCategoria
 
    Envia = Array(CDbl(IdCategoria))
    
    If Not Bac_Sql_Execute("SP_LEECA", Envia) Then
        Exit Function
    End If
    
    Call VaciarColeccion
    
    Do While Bac_SQL_Fetch(Datos())
        Dim objBuffer1 As New clsCategorias

        Set objBuffer1 = New clsCategorias

        With objBuffer1
            .Codigo = Val(Datos(1))
            .Descri = Trim(Datos(2))
        End With

        Coleccion.Add objBuffer1

        Set objBuffer1 = Nothing
    Loop
   
    leeCategoria = True

End Function

Private Sub Class_Initialize()
   
'   Set objcodmov = New clsHelpges
    Call Limpiar
End Sub

Private Sub Class_Terminate()

'   Set objcodmov = Nothing
    
End Sub


Public Sub Coleccion2Control(objControl As Object)

   Dim IdDescrip    As String
   With objControl
      .Clear
      Max = Coleccion.Count
      
      For FILAS = 1 To Max
         IdDescrip = Coleccion(FILAS).Descri
         .AddItem IdDescrip
         .ItemData(.NewIndex) = Coleccion(FILAS).Codigo
      Next FILAS

   End With

End Sub
Public Sub VaciarColeccion()
   Max& = Coleccion.Count
   For FILAS& = 1 To Max&
      Coleccion.Remove 1

   Next FILAS&

End Sub

Public Function Eliminar(ctCod As Integer) As Boolean
    
    Eliminar = False
    
'    Sql = "SP_CTELIMINAR " & ctCod

    Envia = Array(CDbl(ctCod))
     
    If Not Bac_Sql_Execute("SP_CTELIMINAR", Envia) Then
        Exit Function
    End If
    
    Call Limpiar
    
    Eliminar = True
    
End Function


Public Function LeerPorCateg(Codcat As Integer) As Boolean
Dim Datos()

    LeerPorCateg = False

'   Sql = "SP_MDCTLEERCAT " & Codcat
    
    Envia = Array(CDbl(Codcat))
       
    If Not Bac_Sql_Execute("SP_MDCTLEERCAT", Envia) Then
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


Public Function Grabar() As Boolean
     
    Grabar = False
    
'    Sql = "SP_CTGRABAR " & Chr(10)
'    Sql = Sql & ctCategoria & "," & Chr(10)                 'Número de Categoría
'    Sql = Sql & "'" & Trim(ctDescripcion) & "'," & Chr(10)  'Descripción de Categoría
'    Sql = Sql & "'" & Trim(ctICod) & "'," & Chr(10)         'Indicador de Código
'    Sql = Sql & "'" & Trim(ctITasa) & "'," & Chr(10)        'Indicador de Tasa
'    Sql = Sql & "'" & Trim(ctIFecha) & "'," & Chr(10)       'Indicador de Fecha
'    Sql = Sql & "'" & Trim(ctIValor) & "'," & Chr(10)       'Indicador de Valor
'    Sql = Sql & "'" & Trim(ctIGlosa) & "'" & Chr(10)       'Indicador de Glosa
    
    Envia = Array(CDbl(ctCategoria), _
            Trim(ctDescripcion), _
            Trim(ctICod), _
            Trim(ctITasa), _
            Trim(ctIFecha), _
            Trim(ctIValor), _
            Trim(ctIGlosa))
    
    If Not Bac_Sql_Execute("SP_CTGRABAR", Envia) Then
        Exit Function
    End If
    
    Grabar = True
    
End Function
