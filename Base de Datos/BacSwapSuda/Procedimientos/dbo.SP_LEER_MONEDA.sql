USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_MONEDA]  
   (   @CodMon    INTEGER     = 0   -- 1.
   ,   @Glosa     VARCHAR(35) = ''  -- 2.
   ,   @Nemo      VARCHAR(8)  = ''  -- 3.
   ,   @Simbol    VARCHAR(5)  = ''  -- 4.
   ,   @MonExt    VARCHAR(1)  = ''  -- 5. 1=Externa 0=Local
   ,   @IngVal    VARCHAR(1)  = ''  -- 6. 1=Liquidacion/Pagadora 0=Normal
   )
AS
BEGIN

   SET NOCOUNT ON

     SELECT mncodmon    = mncodmon
         ,  mnnemo      = mnnemo
         ,  mnsimbol    = mnsimbol
         ,  mnglosa     = mnglosa
         ,  mncodsuper  = mncodsuper
         ,  mnnemsuper  = mnnemsuper
         ,  mncodbanco  = mncodbanco
         ,  mnnembanco  = mnnembanco
         ,  mnbase      = mnbase
         ,  mnredondeo  = mnredondeo
         ,  mndecimal   = mndecimal
         ,  mncodpais   = mncodpais
         ,  mnrrda      = mnrrda
         ,  mnfactor    = mnfactor
         ,  mnrefusd    = mnrefusd
         ,  mnlocal     = CASE WHEN LEN( mnlocal ) = 0 THEN 0 ELSE mnlocal END
         ,  mnextranj   = mnextranj
         ,  mnvalor     = CASE WHEN LEN( mnvalor ) = 0 THEN 0 ELSE mnvalor END
         ,  mnrefmerc   = mnrefmerc
         ,  mningval    = mningval
         ,  mntipmon    = mntipmon
         ,  mnperiodo   = mnperiodo
         ,  mnmx        = mnmx
       FROM VIEW_MONEDA
      WHERE (mnCodMon  = @CodMon OR @CodMon =  0)
        AND (mnGlosa   = @Glosa  OR @Glosa  = '')
        AND (mnNemo    = @Nemo   OR @Nemo   = '')
        AND (mnSimbol  = @Simbol OR @Simbol = '')
        AND (mnExtranj = @MonExt OR @MonExt = '')
        AND (CASE @IngVal WHEN '' THEN 0 ELSE mnIngVal END) = CONVERT(INTEGER,@IngVal) 
END

GO
