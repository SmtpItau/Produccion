Attribute VB_Name = "Privilegios"
Option Explicit

Private Type oPrivilegios
   Instituciones_Financieras  As Integer
   Otras_Instituciones        As Integer
   Impresion_Papeletas        As Integer
   Monitoreo_Operaciones      As Integer
   Liberacion_Operaciones     As Integer
End Type
Global objPrivilegios         As oPrivilegios

Public Function ACTUALIZADOR(ByVal xUsuario As String)
   Dim Datos()
   
   If xUsuario = "ADMINISTRA" Then
      Let objPrivilegios.Instituciones_Financieras = 1
      Let objPrivilegios.Otras_Instituciones = 1
      Let objPrivilegios.Impresion_Papeletas = 1
      Let objPrivilegios.Monitoreo_Operaciones = 1
      Let objPrivilegios.Liberacion_Operaciones = 1
      Exit Function
   End If
   
   Let objPrivilegios.Instituciones_Financieras = 0
   Let objPrivilegios.Otras_Instituciones = 0
   Let objPrivilegios.Impresion_Papeletas = 0
   Let objPrivilegios.Monitoreo_Operaciones = 0
   Let objPrivilegios.Liberacion_Operaciones = 0

   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, xUsuario
   AddParam Envia, ""
   If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
      Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Let objPrivilegios.Instituciones_Financieras = Datos(1)
      Let objPrivilegios.Otras_Instituciones = Datos(2)
      Let objPrivilegios.Impresion_Papeletas = Datos(3)
      Let objPrivilegios.Monitoreo_Operaciones = Datos(4)
      Let objPrivilegios.Liberacion_Operaciones = Datos(5)
   End If
End Function

Public Function CARGAR_SISTEMAS_HABILITADOS(ByVal xUsuario As String, ByRef Objeto As ComboBox, ByVal OptCarga As Integer)
   Dim Datos()
   
   If xUsuario = "ADMINISTRA" Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, xUsuario
   AddParam Envia, ""
   If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
      Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
      Exit Function
   End If

   Call Objeto.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      If OptCarga = 0 Then
         Call Objeto.AddItem(Datos(2) + Space(70) + "CODIGO" + Space(5) + Datos(1))
      Else
         Call Objeto.AddItem(Datos(2) & Space(100) & Datos(1))
      End If
   Loop

   If Objeto.ListCount > 0 Then
      Call Objeto.AddItem(" << TODOS >> " + Space(70) + "CODIGO" + Space(5) + "")
      Let Objeto.ListIndex = -1
      Let Objeto.Text = " << TODOS >> " + Space(70) + "CODIGO" + Space(5) + ""
   Else
      If OptCarga = 0 Then
         Call Objeto.AddItem("<< NINGUNO >>" + Space(70) + "CODIGO" + Space(5) + "-")
      Else
         Call Objeto.AddItem("<< NINGUNO >>" & Space(100) & "")
      End If
      Let Objeto.ListIndex = 0
   End If
   
End Function

Public Function CARGAR_PRODUCTOS_HABILITADOS(ByVal xUsuario As String, ByVal xModulo As String, ByRef Objeto As ComboBox, ByVal OptCarga As Integer)
   Dim Datos()
   
   If xUsuario = "ADMINISTRA" Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, xUsuario
   AddParam Envia, xModulo
   If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
      Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
      Exit Function
   End If

   Call Objeto.Clear
   Call Objeto.AddItem(" << TODOS >> " + Space(100) & "")

   Do While Bac_SQL_Fetch(Datos())
      Call Objeto.AddItem(Datos(2) & Space(100) & Datos(1))
   Loop
End Function

Public Function CHEQUEA_PRODUCTOS(ByVal xUsuario As String, ByVal xModulo As String, xProducto As String) As Boolean
   Dim Datos()

   Let CHEQUEA_PRODUCTOS = False
   
   If xUsuario = "ADMINISTRA" Then
      Let CHEQUEA_PRODUCTOS = True
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, xUsuario
   AddParam Envia, xModulo
   If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
      Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = xProducto Then
         Let CHEQUEA_PRODUCTOS = True
         Exit Function
      End If
   Loop
   
End Function

Public Function CHEQUEA_MODULOS(ByVal xUsuario As String, ByVal xModulo As String) As Boolean
   Dim Datos()
   Dim cSist As String      'PRD8800
   
   Let CHEQUEA_MODULOS = False

   If xModulo = "" Then
      Let CHEQUEA_MODULOS = True
      Exit Function
   End If

   If xUsuario = "ADMINISTRA" Then
      Let CHEQUEA_MODULOS = True
      Exit Function
   End If
'PRD8800
  If xModulo = "DRV" Then

   Envia = Array()
        AddParam Envia, xModulo
        If Not Bac_Sql_Execute("DBO.SP_BUSCA_SISTEMA_DRV", Envia) Then
             Call MsgBox("Se ha producido un error al tratar de buscar sistema de grupo Derivados.", vbExclamation, App.Title)
             Exit Function
        End If
        'Cargar en Un Arreglo todos los Sistemas del Grupo
        Dim SistemasDRV() As String
        Dim iSis2 As Integer
        Dim iSis As Integer
        
        Let iSis = 0
        Do While Bac_SQL_Fetch(DATOS())
            ReDim Preserve SistemasDRV(iSis)
            SistemasDRV(iSis) = DATOS(1)  'Toma uno de los sistemas del Grupo DRV
            Let iSis = iSis + 1
        Loop
        Let iSis = iSis - 1
        Envia = Array()
        AddParam Envia, CDbl(2)
        AddParam Envia, xUsuario
        AddParam Envia, ""
        If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
           Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
           Exit Function
        End If
        
        Let CHEQUEA_MODULOS = False
        Do While Bac_SQL_Fetch(DATOS())
            Let iSis2 = 0
            For iSis2 = 0 To iSis
              If DATOS(1) = SistemasDRV(iSis2) Then
                   Let CHEQUEA_MODULOS = True
                   Exit Function
              End If
            Next iSis2
        Loop
      
    Else
        'PRD8800
           Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, xUsuario
   AddParam Envia, ""
   If Not Bac_Sql_Execute("SP_ADMINISTRACION_PERFIL", Envia) Then
      Call MsgBox("Se ha producido un error al tratar de leer privilegios.", vbExclamation, App.Title)
      Exit Function
   End If

   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) = xModulo Then
         Let CHEQUEA_MODULOS = True
         Exit Function
      End If
   Loop
        
    End If
    
End Function

