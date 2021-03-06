USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ControlFinanciero_LeeOcupado]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ControlFinanciero_LeeOcupado]
AS
BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF EXISTS(SELECT 1 FROM DATOS_GENERALES)
   BEGIN
        SELECT invext_ocupado
        ,      'ESNULO' = 'NO'
        ,      capital_reserva 
        FROM   DATOS_GENERALES
	RETURN
   END
   
   SELECT 'INVEXTOCUPADO'=.0000 , 'ESNULO'='SI', 'INVEXTTOTAL'=.0000

   SET NOCOUNT OFF
END

GO
