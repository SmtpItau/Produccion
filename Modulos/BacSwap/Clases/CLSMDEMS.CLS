VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsEmisores"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public Sub ClearEmi()

Dim Filas As Long
          
    For Filas = 1 To TabEmi.Count
        TabEmi.Remove 1
    Next Filas
          
End Sub
Public Function LeerNombres(IdNombre As String) As Boolean
Dim SQL   As String
Dim IdRow As Integer
Dim Datos()
 

    LeerNombres = False
      
    IdRow = sm_Execute("Set RowCount 50")
    
        
    SQL = "Exec sp_EMLeerNombres " & "'" & IdNombre & "'"
          
    If sm_Execute(SQL) <> 0 Then
       Exit Function
    End If
       
    Call Limpiar
    Call ClearEmi
    
    Do While sm_Fetch(Datos()) = 0
       Dim oEmi As New clsEmisores
           emrut = Val(Datos(1))
           emdv = Datos(2)
           emnombre = Datos(3)
           emgeneric = Datos(4)
           emdirecc = Datos(5)
           emcomuna = Datos(6)
           emtipo = Datos(7)
           oEmi.emrut = emrut
           oEmi.emdv = emdv
           oEmi.emnombre = emnombre
           TabEmi.Add oEmi
        Set oEmi = Nothing
    Loop
    
    Call Limpiar
    
    IdRow = sm_Execute("Set RowCount 0")

    LeerNombres = True

End Function


Public Sub Emi2List(oControl As Object)

Dim Filas   As Long
Dim IdGlosa As String * 40
          
    oControl.Clear
    For Filas = 1 To TabEmi.Count
        IdGlosa = TabEmi(Filas).emnombre
        oControl.AddItem IdGlosa
        oControl.ItemData(oControl.NewIndex) = TabEmi(Filas).emrut
    Next Filas
    
End Sub



