USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_DATOS_VALOR_MONEDA_CONTABLE]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACT_DATOS_VALOR_MONEDA_CONTABLE]
					(	@Fecha		DATETIME
					,	@NemoMon	CHAR(10)	
					,	@Tipcam		NUMERIC(19,2)
					)
AS
BEGIN

  SET NOCOUNT ON


  DECLARE  @FecProc DATETIME	

  SELECT  @FecProc = acfecproc  
  FROM BacTraderSuda..MDAC
  

        INSERT INTO Valor_Moneda_Contable
        SELECT    @Fecha
		, mncodmon
		, @NemoMon
		, mncodfox
	        , @Tipcam
		, 5.0      
   	FROM  MONEDA
	WHERE mnnemo = @NemoMon


END 


GO
