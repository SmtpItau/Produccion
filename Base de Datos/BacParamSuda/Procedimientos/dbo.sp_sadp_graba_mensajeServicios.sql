USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_sadp_graba_mensajeServicios]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_sadp_graba_mensajeServicios](  @sMensaje	VARCHAR(255) )
AS
BEGIN
	
	DECLARE @dFechaActual	DATETIME
	,		@dFechaLast		DATETIME		;
	
		
	DECLARE @sMensajeUlt	VARCHAR(255)	;
	
	DECLARE @iDelta			NUMERIC(10)		
	,		@iPosicion		NUMERIC(10)		;
	
		SET @dFechaActual = GETDATE()		;


		SET @iPosicion	  = (SELECT MAX(idMensaje) 
							   FROM tbl_mensajes_servicios) ;
		
		SET	@dFechaLast	  = (SELECT dTimeStamp 
	                 	       FROM tbl_mensajes_servicios
	                 	      WHERE idMensaje = @iPosicion ) ;     
	
		SET @sMensajeUlt  = (SELECT sMensaje
	                 	       FROM tbl_mensajes_servicios
	                 	      WHERE idMensaje = @iPosicion ) ;
			
		SET @iDelta		  = DATEDIFF(ms,@dFechaLast,@dFechaActual)	
		
		IF @sMensaje <> @sMensajeUlt  	
			INSERT 
			  INTO tbl_mensajes_servicios(dTimeStamp, sMensaje)
			VALUES( GETDATE(), @sMensaje )
END
GO
