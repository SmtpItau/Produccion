USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_Grabar]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Corresponsales_Grabar]
            (   @rutcliente	   NUMERIC(9)
            ,   @codigocliente	   NUMERIC(9)
            ,   @codigomoneda	   NUMERIC(5)
            ,   @codigopais	   NUMERIC(5)
            ,   @codigoplaza	   NUMERIC(5)
            ,   @codigoswift	   VARCHAR(20)
            ,   @nombre 	   VARCHAR(50)
            ,   @cuentacorriente   VARCHAR(30)
            ,   @swiftsantiago     VARCHAR(20)
            ,   @bancocentral      CHAR(1)
            ,   @fechavencimiento  DATETIME
            ,   @defecto           CHAR(1)
            ,   @icodigo_contable  CHAR(5)
            )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy
	
   INSERT INTO CORRESPONSAL 
   SELECT @rutcliente
      ,   @codigocliente
      ,   @codigomoneda
      ,   @codigopais
      ,   @codigoplaza		
      ,   @codigoswift
      ,   @nombre
      ,   @cuentacorriente
      ,   @swiftsantiago
      ,   @bancocentral
      ,   @fechavencimiento
      ,   @defecto
      ,   @icodigo_contable
	
   IF @@ERROR <> 0
   BEGIN

      SELECT 'error'

   END ELSE BEGIN

      SELECT 'ok'

   END

END



GO
