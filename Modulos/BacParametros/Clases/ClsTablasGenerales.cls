VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCodigos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public codigo    As Integer
Public glosa     As String
Public objTabCod As Object
Public coleccion As New Collection
Sub Agregar(codigo As String, glosa As String)

   Dim objBuffer As Object

   Set objBuffer = New clsCodigo
   
   With objBuffer
      .codigo = codigo
      .glosa = glosa
   
   End With
   
   coleccion.Add objBuffer
   
   Set objBuffer = Nothing

End Sub

Public Function grabar(CodTab As Integer) As Integer

   Dim Fila As Long
   Dim Sql  As String

   grabar = False

   'Inicia una Transacción
  ' If MISQL.SQL_EXECUTE("BEGIN TRANSACTION") > 0 Then
  '    Grabar = 1
  '    Exit Function

   'End If

   'Elimina todos los items para una tabla
   
   'Sql = giSQL_DatabaseCommon
   Envia = Array()
   AddParam Envia, CodTab

   If Not Bac_Sql_Execute("SP_BORRAR_TC ", Envia) Then
  '    If MISQL.SQL_EXECUTE("ROLLBACK TRANSACTION") > 0 Then
  '       Grabar = 2
  '       Exit Function

  '    End If
  
  
      Exit Function
   End If
    
   'Graba todos los elementos o miembros de la colección
  
      If Grabar_TablasGenerales(CodTab) = True Then
             grabar = True
             
       End If
      
       
  

   'Grabar = True

End Function

'Lee todos los codigos de una Tabla
Public Function LeerCodigos(ByVal ncodtab As Integer) As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim DATOS()

   LeerCodigos = False

    Envia = Array()
    AddParam Envia, ncodtab
    
    
   If Not Bac_Sql_Execute("SP_LEER_TC ", Envia) Then
      Exit Function
   End If

   Call VaciarColeccion

   Do While Bac_SQL_Fetch(DATOS())

      Set objBuffer = New clsCodigo

      With objBuffer
         .codigo = Val(DATOS(2))
         .glosa = Trim$(DATOS(3))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerCodigos = True

End Function

Public Sub VaciarColeccion()

   Dim Filas As Long
   Dim Max   As Long

   Max = coleccion.Count
   For Filas = 1 To Max
      coleccion.Remove 1

   Next Filas

End Sub

Public Sub Coleccion2Control(objControl As Object)

   Dim Filas      As Long
   Dim IdGlosa    As String * 25
   Dim Max        As Long

   With objControl

      .Clear 'borra los datos del combo
      Max = coleccion.Count

      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).glosa
         .AddItem IdGlosa
         .ItemData(objControl.NewIndex) = coleccion(Filas).codigo

      Next Filas

   End With

End Sub

Public Sub coleccion2grilla(objControl As Object)

   Dim Filas   As Long
   Dim Max     As Long

   With objControl

      .Rows = 1

      Max = coleccion.Count

      For Filas = 1 To Max
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .Text = Mid$(coleccion(Filas).glosa, 126, 3)
         .Col = 2: .Text = Mid$(coleccion(Filas).glosa, 1, 25)

      Next Filas

   End With

End Sub

'Lee las tablas fijas del sistema
Public Function LeerTablas() As Boolean

   Dim Sql           As String
   Dim objBuffer     As Object
   Dim DATOS()

   LeerTablas = False
    
    
    'Sql = giSQL_DatabaseCommon
    
    
   If Not Bac_Sql_Execute("SP_LEER_TB ") Then
      Exit Function
   End If
          
   Call VaciarColeccion
             
   Do While Bac_SQL_Fetch(DATOS())
      Set objBuffer = New clsCodigos
      
      With objBuffer
         .codigo = Val(DATOS(1))
         .glosa = Trim$(DATOS(2))

      End With

      coleccion.Add objBuffer

      Set objBuffer = Nothing

   Loop

   LeerTablas = True

End Function

Public Function grabarTC(iTabla%, iCodigo%, sGlosa$) As Boolean
    
    'Sql = giSQL_DatabaseCommon
    Envia = Array()
    AddParam Envia, iTabla
    AddParam Envia, iCodigo
    AddParam Envia, sGlosa
    AddParam Envia, Sistema     '---- PENDIENTE chequear, debe ser 'PCS'
    
    grabarTC = (Bac_Sql_Execute("SP_GRABAR_TC ", Envia))
    
    If Bac_SQL_Fetch(DATOS()) Then
        If Val(DATOS(1)) < 0 Then
            grabarTC = False
            MsgBox DATOS(2), vbInformation, TITSISTEMA
        End If
    End If

End Function

Public Function Grabar_TablasGenerales(CodTab As Integer) As Boolean

Dim Sql  As String
Dim Fila%
  
    Grabar_TablasGenerales = False
    
    For Fila = 1 To coleccion.Count
    
         
         'Sql = giSQL_DatabaseCommon
         Envia = Array()
         AddParam Envia, CodTab
         AddParam Envia, coleccion(Fila).codigo
         AddParam Envia, coleccion(Fila).glosa
         AddParam Envia, Sistema
        
 
            If Not Bac_Sql_Execute("SP_GRABAR_TC ", Envia) Then
                Exit Function
            End If
 
    Next Fila
 
     Grabar_TablasGenerales = True

End Function





