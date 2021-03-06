USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIEMISORES]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIEMISORES]
   (   @rutcart1    NUMERIC(09,0)
   ,   @paretipoper CHAR(03)
   ,   @parenumcart NUMERIC(09,00)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaPro   DATETIME

	SET @dFechaPro   = (SELECT acfecproc FROM bactradersuda.dbo.mdac)	;

   if @paretipoper ='VP'
      select distinct emgeneric
      from   MDDI 
		 INNER 
		  JOIN VIEW_EMISOR
		    ON emgeneric = digenemi 
		 WHERE dirutcart = @rutcart1 
      and    dinominal > 0
      and    ditipoper = 'CP'
      and    ditipcart = @parenumcart
--      and    SUBSTRING(diserie,1,3) <> 'DPX'
      and    diserie  <> 'FMUTUO'
		   AND Estado_Operacion_Linea =''		 
		UNION
      select distinct digenemi 
      from   MDDI
      where dirutcart = @rutcart1 
      and   dinominal > 0
      and   ditipoper = 'CP'
      and   ditipcart = @parenumcart
--      and   SUBSTRING(diserie,1,3) <> 'DPX'
      and   diserie   = 'FMUTUO'
		   AND Estado_Operacion_Linea =''	
		   AND dinumdocu NOT IN((SELECT monumoper  
			  		   FROM MDMOPM 
			 		  WHERE PagoMañana = 'S' 
			   		    AND Fecha_PagoMañana >= @dFechaPro) )	
		ORDER
		   BY 1 								;
	ELSE
      select distinct emgeneric
      from   MDDI
		 INNER 
		  JOIN VIEW_EMISOR      		 
		    ON emgeneric = digenemi 
		 WHERE dirutcart = @rutcart1 
      and    dinominal > 0
      and    ditipcart = @parenumcart  
		   AND Estado_Operacion_Linea =''	
      And   (digenemi <> 'BCO' or diserie <> 'LCHR')  --> VGS 07/04/2005
--      and   SUBSTRING(diserie,1,3) <> 'DPX'
      and    Fecha_PagoMañana <= @dFechaPro	
		 ORDER
		    BY 1 								;
  
END
GO
