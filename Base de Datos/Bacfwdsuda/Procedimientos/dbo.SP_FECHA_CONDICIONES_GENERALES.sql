USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FECHA_CONDICIONES_GENERALES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_FECHA_CONDICIONES_GENERALES]( @rut NUMERIC(9),
						 @codigo NUMERIC(2),
						 @fecha_condiciones_generales DATETIME)
AS
BEGIN 
   SET NOCOUNT ON

	UPDATE bacparamsuda..cliente
	SET clFechaFirma_cond =@fecha_condiciones_generales
	WHERE Clrut =@rut
	AND   Clcodigo=@codigo
   
   SET NOCOUNT OFF
END

GO
