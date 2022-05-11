VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "estCortes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Tipo para manejo de Cortes
Dim mvarMtoCort            As Double
Dim mvarCantCortD          As Double
Dim mvarCantCortV          As Double

Public Property Let MtoCort(nMtoCort As Double)

   mvarMtoCort = nMtoCort

End Property

Public Property Get MtoCort() As Double

   MtoCort = mvarMtoCort

End Property

Public Property Let CantCortD(nCantCortD As Double)

   mvarCantCortD = nCantCortD

End Property

Public Property Get CantCortD() As Double

   CantCortD = mvarCantCortD

End Property

Public Property Let CantCortV(nCantCortV As Double)

   mvarCantCortV = nCantCortV

End Property

Public Property Get CantCortV() As Double

   CantCortV = mvarCantCortV

End Property

