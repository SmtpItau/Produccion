USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_MONEDA]( @CodMon INTEGER     = 0 , -- 1.
                                 @Glosa  VARCHAR(35) = '', -- 2.
                                 @Nemo   VARCHAR( 8) = '', -- 3.
                                 @Simbol VARCHAR( 5) = '', -- 4.
                                 @MonExt VARCHAR( 1) = '', -- 5. 1=Externa 0=Local
                                 @IngVal VARCHAR( 1) = '') -- 6. 1=Liquidacion/Pagadora 0=Normal
AS
BEGIN

   SET NOCOUNT ON
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
            mncodpais       ,  -- 12
            mnrrda          ,  -- 13
            mnfactor        ,  -- 14
            mnrefusd        ,  -- 15
            mnlocal         ,  -- 16
            mnextranj       ,  -- 17
            mnvalor         ,  -- 18
            mnrefmerc       ,  -- 19
            mningval        ,  -- 20
            mntipmon        ,  -- 21
            mnperiodo       ,  -- 22
            mnmx               -- 23
       FROM MONEDA
      WHERE (mncodmon  = @CodMon OR @CodMon =  0)
        AND (mnglosa   = @Glosa  OR @Glosa  = '')
        AND (mnnemo    = @Nemo   OR @Nemo   = '')
        AND (mnsimbol  = @Simbol OR @Simbol = '')
        AND (mnextranj = @MonExt OR @MonExt = '')
        AND (CASE @IngVal WHEN '' THEN 0 ELSE mningval END) = CONVERT(INTEGER,@IngVal) 
END

GO
