VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsTabMon"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public TabMon    As New Collection
Public TabMoneda As New clsMoneda

Public Function LeerMonedas(oCodMon As Integer) As Boolean

Dim SQL As String
    
    LeerMonedas = False
    
    SQL = SQL & "Exec Sp_MnLeer " & oCodMon
    
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If

    LimpiarMonedas
    Dim Datos()
    If sm_Fetch(Datos()) = 0 Then
       TabMoneda.mncodmon = Val(Datos(1))
       TabMoneda.mnnemo = Datos(2)
       TabMoneda.mnsimbol = Datos(3)
       TabMoneda.mnredondeo = Val(Datos(4))
       TabMoneda.mnbase = Val(Datos(5))
       TabMoneda.mntipmon = Datos(6)
       TabMoneda.mntipmnt = Datos(7)
       TabMoneda.mndescrip = Datos(8)
       TabMoneda.mnperiodo = Val(Datos(9))
    End If
    
   LeerMonedas = True
    
End Function


Public Sub LimpiarMonedas()
    
    TabMoneda.mncodmon = 0
    TabMoneda.mnnemo = ""
    TabMoneda.mnsimbol = ""
    TabMoneda.mnredondeo = 0
    TabMoneda.mnbase = 0
    TabMoneda.mntipmon = ""
    TabMoneda.mntipmnt = ""
    TabMoneda.mndescrip = ""
    TabMoneda.mnperiodo = 0

End Sub


Public Function GrabarMonedas() As Boolean
Dim SQL As String

    GrabarMonedas = False
    
    SQL = "Exec Sp_MnGrabar "
    SQL = SQL & TabMoneda.mncodmon & ","
    SQL = SQL & "'" & TabMoneda.mnnemo & "',"
    SQL = SQL & "'" & TabMoneda.mnsimbol & "',"
    SQL = SQL & TabMoneda.mnredondeo & ","
    SQL = SQL & TabMoneda.mnbase & ","
    SQL = SQL & "'" & TabMoneda.mntipmon & "',"
    SQL = SQL & "'" & TabMoneda.mntipmnt & "',"
    SQL = SQL & "'" & TabMoneda.mndescrip & "',"
    SQL = SQL & TabMoneda.mnperiodo
    
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If
    
    GrabarMonedas = True
    
End Function

Public Function EliminarMonedas(oCodMon As Integer) As Boolean
Dim SQL As String
    
    EliminarMonedas = False
    
    SQL = SQL & "Exec Sp_MnEliminar " & oCodMon
    
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If

    EliminarMonedas = True
    
End Function




Public Sub Tab2List(oControl As Object)

Dim Filas As Long
          
    oControl.Clear
    
    For Filas = 1 To TabMon.Count
        oControl.AddItem TabMon(Filas).mndescrip
        oControl.ItemData(oControl.NewIndex) = TabMon(Filas).mncodmon
    Next Filas
          
End Sub

Public Function LeeTodo() As Boolean
Dim SQL As String

       LeeTodo = False
       
       SQL = "Exec Sp_MnLeeTodo "
       
       If sm_Execute(SQL) <> 0 Then
          Exit Function
       End If
       
       TabMonClear
       
       Dim Datos()
       Do While sm_Fetch(Datos()) = 0
          Dim oCodigo As New clsMoneda
              oCodigo.mncodmon = Val(Datos(1))
              oCodigo.mnnemo = Datos(2)
              oCodigo.mnsimbol = Datos(3)
              oCodigo.mnredondeo = Val(Datos(4))
              oCodigo.mnbase = Val(Datos(5))
              oCodigo.mntipmon = Datos(6)
              oCodigo.mntipmnt = Datos(7)
              oCodigo.mndescrip = Datos(8)
              oCodigo.mnperiodo = Val(Datos(9))
              TabMon.Add oCodigo
          Set oCodigo = Nothing
       Loop

       LeeTodo = True
       
End Function


Public Sub TabMonClear()
Dim Filas As Long
          
          For Filas = 1 To TabMon.Count
                   TabMon.Remove 1
          Next Filas
          
End Sub
 

Private Sub Class_Initialize()

End Sub


