USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[fxReferencia]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fxReferencia]( @cSistema VARCHAR(05), @iNumero INT ) RETURNS VARCHAR(40)
AS 
BEGIN
	
		DECLARE @sRespuesta VARCHAR(40)		;	
			SET @sRespuesta ='' ;
	
		
		IF (SELECT COUNT(*) 
			  FROM SADP_DETALLE_PAGOS sdp 
			 WHERE sdp.cModulo=@cSistema 
			   AND sdp.cEstado ='E'
			   AND sdp.nContrato = @iNumero)<2
		BEGIN
				SELECT @sRespuesta = ISNULL(sdp.vNumTransferencia,'') 		
				  FROM SADP_DETALLE_PAGOS sdp		        
				 WHERE sdp.cModulo=@cSistema 
				   AND sdp.nContrato = @iNumero
		END
		ELSE 							   
		BEGIN
		
			DECLARE @iX			INT
			,		@nContador  INT
			,		@sDato		VARCHAR(100)
					
			DECLARE @Revi	TABLE( Reg	VARCHAR(50), nRegi NUMERIC(10) IDENTITY(1,1) )						
				SET @iX        = 0					
			
			INSERT INTO @revi(reg)  
			SELECT sdp.vNumTransferencia 
			  FROM SADP_DETALLE_PAGOS sdp 
			 WHERE sdp.cModulo=@cSistema
			   AND sdp.cEstado='E' 
			   AND sdp.nContrato = @iNumero
 
 			   SET @nContador = (SELECT MAX(Nregi) FROM @revi);
				
			SET @sRespuesta = ''''
			 
			WHILE @iX<=@nContador
			BEGIN
				
				SET @iX                = @iX + 1		;

				SELECT @sDato = LTRIM(Rtrim(reg))	
				 FROM @revi
      			WHERE Nregi        = @iX   	;
				
				SELECT @sRespuesta =  @sRespuesta +  CONVERT(CHAR(10),@sDato) +  CASE WHEN @iX=@nContador THEN '' ELSE ' ; ' END  
		
			END
		END
		RETURN 	@sRespuesta		
END
GO
