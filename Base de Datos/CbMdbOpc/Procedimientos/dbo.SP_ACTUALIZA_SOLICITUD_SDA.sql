USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_SOLICITUD_SDA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_ACTUALIZA_SOLICITUD_SDA]
     (
		@NumFolio           NUMERIC(8,0)	,
		@NumContrato		NUMERIC(8,0)	,
		@FechaIngreso		DATETIME		, 
		@FechaActivacion	DATETIME		,
		@MontoAnticipo		NUMERIC(21, 6)	,
		@FormaPago			NUMERIC(3, 0)	,
		@TipoAnticipo		VARCHAR(1)     
     )
AS
BEGIN

    SET NOCOUNT ON   
    
    UPDATE  TBL_SOLICITUD_SDA SET	NUM_CONTRATO = @NumContrato,
									FECHA_INGRESO = @FechaIngreso,
									FECHA_ACTIVACION = @FechaActivacion,
									MONTO_SOLICITUD = @MontoAnticipo,
									FORMA_PAGO = @FormaPago,
									TIPO_ANTICIPO = @TipoAnticipo
    WHERE NUM_SOLICITUD = @NumFolio AND ESTADO_SOLICITUD = 'V'
                 	
IF @@error <> 0 BEGIN
  SET NOCOUNT OFF
  SELECT 'NO'
  RETURN
END
SET NOCOUNT OFF
SELECT 'Resultado' = 'SI'
	
END
GO
