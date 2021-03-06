USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Moneda]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Leer_Moneda](   @CodMon INTEGER     = 0 , -- 1.
                                       @Glosa  VARCHAR(35) = ' ', -- 2.
                                       @Nemo   VARCHAR( 8) = ' ', -- 3.
                                       @Simbol VARCHAR( 5) = ' ', -- 4.
                                       @MonExt VARCHAR( 1) = ' ', -- 5. 1=Externa 0=Local
                                       @IngVal VARCHAR( 1) = ' ') -- 6. 1=Liquidacion/Pagadora 0=Normal
AS
BEGIN

     SET TRANSACTION ISOLATION LEVEL READ COMMITTED
     SET NOCOUNT ON
     SET DATEFORMAT dmy

     SELECT mncodmon        ,  -- 1
            mnnemo          ,  -- 2
            mnsimbol        ,  -- 3
            mnglosa         ,  -- 4
            mncodsuper      ,  -- 5
            mnnemsuper      ,  -- 6
            mncodbanco      ,  -- 7
            mnnembanco      ,  -- 8
            mnbase          ,  -- 9
            mnredondeo      ,  -- 10
            mndecimal       ,  -- 11
            mnrrda          ,  -- 12
            mnfactor        ,  -- 13
            mnrefusd        ,  -- 14
            mnlocal         ,  -- 15
            mnextranj       ,  -- 16
            mnvalor         ,  -- 17
            mnrefmerc       ,  -- 18
            mntipmon        ,  -- 19
            mnperiodo       ,  -- 20
            mnmx               -- 21

       FROM MONEDA WITH (NOLOCK)

      WHERE (mncodmon  = @CodMon OR @CodMon =  0)
        AND (mnglosa   = @Glosa  OR @Glosa  = ' ')
        AND (mnnemo    = @Nemo   OR @Nemo   = ' ')
        AND (mnsimbol  = @Simbol OR @Simbol = ' ')
        AND (mnextranj = @MonExt OR @MonExt = ' ')
        AND ESTADO<>'A'

END
GO
