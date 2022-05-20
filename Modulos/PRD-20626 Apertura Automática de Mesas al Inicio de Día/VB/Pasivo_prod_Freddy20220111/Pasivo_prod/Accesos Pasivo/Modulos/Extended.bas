Attribute VB_Name = "Extended"

         '--------------------------------------------------------------'
         '                                                              '
         '     FUNCIONES PARA EL CAMBIO DE CONFIGURACION REGIONAL       '
         '                                                              '
         '                 SQL-SERVER V/S BAC-CONTROLES                 '
         '                                                              '
         '                                                              '
         '     CREADO POR  : CRISTIAN LABARCA ROJAS                     '
         '     FECHA       : 21/MARZO/2001                              '
         '                                                              '
         '--------------------------------------------------------------'

Global Configuracion As String
Global Envia() As Variant
Global Envia_Parametros() As Variant

Public Sub AddParam(ByRef Arreglo As Variant, Parametro As Variant)
   
   On Error GoTo errorcuenta:
   
   Cuenta = UBound(Arreglo) + 1
   ReDim Preserve Arreglo(Cuenta)
   Arreglo(Cuenta) = Parametro
   
   Exit Sub

errorcuenta:
   
   Cuenta = 1
   Resume Next

End Sub




Function ClearStoreProcPararm()
   Dim I As Integer
   For I = 0 To 20
       Menu_Principal.REPORT.StoredProcParam(I) = ""
       Menu_Principal.REPORT.Formulas(I) = ""
   Next I
   
   'By Cristián Labarca Rojas 28/Mayo/2001.-
   
   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   
   Menu_Principal.REPORT.WindowState = crptNormal
   Menu_Principal.REPORT.WindowBorderStyle = crptFixedDouble
   Menu_Principal.REPORT.WindowControlBox = True
   Menu_Principal.REPORT.WindowControls = True
   Menu_Principal.REPORT.WindowTop = 40
   Menu_Principal.REPORT.WindowLeft = 0
   Menu_Principal.REPORT.WindowHeight = Screen.Height / Screen.TwipsPerPixelX - 95
   Menu_Principal.REPORT.WindowWidth = Screen.Width / Screen.TwipsPerPixelY + 1
   Menu_Principal.REPORT.Connect = swConeccion
   
   ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
   
End Function


Function IsFecha(xFecha As Variant) As Boolean
Dim I, J       As Variant
Dim Fecha1     As Variant
Dim Fecha2     As Variant
Dim Separador  As Integer
Dim Separador2 As Integer
Dim Separador3 As Integer
Dim Separador4 As Integer
      
      
      IsFecha = False
            
      xFecha = Trim(xFecha)
            
      If IsDate(xFecha) Then
            
            Fecha1 = Replace(xFecha, "-", "/")
            Fecha2 = CStr(Replace(CDate(xFecha), "-", "/"))
            
            Separador = InStr(1, Fecha1, "/")
            Separador3 = InStr(1, Fecha2, "/")
            
            If Separador = 0 Or Separador3 = 0 Then Exit Function
            
            If Separador + 1 > 0 And Separador < Len(Fecha1) Then
            
               Separador2 = InStr(Separador + 1, Fecha1, "/")
               Separador4 = InStr(Separador3 + 1, Fecha2, "/")
                  
               If Separador2 = 0 Or Separador4 = 0 Then Exit Function
                  
               If Separador2 = Separador4 And Separador = Separador3 Then
                  
                  IsFecha = True
                  
               End If
                  
            End If
      
      End If

End Function



