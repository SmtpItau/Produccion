USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDMNLEERCODIGO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE  PROCEDURE [dbo].[SP_MDMNLEERCODIGO]
   (   @ncodigo     NUMERIC(5,0)      -- C«digo moneda
   ,   @dfecpro     DATETIME          -- Fecha de Proceso (Ojo este dato se
   )                                  -- podria traer de la tabla de
                                      -- par~metros (MDAC).
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @ivalordolarOb   FLOAT

   SELECT  @ivalordolarOb  = 0.0

   SELECT  @ivalordolarOb  = isnull(vmvalor,0.0)
   FROM    VIEW_VALOR_MONEDA 
   WHERE   vmcodigo        = 994
   AND     vmfecha         = @dfecpro

   SELECT mncodmon
   ,      mnglosa
   ,      mnnemo
   ,      mnfactor
   ,      mnredondeo
   ,      mncodbanco
   ,      mncodsuper
   ,      mnbase
   ,      mnrefusd
   ,      mnlocal
   ,      mnextranj
   ,      mnvalor    = CASE WHEN @ncodigo = 999 THEN 1
                            WHEN @ncodigo =  13 THEN @ivalordolarOb
                            ELSE                     ISNULL(vmvalor,0)
                       END
   ,      mnrefmerc
   ,      mningval
   ,     'mnvalor'  = CASE WHEN @ncodigo = 999 THEN 1
                           WHEN @ncodigo =  13 THEN @ivalordolarOb
                           ELSE                     ISNULL(vmvalor,0)
                       END
   ,      mnrrda
   ,      mndecimal
   FROM   VIEW_MONEDA  LEFT JOIN VIEW_VALOR_MONEDA ON mncodmon = vmcodigo AND vmfecha = @dfecpro
   WHERE  mncodmon   = @ncodigo

END

GO
