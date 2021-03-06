USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_RESPALDO_TABLAS_LINEAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RIEFIN_RESPALDO_TABLAS_LINEAS]

AS

BEGIN

   SET NOCOUNT ON



   declare  @dFecpro datetime



   declare    @nMes                   INTEGER

   ,       @nDia                   INTEGER

   ,       @cMes                   CHAR(02)

   ,       @cDia                   CHAR(02)



   declare   @cStrexec               CHAR(255)





   declare       @cArcLINEA_GENERAL      CHAR(50)         

         ,       @cArcLINEA_SISTEMA      CHAR(50)         

         ,       @cArcLINEA_PRODUCTO_POR_PLAZO CHAR(50)   

         ,       @cArcLINEA_TRANSACCION  CHAR(50)         









   SELECT     @dFecpro      = acfecproc

   FROM    BacTraderSuda..MDAC



   SELECT  @nMes  = DATEPART(MONTH,@dFecpro)

   ,       @nDia  = DATEPART(DAY,@dFecpro)



   IF @nMes < 10

      SELECT @cMes = '0' + CONVERT(CHAR(1),@nMes)

   ELSE

      SELECT @cMes =       CONVERT(CHAR(2),@nMes)



   IF @nDia < 10

      SELECT @cDia = '0' + CONVERT(CHAR(1),@nDia)

   ELSE

      SELECT @cDia =       CONVERT(CHAR(2),@nDia)









   select      @cArcLINEA_GENERAL     = 'LINEA_GENERAL'     + @cMes + @cDia   

        ,      @cArcLINEA_SISTEMA     = 'LINEA_SISTEMA'     + @cMes + @cDia   

        ,      @cArcLINEA_PRODUCTO_POR_PLAZO  = 'LINEA_PRODUCTO_POR_PLAZO'     + @cMes + @cDia   

        ,      @cArcLINEA_TRANSACCION = 'LINEA_TRANSACCION' + @cMes + @cDia   







   SELECT @cStrexec  = 'DROP TABLE ' + @cArcLINEA_GENERAL

   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_GENERAL)

     --EXECUTE (@cStrexec)   

     

   SELECT @cStrexec  = 'DROP TABLE ' + @cArcLINEA_SISTEMA

   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_SISTEMA)

    -- EXECUTE (@cStrexec)   

     



   SELECT @cStrexec  = 'DROP TABLE ' + @cArcLINEA_PRODUCTO_POR_PLAZO

   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_PRODUCTO_POR_PLAZO)

    --  EXECUTE (@cStrexec)       





   SELECT @cStrexec  = 'DROP TABLE ' + @cArcLINEA_TRANSACCION

   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_TRANSACCION)

    -- EXECUTE (@cStrexec) 



   SELECT @cStrexec  = 'SELECT * INTO ' + @cArcLINEA_GENERAL + ' FROM BacLineas.dbo.LINEA_GENERAL'

   IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_GENERAL)

     EXECUTE (@cStrexec)   

     



   SELECT @cStrexec  = 'SELECT * INTO ' + @cArcLINEA_SISTEMA + ' FROM BacLineas.dbo.LINEA_SISTEMA'

   IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_SISTEMA)

     EXECUTE (@cStrexec)   

     



   SELECT @cStrexec  = 'SELECT * INTO ' + @cArcLINEA_PRODUCTO_POR_PLAZO + ' FROM BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO'

   IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_PRODUCTO_POR_PLAZO)

     EXECUTE (@cStrexec) 





     SELECT @cStrexec  = 'SELECT * INTO ' + @cArcLINEA_TRANSACCION + ' FROM BacLineas.dbo.LINEA_TRANSACCION'

   IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcLINEA_TRANSACCION)

     EXECUTE (@cStrexec) 

     



END
GO
