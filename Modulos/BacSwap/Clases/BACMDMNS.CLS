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

Dim Sql$, Datos(), i&, iMax&

Public objMoneda As Object
Public coleccion As New Collection
Public mnvalor As Double
'Trae datos de una moneda
Public Function LeerSQL(codigo%, glosa$, Nemo$, Simbol$, TipoMoneda$) As Boolean
'Dim objBuffer As Object

   LeerSQL = False

   Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
   Sql = Sql & "sp_Leer_Moneda " & codigo
   Sql = Sql & ",'" & glosa & "'"
   Sql = Sql & ",'" & Nemo & "'"
   Sql = Sql & ",'" & Simbol & "'"
   Sql = Sql & ",'" & TipoMoneda & "'"

   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If

   Call VaciarColeccion
   
   Do While SQL_Fetch(Datos()) = 0
   
        'Set objBuffer = New clsMoneda
        objMoneda.Limpiar
        
        objMoneda.mncodigo = Val(Datos(1))
        objMoneda.mnnemo = Datos(2)
        objMoneda.mnsimbol = Datos(3)
        objMoneda.mnglosa = Datos(4)
        objMoneda.mncodsuper = Datos(5)
        objMoneda.mnnemsuper = Datos(6)
        objMoneda.mncodbanco = Val(Datos(7))
        objMoneda.mnnembanco = Datos(8)
        objMoneda.mnbase = Val(Datos(9))
        objMoneda.mnredondeo = Val(Datos(10))
        objMoneda.mndecimal = Val(Datos(11))
        objMoneda.mncodpais = Val(Datos(12))
        objMoneda.mnrrda = Datos(13)
        objMoneda.mnfactor = Val(Datos(14))
        objMoneda.mnrefusd = Datos(15)
        objMoneda.mnlocal = Datos(16)
        objMoneda.mnextranj = Datos(17)
        objMoneda.mnvalor = Datos(18)
        objMoneda.mnrefmerc = Datos(19)
        objMoneda.mningval = Val(Datos(20))
        objMoneda.mntipmon = Datos(21)
        objMoneda.mnperiodo = Val(Datos(22))
        objMoneda.mnmx = Datos(23)
        
        coleccion.Add objMoneda
        
        'Set objBuffer = Nothing
      
        LeerSQL = True

    Loop

End Function
'---- Retorna dato segun codigo de Moneda
Public Function BuscarMoneda(iCodMda As Integer, iRetorna As Integer) As String

   iMax = coleccion.Count

   BuscarMoneda = ""
   
   For i = 1 To iMax

      If coleccion(i).mncodigo = iCodMda Then

         Select Case iRetorna
         Case 1: BuscarMoneda = coleccion(i).mnglosa
         Case 2: BuscarMoneda = coleccion(i).mnnemo
         Case 3: BuscarMoneda = coleccion(i).mnfactor
         Case 4: BuscarMoneda = coleccion(i).mnredondeo
         Case 5: BuscarMoneda = coleccion(i).mncodbanco
         Case 6: BuscarMoneda = coleccion(i).mncodsuper
         Case 7: BuscarMoneda = coleccion(i).mnbase
         Case 8: BuscarMoneda = coleccion(i).mnrefusd
         Case 9: BuscarMoneda = coleccion(i).mnlocal
         Case 9: BuscarMoneda = coleccion(i).mnextranj
         Case 11: BuscarMoneda = coleccion(i).mnvalor
         Case 10: BuscarMoneda = coleccion(i).mnrefmerc
         Case 11: BuscarMoneda = coleccion(i).mntipval
         End Select

         Exit Function
      
      End If

   Next i

End Function
'---- Carga List/Combo
Public Sub CargaObjecto(TipoCarga%, objControl As Object)
Dim bCargar As Boolean

    objControl.Clear
    
    iMax = coleccion.Count
    
    For i = 1 To iMax
       
       bCargar = False
       
       Select Case TipoCarga
       Case 1 And coleccion(i).mnextranj = "0": bCargar = True  '-- Monedas Locales
       Case 2 And coleccion(i).mnextranj = "1": bCargar = True  '-- Monedas Estranjeras
       Case 3 And coleccion(i).mnvalor = "1": bCargar = True    '-- Valuta a un dia
       Case 4 And coleccion(i).mnrefmerc = "1": bCargar = True  '-- Referencia US$ (1=Fuerte)
       Case 5:
       Case 6 And coleccion(i).mnextranj = "0" And coleccion(i).mntipval <> "4": bCargar = True
       End Select
    
       If bCargar Then
          objControl.AddItem coleccion(i).mnglosa
          objControl.ItemData(objControl.NewIndex) = coleccion(i).mncodigo
       End If
    
    Next i

End Sub

Public Sub VaciarColeccion()

   Dim Filas   As Long
   Dim Max     As Long
          
   Max = coleccion.Count
   For Filas = 1 To Max
      coleccion.Remove 1
      
   Next Filas
          
End Sub

Public Function ValorMoneda(codigo%, fecha$, Optional ValorDefault) As Double

   ValorMoneda = 0#
   If VarType(ValorDefault) <> vbNull Then
       ValorMoneda = ValorDefault
   End If

   Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
   Sql = Sql & "sp_Leer_ValorMoneda " & codigo
   Sql = Sql & ",'" & Format(fecha, "yyyymmdd") & "'"

   If SQL_Execute(Sql) > 0 Then
      Exit Function
   End If

   If SQL_Fetch(Datos()) = 0 Then
        ValorMoneda = 0
   End If
   
End Function

Public Function CargaPorProducto(iProd%, obj As Object) As Boolean

    CargaPorProducto = False

    Sql = "EXECUTE " & giSQL_DatabaseCommon & ".."
    Sql = Sql & "sp_Leer_MonedaProducto " & iProd & ", 0"
    
    If SQL_Execute(Sql) > 0 Then
       Exit Function
    End If
    
    obj.Clear
    
    Do While SQL_Fetch(Datos()) = 0
         obj.AddItem Datos(4)
         obj.ItemData(obj.NewIndex) = Val(Datos(3))
         CargaPorProducto = True
    Loop

End Function

Private Sub Class_Initialize()

   Set objMoneda = New clsMoneda
     
End Sub

Private Sub Class_Terminate()
        
   Set objMoneda = Nothing
        
End Sub
