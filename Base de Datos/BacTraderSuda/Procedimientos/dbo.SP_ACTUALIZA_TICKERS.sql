USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_TICKERS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--******************************************************************************
--procedimiento que actualiza el estado del papel una ve que ya ha sido ocupado*
--******************************************************************************
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_TICKERS](    @nemotecnico	varchar(20),
@tir	        numeric(5,4),
												 @emisor		VARCHAR(10),
												 @nominal		numeric(20,2),
@operacion numeric(10),  
             @usuario varchar(15)       
               )   
										     
as   
begin  
--****Declaracion de variable	
 DECLARE @nemo_bac CHAR(10)  
 DECLARE @tot NUMERIC(20,2)
 DECLARE @monto NUMERIC(20,2)
  
--****Se crea tabla temporal ------------------------------------------------------------------
	CREATE TABLE #tempNom(
							tnemo    VARCHAR(20),
							temisor  VARCHAR(20),
							tnominal NUMERIC(20,2),
							ttir     NUMERIC(5,4),
							tmonto	 NUMERIC(20,2)
)  
  
--****inserta los registros obtenidos en la consulta segun parametros recibidos------------------
	INSERT    INTO #tempNom
	SELECT	  nemotecnico,
		  emisor,	
		  SUM(val_resc)
          ,tir
          ,monto
from TBL_TICKERS_BOLSA  
where nemotecnico=@nemotecnico  
	AND tir=@tir
	GROUP BY nemotecnico,val_resc,emisor,tir,monto
  
--****Consulta donde se obtiene el emisor y monto que usaremos como filtro para actualizar estado
		SELECT @emisor=temisor,
			   @monto=tmonto	
		FROM   #tempNom
		WHERE ttir=@tir
		AND   tnominal=@nominal
  
--****Actualiza estado del papel------------------------------------------------------
	   update TBL_TICKERS_BOLSA set estado =1
	    where nemotecnico=@nemotecnico 
        and tir=@tir
        AND emisor=@emisor
        AND monto=@monto	
--****Borra tabla temporal creada.---------------------------------------------------
DROP table  #tempNom
  
END  
GO
