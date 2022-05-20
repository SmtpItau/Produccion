VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsWinIp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private Const MAX_WSADescription = 256
Private Const MAX_WSASYSStatus = 128
Private Const ERROR_SUCCESS As Long = 0
Private Const WS_VERSION_REQD As Long = &H101
Private Const WS_VERSION_MAJOR As Long = WS_VERSION_REQD \ &H100 And &HFF&
Private Const WS_VERSION_MINOR As Long = WS_VERSION_REQD And &HFF&
Private Const MIN_SOCKETS_REQD As Long = 1
Private Const SOCKET_ERROR As Long = -1

Private Type HOSTENT
    hName               As Long
    hAliases            As Long
    hAddrType           As Integer
    hLen                As Integer
    hAddrList           As Long
End Type

Private Type WSADATA
    wVersion            As Integer
    wHighVersion        As Integer
    wMaxSockets         As Integer
    wMaxUDPDG           As Integer
    dwVendorInfo        As Long
    szDescription(0 To MAX_WSADescription) As Byte
    szSystemStatus(0 To MAX_WSASYSStatus) As Byte
End Type

Private Declare Function WSAGetLastError Lib "WSOCK32.DLL" () As Long
Private Declare Function WSAStartup Lib "WSOCK32.DLL" (ByVal wVersionRequired As Long, lpWSADATA As WSADATA) As Long
Private Declare Function WSACleanup Lib "WSOCK32.DLL" () As Long
Private Declare Function gethostname Lib "WSOCK32.DLL" (ByVal szHost As String, ByVal dwHostLen As Long) As Long
Private Declare Function gethostbyname Lib "WSOCK32.DLL" (ByVal szHost As String) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, ByVal hpvSource As Long, ByVal cbCopy As Long)

Property Get DirWinIp() As String
    DirWinIp = GetIPAddress
End Property

Private Function HiByte(ByVal wParam As Integer)
    HiByte = wParam \ &H100 And &HFF&
End Function

Private Function LoByte(ByVal wParam As Integer)
    LoByte = wParam And &HFF&
End Function

Private Function SocketsInitialize() As Boolean
    Dim WSAD        As WSADATA
    Dim sLoByte     As String
    Dim sHiByte     As String

    If WSAStartup(WS_VERSION_REQD, WSAD) <> ERROR_SUCCESS Then
        MsgBox "The 32-bit Windows Socket is not responding."
        SocketsInitialize = False
        Exit Function
    End If
    
    If WSAD.wMaxSockets < MIN_SOCKETS_REQD Then
        MsgBox "This application requires a minimum of " & " CStr(MIN_SOCKETS_REQD) & ` supported sockets."
        SocketsInitialize = False
        Exit Function
    End If

    If LoByte(WSAD.wVersion) < WS_VERSION_MAJOR Or (LoByte(WSAD.wVersion) = WS_VERSION_MAJOR And HiByte(WSAD.wVersion) < WS_VERSION_MINOR) Then
        sHiByte = CStr(HiByte(WSAD.wVersion))
        sLoByte = CStr(LoByte(WSAD.wVersion))
        MsgBox "Sockets version " & sLoByte & "." & sHiByte & " is not supported by 32-bit Windows Sockets."
        SocketsInitialize = False
        Exit Function
    End If
    
    SocketsInitialize = True
End Function

Private Sub SocketsCleanup()
    If WSACleanup() <> ERROR_SUCCESS Then
        MsgBox "Socket error occurred in Cleanup."
    End If
End Sub

Private Function GetIPAddress() As String
    Dim sHostName       As String * 256
    Dim lpHost          As Long
    Dim HOST            As HOSTENT
    Dim dwIPAddr        As Long
    Dim tmpIPAddr()     As Byte
    Dim i               As Integer
    Dim sIPAddr         As String

    If Not SocketsInitialize() Then
        Let GetIPAddress = ""
        Exit Function
    End If

    If gethostname(sHostName, 256) = SOCKET_ERROR Then
        Let GetIPAddress = ""
       'MsgBox "Windows Sockets error " & Str$(WSAGetLastError()) & " has occurred. Unable to successfully get Host Name."
        Call SocketsCleanup
        Exit Function
    End If

    sHostName = Trim$(sHostName)
    lpHost = gethostbyname(sHostName)

    If lpHost = 0 Then
        Let GetIPAddress = ""
       'MsgBox "Windows Sockets are not responding. " & "Unable to successfully get Host Name."
        Call SocketsCleanup
        Exit Function
    End If

    Call CopyMemory(HOST, lpHost, Len(HOST))
    Call CopyMemory(dwIPAddr, HOST.hAddrList, 4)
    
    ReDim tmpIPAddr(1 To HOST.hLen)
    Call CopyMemory(tmpIPAddr(1), dwIPAddr, HOST.hLen)
    
    For i = 1 To HOST.hLen
        sIPAddr = sIPAddr & tmpIPAddr(i) & "."
    Next

    GetIPAddress = Mid$(sIPAddr, 1, Len(sIPAddr) - 1)

    Call SocketsCleanup
End Function


