VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCreaUsuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Public objGeneral As Object
Public coleccion  As New Collection


'BacGeneral : TABLA DE PARAMETROS GENERALES
'-----------------------------------------------
Public Entidad          As String
Public codigo           As String
Public nombre           As String
Public Rut              As Long
Public direccion        As String
Public comuna           As String
Public Ciudad           As String
Public telefono         As String
Public fax              As String
Public Numero_Operacion As Long
Public rutbcch          As String
Public iniciodia        As Integer
Public libor            As Integer
Public paridad          As Integer
Public tasamtm          As Integer
Public tasas            As Integer
Public findia           As Integer
Public cierreMesa       As String
Public FechaAnt
Public fechaproc
Public fechaprox
Public DolarObs         As Double
Public ValorUF          As Double

' ---------------------- Copiados del modulo de clase:  ClsCreaUsuarios -------------------------

'Option Explicit

Public objCreaUsuarios  As Object
Public Usuario          As String
Public Tipo_Us          As String
Public TipoClave        As String
Public LargoClave       As Integer
Public DiasExp          As Double
Public DescTipUs        As String
Public TipoClaveUs      As String
Public Clave1           As String
Public Clave2           As String
Public Clave3           As String
Public Clave           As String

Dim Datos()


Function Busca_Tipo_Usuario(xTipoUs As String) As Boolean

   Call Limpiar

   Envia = Array()

   AddParam Envia, "B"
   AddParam Envia, xTipoUs
   AddParam Envia, ""
   AddParam Envia, ""
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   
   Busca_Tipo_Usuario = BAC_SQL_EXECUTE("SP_GRABA_TIPOS_USUARIO", Envia)

   If Not Busca_Tipo_Usuario Then Exit Function
   
   If BAC_SQL_FETCH(Datos()) Then
      If Datos(1) = "NO ACTIVO" Then
        MsgBox Datos(2), vbInformation
        Busca_Tipo_Usuario = False
        Exit Function
      End If
      DescTipUs = Datos(1)
      TipoClave = Datos(3)
      LargoClave = Datos(4)
      DiasExp = Datos(5)
   
   End If

End Function

Sub Limpiar()

   Usuario = ""
   Tipo_Us = ""
   'TipoClave = ""
   'LargoClave = 0
   'DiasExp = 0
   DescTipUs = ""

End Sub

Function CompruebaPWD(xTipoUs As String, Key As Integer) As Boolean
Dim I       As Integer
Dim Cadena  As String

   'Busca_Tipo_Usuario xTipoUs

CompruebaPWD = True

If Key <> 13 And Key <> 8 And Key <> 27 Then


   CompruebaPWD = False

   Select Case TipoClave

      Case "A"
      
               'If (UCase(Chr(Key)) >= "A" And UCase(Chr(Key)) <= "Z") Or IsNumeric(Chr(Key)) = True Then
               
                  CompruebaPWD = True
                  
               'End If
      
      Case "C"
      
               If (UCase(Chr(Key)) >= "A" And UCase(Chr(Key)) <= "Z") Then
               
                  CompruebaPWD = True
                  
               End If
      
      Case "N"
      
               CompruebaPWD = IsNumeric(Chr(Key))
      
   End Select

End If


End Function


Function DevuelvTipoCUs(xUsuario As String) As Boolean

   Envia = Array()
   AddParam Envia, xUsuario
   DevuelvTipoCUs = True
   
   If BAC_SQL_EXECUTE("Sp_TipoClave_Cliente", Envia) Then
   
      If BAC_SQL_FETCH(Datos()) Then
      
         TipoClaveUs = Datos(1)
         
         If TipoClaveUs <> "" Then
         
            TipoClave = TipoClaveUs
            LargoClave = Datos(2)
            DiasExp = Datos(3)
            
            
            'Exit Function
         
         End If
         
      
      End If
   
   End If

End Function


Function DevuelveClaves(xUsuario As String) As Boolean

   DevuelveClaves = True
   Envia = Array()
   AddParam Envia, xUsuario
   
   If BAC_SQL_EXECUTE("Sp_Acceso_ClavesAnteriores", Envia) Then
   
      If BAC_SQL_FETCH(Datos()) Then
      
         Clave1 = Datos(1)
         Clave2 = Datos(2)
         Clave3 = Datos(3)
         Clave = Datos(4)
      
      End If
      
   Else
      
      DevuelveClaves = False
      
   End If
   

End Function

