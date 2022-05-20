VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMonedas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public objMoneda As Object
Public coleccion As New Collection


Public Sub Coleccion2Control(objControl As Object)
Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        'objControl.AddItem RELLENA_STRING(Coleccion(Filas).mncodmon, "L", 4) & Space(1) & RELLENA_STRING(Coleccion(Filas).mnnemo, "D", 4) & Space(1) & Coleccion(Filas).mndescrip'arregla
        objControl.AddItem RELLENA_STRING(coleccion(Filas).mncodmon, "L", 4) & Space(1) & RELLENA_STRING(coleccion(Filas).mnnemo, "D", 4) & Space(1) & coleccion(Filas).mnglosa
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).mncodmon
    Next Filas
          
End Sub

Public Sub ColeccionListView(objControl As ListView)
Dim Filas As Long
Dim Max   As Long

    Max = coleccion.Count
    
    With objControl
    
      .ColumnHeaders.Add 1, , "Codigo", 2000
      .ColumnHeaders.Add 2, , "Moneda", 2000
      .ColumnHeaders.Add 3, , "Nemotecnico", 2000
      
      For Filas = 1 To Max
           .ListItems.Add , , RELLENA_STRING(coleccion(Filas).mncodmon, "L", 4)
           .ListItems.Item(.ListItems.Count).ListSubItems.Add , , coleccion(Filas).mnglosa
           .ListItems.Item(.ListItems.Count).ListSubItems.Add , , coleccion(Filas).mnnemo
           
      Next Filas
          
    End With
          
End Sub


Public Sub Coleccion2Combo(objControl As Object)
Dim Filas As Long
Dim Max   As Long

    objControl.Clear
    Max = coleccion.Count
    For Filas = 1 To Max
        objControl.AddItem coleccion(Filas).mnnemo
        objControl.ItemData(objControl.NewIndex) = coleccion(Filas).mncodmon
    Next Filas
          
End Sub
Public Function LeerMonedas() As Boolean
 Dim Datos()
 LeerMonedas = False
 
 If auxilio = 100 Then
    
    If Not BAC_SQL_EXECUTE("sp_mnleetodo") Then
       
       Exit Function
    
    End If
 
 Else
    If auxilio = 120 Then
        If Not BAC_SQL_EXECUTE("sp_mnlee_extranjera") Then
            Exit Function
        End If
    Else
    
        If Not BAC_SQL_EXECUTE("sp_mnleetodo1 ") Then
            Exit Function
        End If
    End If
 
 End If
    
    Call VaciarColeccion
    
    
    Do While BAC_SQL_FETCH(Datos())
        
        Dim objBuf As New clsMoneda
        
        With objBuf
              
        .mncodmon = Datos(1)
        .mnnemo = Datos(2)
        .mnsimbol = Datos(3)
        .mnglosa = Datos(4)
        .mncodsuper = Val(Datos(5))
        .mnnemsuper = Datos(6)
        .mncodbanco = Datos(7)
        .mnnembanco = Datos(8)
        .mnbase = Val(Datos(9))
        .mnredondeo = Val(Datos(10))
        .mndecimal = Datos(11)
'        .mncodpais = Datos(12)
        .mnrrda = Datos(12)
        .mnfactor = Datos(13)
        .mnrefusd = Datos(14)
        .mnlocal = Datos(15)
        .mnextranj = Datos(16)
        .mnvalor = Datos(17)
        .MNREFMERC = Datos(18)
'        .MNINGVAL = Datos(20)
        .mntipmon = Datos(19)
        .mnperiodo = Val(Datos(20))
        .mnmx = Datos(21)
        .mnCodfox = Datos(22)
        .mnvalfox = Datos(23)
        .mncodcor = Datos(24)
        .codigo_pais = Datos(25)
'        .mniso_coddes = Datos(28)
            
            
        End With
        coleccion.Add objBuf
        Set objBuf = Nothing
    Loop
    
    LeerMonedas = True

End Function


Public Sub VaciarColeccion()
Dim Filas   As Long
Dim Max     As Long
          
    Max = coleccion.Count
    For Filas = 1 To Max
        coleccion.Remove 1
    Next Filas
          
End Sub
 

Private Sub Class_Initialize()

    Set objMoneda = New clsMoneda
     
End Sub


Private Sub Class_Terminate()
        
    Set objMoneda = Nothing
        
End Sub

Public Sub Coleccion2Control2(itipmda As Integer, objControl As Object)

   Dim Filas      As Long
   Dim Max        As Long
   Dim bCargar    As Boolean

   With objControl

      .Clear

      Max = coleccion.Count

      For Filas = 1 To Max
         
        ' bCargar = False
         
        ' Select Case itipmda
         'Case 1 And coleccion(Filas).mnextranj = "0":      bCargar = True
        ' Case 2 And coleccion(Filas).mnextranj = "1":    bCargar = True
        ' Case 3 And coleccion(Filas).mnvalor = "1":      bCargar = True
        ' Case 4 And coleccion(Filas).mnrefmerc = "1":    bCargar = True
        ' Case 5:
'         Case 6 And coleccion(Filas).mnextranj = "0" And coleccion(Filas).mntipval <> "4":
         bCargar = True
        ' End Select

         If bCargar Then
            .AddItem coleccion(Filas).mnglosa
            .ItemData(.NewIndex) = coleccion(Filas).mncodigo

         End If

      Next Filas

  End With

End Sub

