USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRUEBA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PRUEBA] --'BTR','20021001'
                   (
                      @cSistema CHAR (03) ,
                      @dFecha  DATETIME
                   )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nRutcart NUMERIC (09)

 DECLARE @dfecfmes        DATETIME ,
         @dFecha2         DATETIME ,
         @sw_tasa         CHAR(1) , 
         @x               INTEGER,
         @max             INTEGER,
         @TASA            INTEGER,
         @numero          INTEGER,
         @correla         INTEGER

 DECLARE @dFecFMesProx    DATETIME
 DECLARE @dFecFMesAnt     DATETIME
 DECLARE @Total_reg       NUMERIC(10)
 DECLARE @sw              CHAR(1)

 SELECT @nRutcart = acrutprop
 FROM MDAC
 DECLARE @acfecproc  CHAR (10)     ,
         @acfecprox  CHAR (10)     ,
         @uf_hoy     FLOAT         ,
         @uf_man     FLOAT         ,
         @ivp_hoy    FLOAT         ,
         @ivp_man    FLOAT         ,
         @do_hoy     FLOAT         ,
         @do_man     FLOAT         ,
         @da_hoy     FLOAT         ,
         @da_man     FLOAT         ,
         @acnomprop  CHAR (40)     ,
         @rut_empresa CHAR (12)    ,
         @nRutemp    NUMERIC (09,0),
         @hora       CHAR (08)     ,
         @paso       CHAR (01)     ,
         @fec_proc   DATETIME

 EXECUTE Sp_Base_Del_Informe
           @acfecproc OUTPUT       ,
           @acfecprox OUTPUT       ,
           @uf_hoy  OUTPUT         ,
           @uf_man  OUTPUT         ,
           @ivp_hoy OUTPUT         ,
           @ivp_man OUTPUT         ,
           @do_hoy  OUTPUT         ,
           @do_man  OUTPUT         ,
           @da_hoy  OUTPUT         ,
           @da_man  OUTPUT         ,
           @acnomprop OUTPUT       ,      
           @rut_empresa OUTPUT     ,
           @hora  OUTPUT

 SELECT @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )
 SELECT @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx )
 SELECT @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox) * -1,@acfecprox)
 SELECT @dFecFMesAnt  = DATEADD( MONTH, - 1, @acfecprox )
 SELECT @dFecFMesAnt  = DATEADD( DAY, DATEPART( DAY, @dFecFMesAnt ) * -1, @dFecFMesAnt )


declare @primerdia CHAR(08)
select @primerdia = CONVERT(CHAR(08),ACFECPROC,112) FROM MDAC
SELECT @primerdia = SUBSTRING(@primerdia,1,6)
SELECT @primerdia = RTRIM(@primerdia)+ '01'


SELECT      rsinstser    ,
            rsinstcam    ,
            dinumdocu    ,
            dicorrela    ,
            'tasa_merc'  = case when rsfeccomp < @primerdia then  isnull((SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = rsinstser and Fecha_proceso = @dFecFMesAnt and rsinstser <> rsinstcam and rsfecha = @primerdia),0.0) else ditircomp end,
            'fec_comp'   = rsfeccomp
                
         INTO #TEMPO

     FROM MDDI, MDRS
     WHERE ( rsnumdocu = dinumdocu AND rscorrela = dicorrela AND rsfecha = @acfecproc)


-- select rsinstser,rsinstcam ,* from mdrs where rsnumdocu = 40672 and rsfecha = '20021010'

/*   IF EXISTS(SELECT tasa_mercado FROM tasa_mercado,#TEMPO  WHERE tminstser = rsinstser and  fecha_proceso =  @dFecFMesAnt ) BEGIN
      UPDATE #TEMPO SET tasa_merc =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = rsinstser and Fecha_proceso = @dFecFMesAnt ),0.0)
   END ELSE
   IF EXISTS(SELECT tasa_mercado FROM tasa_mercado,#TEMPO  WHERE tminstser = rsinstser and  fecha_proceso =  @dfecfmes ) BEGIN
      UPDATE #TEMPO SET tasa_merc =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = rsinstser and Fecha_proceso = @dfecfmes ),0.0)
   end */

   select * from #tempo

end

--select * from tasa_mercado where fecha_proceso = '20020930'

--SELECT rstir,rsinstser,rsinstcam,* FROM MDrs where rsnumdocu = 40947 and rsfecha = '20021001'
-- select ditircomp ,* from mddi where dinumdocu = 40947




GO
