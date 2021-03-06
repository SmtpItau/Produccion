USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENTREGA_DOLAR_CONTABLE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ENTREGA_DOLAR_CONTABLE]
(   @dFecha         DATETIME
,   @iValor         NUMERIC(21,4) OUTPUT
)
AS
BEGIN

   DECLARE @dFindeMes    DATETIME
   DECLARE @iDias        INTEGER

   SELECT  @dFecha       = DATEADD(MONTH,-1,@dFecha)
   SELECT  @iDias        = DATEPART( DAY  ,@dFecha)
   SELECT  @dFindeMes    = DATEADD ( DAY  , - (@iDias - 1) , @dFecha )
   SELECT  @dFindeMes    = DATEADD ( MONTH,1,@dFindeMes )
   SELECT  @dFindeMes    = DATEADD ( DAY, - 1 , @dFindeMes )

   SELECT  @iValor       = 0.0
   SELECT  @iValor       = CONVERT(NUMERIC(21,4),vmvalor)
   FROM    bacparamsuda..VALOR_MONEDA 
   WHERE   vmfecha       = @dFindeMes
   AND     vmcodigo      = 994
   
END


GO
