USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_FORMATO_COMPUESTO_CURVAS_SN]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_FORMATO_COMPUESTO_CURVAS_SN]
AS
BEGIN
	declare @ExisteSN Varchar(1)
	declare @FormatoCompuesto Varchar(1)
	select @FormatoCompuesto = 'N'
	select  @ExisteSN = 'N'
	select @FormatoCompuesto = ltrim(rtrim(nemo)) , @ExisteSN = 'S' from BacParamSuda.dbo.Tabla_General_Detalle where tbcateg = 24 
	if @ExisteSN = 'N' 
	Begin
	   delete BacParamSuda.dbo.TABLA_GENERAL_GLOBAL where ctcateg = 24  
       insert into BacParamSuda.dbo.TABLA_GENERAL_GLOBAL 
       select 24, 'VaR: Indicador Yield S/N', 1, 1, 1, 1, 1, '',0,0, ''
       insert into bacparamSuda.dbo.Tabla_general_detalle
       select 24, 1, 0, GETDATE(), 0, 'VaR: Indicador Yield S/N', 'N' 
	   select 'N'	
	end
	else
	select @FormatoCompuesto
END 

GO
