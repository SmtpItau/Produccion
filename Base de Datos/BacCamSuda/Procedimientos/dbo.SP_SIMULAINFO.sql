USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SIMULAINFO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_SIMULAINFO]
 (
         @tipope   CHAR(1)        ,
         @mONtousd NUMERIC(19,4)  ,
         @mONtoclp NUMERIC(19)    ,
         @mONeda   CHAR(3)        ,
         @TcCierre NUMERIC(19,4)  ,
         @TcCOSTO  NUMERIC(19,4)  ,          
         @ParCierre NUMERIC(19,4) ,
         @ParCosto NUMERIC(19,4)  
        )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @posic       FLOAT
   DECLARE @posclp      FLOAT
   DECLARE @totcous     FLOAT
   DECLARE @totveus     FLOAT
   DECLARE @totcous1    FLOAT
   DECLARE @totveus1    FLOAT
   DECLARE @totcope     FLOAT
   DECLARE @totvepe     FLOAT
   DECLARE @totcope1    FLOAT
   DECLARE @totvepe1    FLOAT
   DECLARE @pmeco       FLOAT
   DECLARE @pmeve       FLOAT
   DECLARE @pcierre     FLOAT
   DECLARE @utili       NUMERIC(19)
   DECLARE @fecha       CHAR(8)
   DECLARE @pcosto      FLOAT
   DECLARE @positiON    NUMERIC(19)
   DECLARE @rentabOpera NUMERIC(19)
   DECLARE @spread      NUMERIC(19,4)
   DECLARE @rrda        CHAR(1)
   --------------------------<< posiciON inicial
   SELECT      @posic   = info_posic,
               @posclp  = (info_posic * info_preini),
               @totcous = info_totco,
               @totveus = info_totve,
               @totcous1= info_totco,
               @totveus1= info_totve,
               @totcope = info_totcop,   --vmtotcope,
               @totvepe = info_totvep,   --vmtotvepe,
               @totcope1= info_totcop,   --vmtotcope,
               @totvepe1= info_totvep,   --vmtotvepe,
               @pmeco   = info_pmeco,
               @pmeve   = info_pmeve,
               @pcosto  = info_preini,
               @fecha   = CONVERT( CHAR(8), acfecpro, 112 ),
               @pcierre = 0,
               @utili   = 0
          FROM meac
   SELECT @rrda = (SELECT mnrrda FROM view_moneda WHERE mnnemo = @mONeda)
 
   SELECT @posic  = (@totcous - @totveus)
   SELECT @posclp = (@totcope - @totvepe)
   --------------------------<< totales & precios medios
   IF @tipope = 'C' BEGIN
      SELECT @totcous = (@totcous + @mONtousd),
      @totcous1= (@totcous1+ @mONtousd), 
             @totcope = (@totcope + @mONtoclp),
             @totcope1= (@totcope1+ @mONtoclp),
             @posic   = (@posic   + @mONtousd)
          
      IF @rrda = 'M' BEGIN 
         SELECT @spread = (@tccosto*@parcosto) - (@tccierre*@parcierre)
      END ELSE BEGIN
         SELECT @spread = (@tccosto/@parcosto) - (@tccierre/@parcierre)
      END
             
   END ELSE BEGIN
      IF @rrda = 'M' BEGIN
         SELECT @spread = (@tccierre*@parcierre) - (@tccosto*@parcosto)
      END ELSE BEGIN
         SELECT @spread = (@tccierre/@parcierre) - (@tccosto/@parcosto)
      END
      SELECT @totveus = (@totveus + @mONtousd), 
      @totveus1= (@totveus1+ @mONtousd),
             @totvepe = (@totvepe + @mONtoclp),
             @totvepe1= (@totvepe1+ @mONtoclp),
             @posic   = (@posic   - @mONtousd)
   END
   SELECT @pmeco   = (CASE @totcous WHEN 0 THEN 0 ELSE @totcope / @totcous END)
   SELECT @pmeve   = (CASE @totveus WHEN 0 THEN 0 ELSE @totvepe / @totveus END)
   SELECT @rentabopera = @spread * @mONtousd
   IF @posic <> 0 BEGIN
      SELECT @pcierre = (CASE WHEN @posic > 0 THEN @pmeco ELSE @pmeve END)
   END
   --------------------------<< calculos de posiciON & utilidad trading
   IF @totcous < @totveus BEGIN
      SELECT @utili = ( @totcous * (@pmeve - @pmeco) )
   END ELSE BEGIN
      SELECT @utili = ( @totveus * (@pmeve - @pmeco) )
   END
   ---------------------------<< calculos de posiciON & utilidad trading
   SELECT @positiON = 0
   IF @posic >= 0 BEGIN
      SELECT @positiON =     @posic  * (@pcosto - @pmeco)
   END ELSE BEGIN
      SELECT @positiON = abs(@posic) * (@pmeve - @pcosto)
   END
   --------------------------<< ajuste a precios promedios
   IF @totcous1 = 0 BEGIN
      SELECT @pmeco   = 0
   END
   IF @totveus1 = 0 BEGIN
SELECT @pmeve   = 0
   END
   --------------------------<< fin de simulaciON
   SELECT 'totcous' = ISNULL(@totcous1,0.0),
          'totcope' = ISNULL(@totcope1,0.0),
          'pmeco'   = ISNULL(@pmeco,0.0),
          'totveus' = ISNULL(@totveus1,0.0),
          'totvepe' = ISNULL(@totvepe1,0.0),
          'pmeve'   = ISNULL(@pmeve,0.0),
          'spread'   = ISNULL(@spread,0.0),
          'rentabopera' = ISNULL(@rentabopera,0),
          'utili'   = ISNULL(@utili,0),
          'posit'   = ISNULL(@positiON,0)
   SET NOCOUNT OFF
END


GO
