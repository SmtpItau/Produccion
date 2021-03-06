USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIMPIA]

AS
BEGIN

Delete From BacTraderSuda.dbo.MDCI
Delete From BacTraderSuda.dbo.MDVI
Delete From BacTraderSuda.dbo.MDco
Delete From BacTraderSuda.dbo.MDcp
Delete From BacTraderSuda.dbo.MDcA
Delete From BacTraderSuda.dbo.MDmo




Delete From BacFwdSuda.dbo.MFMO
Delete From BacFwdSuda.dbo.MFCA
Delete From BacFwdSuda.dbo.MFCAh
Delete From BacFwdSuda.dbo.MFCA_lOG


Delete From bacCamsuda.dbo.MEMO


Delete From Baclineas.dbo.Detalle_Aprobaciones
Delete From Baclineas.dbo.Linea_Chequear
Delete From Baclineas.dbo.Linea_Transaccion
Delete From Baclineas.dbo.Linea_Transaccion_Detalle




Update 	Baclineas.dbo.Linea_General 
Set 	TotalOcupado = 0 ,
	TotalExceso  = 0 ,
	TotalDisponible = TotalAsignado


Update Baclineas.dbo.Linea_Sistema
Set 	TotalOcupado = 0 ,
	TotalExceso  = 0 ,
	TotalDisponible = TotalAsignado


END
GO
