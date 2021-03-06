USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_OBTENER_PRIORIDAD_MONEDA]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_OBTENER_PRIORIDAD_MONEDA] 
		(	@MONEDA1	INT
		,	@MONEDA2	INT
		,	@Opcion		INT
		)
AS 
BEGIN

DECLARE @AUX INT

	SELECT mncodmon    
	   ,      mnPrioridad = isnull((select MnPRioridad     
									from BacParamSuda..MonedaPrioridad Pri    
									where Pri.MnCodMon = Mda.MnCodMon)    
					  , case when mnCodMon = 999 then 0    
										   when mnCodMon = 998 then 1    
										   when mnCodMon = 13  then 2    
										   else 3 end)    
	   ,      mnnemo 
    
	   into #MdaPri    
	   from BacParamSuda..MONEDA Mda where mnmx = 'C'     
	   Union    
	   Select mnCodMon    
	   ,      MnPrioridad = isnull( (select MnPrioridad     
							  from BacParamSuda..MonedaPrioridad Pri    
							  where Pri.MnCodMon = Mda.MnCodMon)    
							  , case when Mda.MnCodMon = 999 then 0     
									 when Mda.MnCodMon = 998 then 1    
									 when Mda.MnCodMon = 13  then 2    
									 else 3 end)    
	  ,         mnnemo
	   from  BacParamSuda..Moneda Mda    
	   where MnCodMon in ( 999, 998 ) 
		SELECT @AUX = CASE
			WHEN (select mnPrioridad from #MdaPri where mncodmon = @MONEDA1) >= (select mnPrioridad from #MdaPri where mncodmon = @MONEDA2) THEN 
				@MONEDA1
			ELSE 
				@MONEDA2
			END 
	   DROP TABLE #MdaPri
	   set @MONEDA1 = @AUX

	IF @OPCION = 1
	BEGIN
		SELECT @MONEDA1
	END
	ELSE IF  @OPCION = 2 
	BEGIN
		RETURN @MONEDA1
	END
END

GO
