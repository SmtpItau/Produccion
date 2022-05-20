VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsFamilia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public incodigo   As Integer 'NUMERIC  (03,0) NULL ,
Public inserie    As String  'CHAR     (12)   NULL ,
Public inglosa    As String  'CHAR     (40)   NULL ,
Public inrutemi   As Long    'NUMERIC  (09,0) NULL ,
Public inmonemi   As Integer 'NUMERIC  (03,0) NULL ,
Public inbasemi   As Integer 'NUMERIC  (03,0) NULL ,
Public inprog     As String  'CHAR     (08)   NULL ,
Public inrefnomi  As String  'CHAR     (01)   NULL ,
Public inmdse     As String  'CHAR     (01)   NULL ,
Public inmdtd     As String  'CHAR     (01)   NULL ,
Public inmdpr     As String  'CHAR     (01)   NULL ,
Public intipfec   As Integer 'NUMERIC  (01,0) NULL ,
Public intasest   As Integer 'NUMERIC  (03,0) NULL ,
Public intipo     As String  'CHAR     (03)   NULL ,
Public inemision  As String  'CHAR     (03)   NULL
Public ineleg     As String  'CHAR     (01)   NULL
Public incontab   As String  'CHAR     (01)   NULL

Private Sub Limpiar()

        incodigo = 0
        inserie = ""
        inglosa = ""
        inrutemi = 0
        inmonemi = 0
        inbasemi = 0
        inprog = ""
        inrefnomi = ""
        inmdse = ""
        inmdtd = ""
        inmdpr = ""
        intipfec = 0
        intasest = 0
        intipo = ""
        inemision = ""
        ineleg = ""
        incontab = ""
        
End Sub



