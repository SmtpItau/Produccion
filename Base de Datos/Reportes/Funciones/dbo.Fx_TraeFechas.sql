USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_TraeFechas]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fx_TraeFechas] 
	(   @num_folio INT
	   ,@tipo_flag CHAR(1)
	)	RETURNS VARCHAR(MAX)	
AS 
BEGIN   

DECLARE @fecha_ret DATETIME = '19000101'
DECLARE @num_folio_par INT

    IF(@tipo_flag = 'T')
	BEGIN 
	   SET @fecha_ret = (SELECT TOP 1 m.mofecha FROM Bacfwdsuda.dbo.mfmoh m WITH(NOLOCK) WHERE m.monumoper = @num_folio)
	   
	   IF(@fecha_ret IS NULL OR @fecha_ret = '')
		  BEGIN	
			 SET @num_folio_par = (SELECT numerocontratocliente FROM Bacfwdsuda.dbo.mfca m WITH(NOLOCK) WHERE m.canumoper = @num_folio)
			 
			 IF(@num_folio <> @num_folio_par)
				BEGIN 
					SET @fecha_ret = (SELECT TOP 1 m.mofecha FROM Bacfwdsuda.dbo.mfmoh m WITH(NOLOCK) WHERE m.monumoper = @num_folio_par)
				END 
		  END 	   
	END

    IF(@tipo_flag = 'E')
	BEGIN 
	   SET @fecha_ret = (SELECT TOP 1 m.mofecEfectiva FROM Bacfwdsuda.dbo.mfmoh m WITH(NOLOCK) WHERE m.monumoper = @num_folio)
	   
	   IF(@fecha_ret IS NULL OR @fecha_ret = '')
		  BEGIN
		  	SET @num_folio_par = (SELECT numerocontratocliente FROM Bacfwdsuda.dbo.mfca m WITH(NOLOCK) WHERE m.canumoper = @num_folio)
		  	
		  	IF(@num_folio <> @num_folio_par)
				BEGIN 
					SET @fecha_ret = (SELECT TOP 1 m.mofecEfectiva FROM Bacfwdsuda.dbo.mfmoh m WITH(NOLOCK) WHERE m.monumoper = @num_folio_par)
				END					   		  	
		  END  	   
	END

    IF(@tipo_flag = 'S')
	BEGIN 
		SET @fecha_ret = (SELECT TOP 1 m.cafecvcto FROM Bacfwdsuda.dbo.mfcah m WITH(NOLOCK) WHERE m.canumoper = @num_folio)

		IF EXISTS(SELECT 1 FROM Bacfwdsuda.dbo.mfca m WITH(NOLOCK) WHERE m.canumoper = @num_folio and m.caantici = 'A')
		    BEGIN 
			    SET @fecha_ret	= (SELECT TOP 1 m.cafecvcto FROM Bacfwdsuda.dbo.mfca_log m WITH(NOLOCK) WHERE m.canumoper = @num_folio)
		    END  
		ELSE 
    		    BEGIN 
			    SET @fecha_ret	= (SELECT TOP 1 mofecvcto FROM BacFwdsuda.dbo.mfmo  WITH(NOLOCK) WHERE monumoper = @num_folio
							   UNION 	
							   SELECT TOP 1 mofecvcto FROM BacFwdsuda.dbo.mfmoh WITH(NOLOCK) WHERE monumoper = @num_folio)
    		    END
    		    
    		IF(@fecha_ret IS NULL OR @fecha_ret = '')
    		  BEGIN 
    			 SET @num_folio_par = (SELECT numerocontratocliente FROM Bacfwdsuda.dbo.mfca m WITH(NOLOCK) WHERE m.canumoper = @num_folio)
    			 
    			 IF(@num_folio <> @num_folio_par)
    				BEGIN 
    				    SET @fecha_ret	= (SELECT TOP 1 m.cafecvcto FROM Bacfwdsuda.dbo.mfca_log m WITH(NOLOCK) WHERE m.canumoper = @num_folio_par)  	
    				END 
    		  END    		     
	END	
 
RETURN CONVERT(VARCHAR,@fecha_ret,3)

END


GO
