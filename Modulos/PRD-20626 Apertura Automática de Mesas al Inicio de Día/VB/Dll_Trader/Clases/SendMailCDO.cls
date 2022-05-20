VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SendMailCDO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private Declare Function InternetGetConnectedState Lib "wininet.dll" (ByRef lpdwFlags As Long, ByVal dwReserved As Long) As Long

Private Const INTERNET_CONNECTION_MODEM_BUSY    As Long = &H8
Private Const INTERNET_RAS_INSTALLED            As Long = &H10
Private Const INTERNET_CONNECTION_OFFLINE       As Long = &H20
Private Const INTERNET_CONNECTION_CONFIGURED    As Long = &H40

Private mServidor               As String
Private mPara                   As String
Private mDe                     As String
Private mAsunto                 As String
Private mMensaje                As String
Private mAdjunto                As String
Private mAdjunto2               As String
Private mPuerto                 As Variant
Private mUsuario                As String
Private mPassword               As String
Private mUseAuntentificacion    As Boolean
Private mSSL                    As Boolean

Public Event Error(Descripcion As String, Numero As Variant)
Public Event EnvioCompleto()

Function Enviar_Correo() As Boolean
    
    Dim oCDO As Object
          
    If InternetGetConnectedState(0&, 0&) = False Then
       RaiseEvent Error("No se puede enviar el correo. " & "Verificar la conexión a internet si está disponible", 0)
       Exit Function
    End If
    
    If Not IsNumeric(puerto) Then
       RaiseEvent Error("No se ha indicado el puerto del servidor", 0)
       Exit Function
    End If
    
    Set oCDO = CreateObject("CDO.Message")
    
    Let oCDO.Configuration.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = mServidor
    Let oCDO.Configuration.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = mPuerto
    Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/" & "configuration/smtpauthenticate") = Abs(mUseAuntentificacion)
    Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 10
    
    If mUseAuntentificacion Then
        Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = mUsuario
        Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = mPassword
        Let oCDO.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = mSSL
    End If
    
    Let oCDO.To = mPara                 ' Dirección del Destinatario
    Let oCDO.From = mDe                 ' Dirección del remitente
    Let oCDO.Subject = mAsunto          ' Asunto del mensaje
    Let oCDO.TextBody = mMensaje        ' Cuerpo del mensaje

    'Ruta del archivo adjunto
    If mAdjunto <> "" Then
        If Len(Dir(mAdjunto)) = 0 Then
            RaiseEvent Error("No se ha encontrado el archivo en la siguiente ruta: ", 0)
            Exit Function
        Else
            Call oCDO.AddAttachment(mAdjunto)
        End If
    End If

    If mAdjunto2 <> "" Then
        If Len(Dir(mAdjunto2)) = 0 Then
            RaiseEvent Error("No se ha encontrado el archivo en la siguiente ruta: ", 0)
            Exit Function
        Else
            Call oCDO.AddAttachment(mAdjunto2)
        End If
    End If
    
    Call oCDO.Configuration.Fields.Update
    
    On Error Resume Next
        oCDO.Send
        Screen.MousePointer = vbDefault
    
        If Err.Number = 0 Then
           Enviar_Correo = True
           RaiseEvent EnvioCompleto
        ElseIf Err.Number = -2147220973 Then
           RaiseEvent Error("Posible error : nombre del Servidor " & "incorrecto o número de puerto incorrecto", Err.Number)
        ElseIf Err.Number = -2147220975 Then
           RaiseEvent Error("Posible error : error en la el nombre de usuario, " & "o en el password ", Err.Number)
        Else
           RaiseEvent Error(Err.Description, Err.Number)
        End If

        If Not oCDO Is Nothing Then
            Set oCDO = Nothing
        End If
        Err.Clear
    On Error GoTo 0
    
    Screen.MousePointer = vbNormal
End Function

' propiedades
'''''''''''''''''''''
Property Get servidor() As String
    servidor = mServidor
End Property
Property Let servidor(value As String)
    mServidor = value
End Property

Property Get Para() As String
    Para = mPara
End Property
Property Let Para(value As String)
    mPara = value
End Property

Property Get de() As String
    de = mDe
End Property
Property Let de(value As String)
    mDe = value
End Property

Property Get Asunto() As String
    Asunto = mAsunto
End Property
Property Let Asunto(value As String)
    mAsunto = value
End Property

Property Get Mensaje() As String
    Mensaje = mMensaje
End Property
Property Let Mensaje(value As String)
    mMensaje = value
End Property

Property Get Adjunto() As String
    Adjunto = mAdjunto
End Property
Property Let Adjunto(value As String)
    mAdjunto = value
End Property

Property Get Adjunto2() As String
    Adjunto2 = mAdjunto2
End Property
Property Let Adjunto2(value As String)
    mAdjunto2 = value
End Property

Property Get puerto() As Variant
    puerto = mPuerto
End Property
Property Let puerto(value As Variant)
    mPuerto = value
End Property

Property Get Usuario() As String
    Usuario = mUsuario
End Property
Property Let Usuario(value As String)
    mUsuario = value
End Property

Property Get PassWord() As String
    PassWord = mPassword
End Property
Property Let PassWord(value As String)
    mPassword = value
End Property

Property Get UseAuntentificacion() As Boolean
    UseAuntentificacion = mUseAuntentificacion
End Property
Property Let UseAuntentificacion(value As Boolean)
    mUseAuntentificacion = value
End Property

Property Get ssl() As Boolean
    ssl = mSSL
End Property
Property Let ssl(value As Boolean)
    mSSL = value
End Property



