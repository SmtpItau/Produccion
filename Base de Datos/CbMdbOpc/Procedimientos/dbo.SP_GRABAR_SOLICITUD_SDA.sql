USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_SOLICITUD_SDA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_SOLICITUD_SDA]
									(	@NumContrato		NUMERIC(8,0)	,
										@FechaIngreso		DATETIME		, 
										@FechaActivacion	DATETIME		,
										@MontoAnticipo		NUMERIC(21, 6)	,
										@FormaPago			NUMERIC(3, 0)	,
										@TipoAnticipo		VARCHAR(1)  )
																				                                        
AS
BEGIN
     SET NOCOUNT ON   
                
	INSERT INTO TBL_SOLICITUD_SDA
	(			NUM_CONTRATO		
	,			FECHA_INGRESO		
	,			FECHA_ACTIVACION	
	,			MONTO_SOLICITUD		
	,			FORMA_PAGO			
	,			TIPO_ANTICIPO		
	,			ESTADO_SOLICITUD	
	,			TRANSACCION	
	)		
    VALUES 
	(			@NumContrato
	,			@FechaIngreso		
	,			@FechaActivacion
	,			@MontoAnticipo		
	,			@FormaPago			
	,			@TipoAnticipo	
	,			'V'
	,			'SOLICITUD'
	)	
    
IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
SET NOCOUNT OFF
SELECT 'Resultado' = 'SI'
END
GO
