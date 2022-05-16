USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIEMISORESSORTEO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DIEMISORESSORTEO]
   		(   @rutcart1 numeric(09,0)   )
AS
	SELECT DISTINCT emgeneric as Generico 
	  FROM MDDI
	 INNER 
	  JOIN VIEW_EMISOR
	    ON emgeneric = digenemi 
	   AND dinominal > 0 
	   AND Estado_Operacion_Linea =''		 
	   AND diserie   = 'LCHR' 
	   AND ditipoper = 'CP'				;



GO
