USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_SDA]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ANULA_SDA]
								(	@NumContrato		NUMERIC(8,0)
								,	@NumSolicitud		NUMERIC(8,0) )
AS
BEGIN
     SET NOCOUNT ON  
         
     UPDATE TBL_SOLICITUD_SDA SET ESTADO_SOLICITUD = 'A'
     WHERE	NUM_CONTRATO = @NumContrato 
     AND	NUM_SOLICITUD = @NumSolicitud
     
     
 IF @@error <> 0 BEGIN
	SET NOCOUNT OFF
	SELECT 'NO'
RETURN
END
SET NOCOUNT OFF
SELECT 'Resultado' = 'SI'
         
END
GO
