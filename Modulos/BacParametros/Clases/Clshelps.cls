VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHelpges"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Dim Filas&, Max&
Public objcodmov    As Object
Public objcodmov1   As Object
Public coleccion    As New Collection
Public codescri     As String
Public CodTipos     As String
Public codmov       As String
Public CodNum       As String
Public CodOrden     As String
Public COD2756      As String
Public CodAfecta    As String
Public CodMovch     As String
Public CodNumC      As String
Public CodCta       As String
Public Function leemonedcambio(IdNombre As String)
Dim sql$, mens1$, Mens2$, Mens3$
Dim IdRow%
Dim Datos()
Dim objBuffer     As Object

   
    leemonedcambio = False
    'idtipo = 15
    Select Case idtipo
    Case 0       ' MTB04
        sql = "sp_leepl "
        Envia = Array()
        AddParam Envia, IdNombre
    
    Case 1       ' mevm
        sql = "sp_monedas "
        Envia = Array()
            
    Case 2       'metb02 glosa para los tipo de operaciones
        sql = "sp_leem2 "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 3       'meofi ayuda de Oficinas"
        sql = "sp_leeof "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 4  'mecla
        sql = "sp_leego "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 5  'metbo3  pAISES
        sql = "sp_leepa "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 6  'metbo1
        sql = "sp_leefa "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 7  'mepp Rentabilidades
        sql = "sp_leeac "
        Envia = Array()
    
    Case 8  'mevr Posiciones de Rentabilidad
        sql = "sp_LeeRentabilidad"
        Envia = Array()
        AddParam Envia, "1"
    
    Case 9  'mdlog
        'If BacFiltrosConsul.optConsulta(0).Value = True Then
'            Sql = "1"
'            mens1 = "Ayuda loggers(usua.)"
'        ElseIf BacFiltrosConsul.optConsulta(1).Value = True Then
'            mens1 = "Ayuda loggers(even.)"
'            Sql = "2"
'        ElseIf BacFiltrosConsul.optConsulta(2).Value = True Then
'            mens1 = "Ayuda loggers(fech.)"
'            Sql = "3"
'        End If
'
'        Sql = "exec sp_bulog " & "'" & Sql & "'"
'
    Case 10  'meus usuarios
        sql = " sp_luser"
        Envia = Array()
    
    Case 11  'metb05 código de comercio
        sql = " sp_lcodcomercio "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 12  'mecc código de corresponsal
        sql = " sp_lcodcorresp "
        Envia = Array()
        AddParam Envia, IdNombre
    
    
    Case 13  'tbCodigosComercio
        sql = "sp_Leer_Codigos_Comercio"
        Envia = Array()
        AddParam Envia, ""
        AddParam Envia, ""
    
    Case 14  'tbCodigosComercio relacionados
        sql = "sp_Leer_Codigos_Comercio"
        Envia = Array()
        AddParam Envia, gsCodigo
        If Val(gsDigito) > 0 Then
            AddParam Envia, gsDigito
        End If
    
    Case 15  'tbCodigosOMA
        sql = "sp_tbcodigo_oma"
        Envia = Array()
        
    
    Case 16  'tbCodigosComercio segun tbPlanillaOperacion
        sql = "sp_tbplanillaoperacion"
        Envia = Array()
        AddParam Envia, gsCodigo
        AddParam Envia, gsDigito
    
    Case 17  'tbCodigosComercio segun tbPlanillaOperacion
        sql = "sp_tbomadelsuda"
        Envia = Array()
            
    
    Case 100 'tbAyudaPlanilla
        sql = "SP_TBAYUDAPLANILLA"
        Envia = Array()
        
    End Select
   
    If Not Bac_Sql_Execute(sql, Envia) Then
        Exit Function
    End If
        
    '---- Carga Coleccion
    Call VaciarColeccion

    Do While Bac_SQL_Fetch(Datos())

        Set objBuffer = New ClsHelp

        With objBuffer
                .codescri = Trim(Datos(2))
                Select Case idtipo
                Case 0, 3
                        If idtipo = 0 Then
                            .CodOrden = Datos(3)
                            .CodMovch = CDbl(Val(Datos(4)))
                        End If
                        .codmov = CDbl(Val(Datos(1)))
                        
                Case 1
                        .codmov = Datos(1)
                        .CodMovch = CDbl(Val(Datos(3)))
                        
                Case 2
                        .CodMovch = CDbl(Val(Datos(1)))
                        .CodOrden = Datos(3)
                        .CodNum = Datos(4)
                        
                Case 4, 11
                        If IsNumeric(Datos(3)) Then
                            .codmov = CDbl(Val(Datos(3)))
                        Else
                            .codmov = Datos(3)
                        End If
                        .CodOrden = Datos(4)
                        .CodMovch = CDbl(Val(Datos(1)))
                        If IsNumeric(Datos(5)) Then
                            .COD2756 = CDbl(Val(Datos(5)))
                        Else
                            .COD2756 = Datos(5)
                        End If
                        
                        .codescri = Datos(2)
                        
                Case 5
                        .codmov = CDbl(Val(Datos(1)))
                        .CodOrden = Datos(3)
                        
                Case 6
                        .CodTipos = Datos(5)
                        .codmov = CDbl(Val(Datos(1)))
                        .CodNum = CDbl(Val(Datos(4)))
                        .CodOrden = Datos(3)
                        .COD2756 = Datos(6)
                        .CodAfecta = Datos(7)
                        .CodMovch = CDbl(Val(Datos(8)))
                        .CodNumC = Datos(9)
                        .CodCta = Datos(10)
                        
                Case 7
                        .CodOrden = Datos(3)
                        .CodMovch = CDbl(Val(Datos(1)))
                        
                Case 8
                        .codmov = CDbl(Val(Datos(1)))
                        
                Case 9, 10
                        .codmov = Datos(1)
                        
                Case 12
                        .codmov = Datos(1)
                
                Case 13, 14
                        .codmov = Datos(2)          '-- comercio
                        .CodCta = Datos(3)          '-- concepto
                        .codescri = Datos(4)        '-- glosa
                        .CodNum = Datos(5)          '-- tipo documento
                        .CodOrden = Val(Datos(6))   '-- codigo oma
                        
                Case 15, 100
                        .codmov = Val(Datos(1))
                        .CodCta = Datos(2)
                        .codescri = Datos(3)
                        
                Case 16
                        .codmov = Val(Datos(1))
                        .CodCta = Datos(2)
                        .codescri = Datos(3)
                        .codescri = Datos(4)
                        .codescri = Datos(5)
                        
                Case 17
                        .codmov = Val(Datos(1))
                        '.codescri = Datos(2) & " " & Datos(3)
                        .codescri = Datos(1) & Space(4 - Len(Datos(1))) & Datos(2) & Space(45 - Len(Datos(2))) & Datos(3) 'pp
                        
                End Select
                
        End With
        
        If idtipo <> 100 Or InStr(",11,14,", "," & objBuffer.codmov & ",") = 0 Then
            coleccion.Add objBuffer
        End If
        
        Set objBuffer = Nothing
        
    Loop
   
    leemonedcambio = True

End Function




Public Function leemoned(IdNombre As String)
   Dim sql$, mens1$, Mens2$, Mens3$, IdRow%, Datos()
   Dim objBuffer     As Object
   
   leemoned = False
   Envia = Array()
   AddParam Envia, IdNombre
   
 
   If Not Bac_Sql_Execute("SP_LEEFA ", Envia) Then Exit Function
        
      Call VaciarColeccion

   Do While Bac_SQL_Fetch(Datos())
      Dim objBuffer1 As New clsHelpges

      Set objBuffer1 = New clsHelpges

      With objBuffer1
      
             .codescri = Trim(Datos(2))
             .CodTipos = Datos(5)
             .codmov = CDbl(Val(Datos(1)))
             .CodNum = CDbl(Val(Datos(4)))
             .CodOrden = Datos(3)
             .COD2756 = Datos(6)
             .CodAfecta = Datos(7)
             .CodMovch = CDbl(Val(Datos(8)))
             .CodNumC = Datos(9)
             .CodCta = Datos(10)
             
      End With

      coleccion.Add objBuffer1

      Set objBuffer1 = Nothing

   Loop
   
    leemoned = True

End Function

Private Sub Class_Initialize()
   
   'Set objcodmov = New clsHelpges 'LEO

End Sub

Private Sub Class_Terminate()

   Set objcodmov = Nothing
    
End Sub
Public Sub Coleccion2Control(objControl As Object)

   Dim IdGlosa    As String * 40
   Dim IDNOMBRECLIENTE As String * 50
   
   With objControl
      .Clear
      Max = coleccion.Count
      
      For Filas = 1 To Max
         IdGlosa = coleccion(Filas).codescri
         IDNOMBRECLIENTE = coleccion(Filas).CodOrden
         .AddItem IdGlosa & Space(2) & IDNOMBRECLIENTE
        .ItemData(.NewIndex) = coleccion(Filas).CodMovch
      Next Filas

   End With

End Sub
Public Sub VaciarColeccion()
   Max& = coleccion.Count
   For Filas& = 1 To Max&
      coleccion.Remove 1

   Next Filas&

End Sub

