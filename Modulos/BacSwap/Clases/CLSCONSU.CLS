VERSION 1.0 CLASS
BEGIN
  MultiUse = 0   'False
END
Attribute VB_Name = "clsConsulta"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit

Public ConTipo             As Integer
Public ConSql              As String
Public ConTitulo           As String
Public ConPosicion         As Integer
Public ConCliente          As Long
Public ConNomCliente       As String
Public LinMoneda           As Integer
Public ConMoneda           As Integer
Public ConFecOper          As String
Public ConFecVcto          As String
Public ConFecDesde         As String
Public ConFecHasta         As String
Public ConOptFecha         As Integer
Public ConOptOrdenado      As Integer
Public ConOptConsulta      As Integer
Public ConChkCliente       As Integer
Public ConChkMoneda        As Integer
Public ConChkFecProceso    As Integer
Public ConChkFecVcto       As Integer
Public ConChkEntreFechas   As Integer
Public ConEntidad          As Integer
