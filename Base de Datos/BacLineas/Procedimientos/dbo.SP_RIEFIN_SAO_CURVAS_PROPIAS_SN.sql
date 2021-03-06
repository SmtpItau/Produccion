USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_SAO_CURVAS_PROPIAS_SN]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_SAO_CURVAS_PROPIAS_SN]
AS
BEGIN
	declare @ExisteSN Varchar(1)
	declare @SAOCurvasPropias Varchar(1)
	select @SAOCurvasPropias = 'N'
	select  @ExisteSN = 'N'
	select @SAOCurvasPropias = ltrim(rtrim(nemo)) , @ExisteSN = 'S' from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 25 
	if @ExisteSN = 'N' 
	Begin
	   delete BacParamSuda.dbo.TABLA_GENERAL_GLOBAL where ctcateg = 25  
       insert into BacParamSuda.dbo.TABLA_GENERAL_GLOBAL 
       select 25, 'VaR: SAO Curva Prop S/N', 1, 1, 1, 1, 1, '',0,0, ''
       insert into bacparamSuda.dbo.Tabla_general_detalle
       select 25, 1, 0, GETDATE(), 0, 'VaR: SAO Curva Prop S/N', 'N' 
	   select 'N'	
	end
	else
	select @SAOCurvasPropias
END 

GO
