USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_LEERMDTM1_DIARIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SBIF_LEERMDTM1_DIARIA] --'BTR','20021011'
                   (
                      @cSistema CHAR (03) ,
                      @dFecha   DATETIME
                   )
AS
BEGIN
 SET NOCOUNT ON

 DECLARE @nRutcart NUMERIC (09)


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
         @fec_proc   DATETIME      ,
         @fec_prox   DATETIME


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

 DECLARE @dfecfmes        DATETIME ,
         @dFecha2         DATETIME ,
         @sw_tasa         char(1) , 
         @x               INTEGER,
         @max             INTEGER,
         @TASA            INTEGER,
         @numero          INTEGER,
         @correla         INTEGER

 DECLARE @dFecFMesProx    DATETIME
        ,@dFecFMesAnt     DATETIME
        ,@Total_reg       NUMERIC(10)
        ,@sw               char(1)


--         @acfecproc       CHAR(10) ,
--         @acfecprox       CHAR(10) , 

 SELECT @nRutcart = acrutprop,
        @fec_proc = acfecproc,
        @fec_prox = acfecprox
  FROM MDAC

-- SELECT @acfecproc = acfecproc,
--        @acfecprox = acfecprox
-- FROM MDAC

--   DECLARE @fehaxxx CHAR(8)
--   SELECT @fehaxxx = CONVERT(CHAR(8),CONVERT(DATETIME,@acfecproc),112)
--SELECT @fehaxxx 
 --  SELECT  DATEADD(DAY,DATEPART(DAY,@FEHAXXX) * -1,@FEHAXXX)

   SET @dfecfmes = DATEADD(DAY,DATEPART(DAY,@fec_prox) * -1,@fec_prox)
   SET @dFecFMesProx = DATEADD( MONTH, 1, @fec_prox)
   SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@dFecFMesProx)) * -1, CONVERT(DATETIME,@dFecFMesProx ))
--   SET @dFecFMesAnt = DATEADD( MONTH, -1, @fehaxxx)
   SET @dFecFMesAnt = DATEADD( DAY, DATEPART( DAY, CONVERT(DATETIME,@fec_prox)) * -1, CONVERT(DATETIME,@fec_prox))


--SELECT @dfecfmes,@dFecFMesProx,@dFecFMesAnt


SELECT      diinstser                                     ,
            digenemi                                      ,
            'fecven'     = CONVERT(CHAR(10),cpfecven,103) ,
            'tmarcierre' = CONVERT(NUMERIC (08,4),0)      ,
            'tmarkciere' = CONVERT(NUMERIC (08,4),0)      ,
            'tmark1'     = CONVERT(NUMERIC (08,4),0)      ,
            'tmark2'     = CONVERT(NUMERIC (08,4),0)      ,
            'emrut'      = CONVERT(NUMERIC (09,0),0)      ,
            incodigo                                      ,
            mncodmon                                      ,
            'nominal'    = cpnominal                      ,
            dirutcart                                     ,
            ditircomp    ,                                 
            cpfeccomp    ,
            dinumdocu    ,
            dicorrela
         INTO #TEMPO

     FROM MDDI, MDCP, VIEW_INSTRUMENTO, VIEW_MONEDA
     WHERE ditipoper = 'CP'      AND (cpnumdocu=dinumdocu AND cpcorrela = dicorrela) AND incodigo=cpcodigo AND
           dirutcart = @nRutcart AND dinemmon = mnnemo    AND cpcodigo  <> 98
           AND   SUBSTRING(diinstser,1,3) <> 'BCO' AND SUBSTRING(diinstser,1,3)<> 'COR'
           

--     GROUP BY diinstser,digenemi,cpfecven,incodigo,mncodmon,dirutcart,ditircomp ,cpfeccomp

--SELECT ditircomp,* FROM MDDI WHERE ditircomp = 0
-- select * from mdcp
--  select * from mddi
-- dbo.Sp_Sbif_LeerMdtm1_diaria 'BTR','20020916'
   
 --IF @acfecproc = @dFecha   
 --select * into from #TEMPO1

 
  UPDATE #TEMPO SET emrut = view_emisor.emrut
     FROM view_emisor
     WHERE emgeneric=digenemi
  
  UPDATE #TEMPO
  SET nominal = nominal+ISNULL((SELECT SUM(vinominal) FROM MDVI WHERE viinstser=diinstser),0)
 
  DELETE #TEMPO WHERE nominal <= 0

  SET @dFecha2  = (SELECT MAX(fecha_proceso) FROM TASA_MERCADO )
 
set @sw_tasa = 'S'

  if @dFecha2  >= (SELECT MAX(fecha_proceso) FROM TASA_MERCADO ) begin 
      set @sw_tasa = 'N'
   end else begin 
      set @sw_tasa = 'S'
      set @dFecha2  = (SELECT MAX(fecha_proceso) FROM TASA_MERCADO_diaria )
   end 


   IF EXISTS(SELECT tasa_mercado FROM tasa_mercado,#TEMPO  WHERE tminstser = diinstser and  fecha_proceso =  @dFecFMesAnt ) BEGIN
      UPDATE #TEMPO SET tmarcierre =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = diinstser and Fecha_proceso = @dFecFMesAnt ),0.0)
   END  ELSE IF EXISTS(SELECT tasa_mercado FROM tasa_mercado,#TEMPO  WHERE tminstser = diinstser and  fecha_proceso =  @dfecfmes ) BEGIN
      UPDATE #TEMPO SET tmarcierre =isnull(( SELECT tasa_mercado FROM tasa_mercado  WHERE tminstser = diinstser and Fecha_proceso = @dfecfmes ),0.0)
  end



      SELECT @max = count(*) from #TEMPO

      SELECT @x = 1
      WHILE @x <= @max
         BEGIN

         SET ROWCOUNT @x
          SELECT @TASA = tmarcierre,
                 @numero = dinumdocu,
                 @correla = dicorrela

         FROM #TEMPO
        SELECT @x = @x + 1

        IF @TASA = 0
           UPDATE  #TEMPO SET tmarcierre = (SELECT ditircomp FROM MDDI WHERE diinstser = diinstser AND dinumdocu = @numero  and dicorrela = @correla )  where 
                 dinumdocu = @numero  and 
                 dicorrela = @correla 
      END


--   UPDATE #TEMPO SET tmarcierre = ISNULL((SELECT ditircomp FROM MDDI WHERE diinstser = diinstser AND tmarcierre = 0 ),0.0)  


/*----------------------------------------------------------------------------------------*/
/*           CUANDO NO ES FIN DE MES, SI LA TASA ES CERO SE COLOCA LA TIR DE COMPRA       */
  
/*-----------------------------------------------------------------------------------------*/


/*UPDATE #TEMPO SET tmarcierre =  ISNULL(tasa_mercado,0) FROM TASA_MERCADO_diaria
                                         WHERE  fecha_proceso = @dFecha2
                                          AND  id_sistema     = @cSistema 
                                          AND  tminstser      = diinstser 
                                          AND  tmgenemis      = digenemi   
                                          AND  nominal        = tmnominal*/

/* UPDATE #TEMPO SET tmarcierre = isnull(tasa_mercado,0) from TASA_MERCADO 
                                         where  cpfeccomp = fecha_proceso 
                                          and id_sistema  = 'BTR'
                                          and  nominal    = tmnominal
                                         and diinstser   = tminstser 
                                          AND digenemi    = tmgenemis*/


-- SELECT * FROM #TEMPO



-- SELECT * FROM TASA_MERCADO_diaria



/*

 select tasa_mercado,* FROM TASA_MERCADO 
WHERE  --fecha_proceso = '20020828'
--AND  
id_sistema     = 'BTR'
AND  tminstser      = 'BESCO-A4' 
AND  tmgenemis      = 'MENER'   
*/

--  SELECT *  FROM TASA_MERCADO_diaria
-- cpfeccomp = @acfecproc --
/*
 UPDATE #TEMPO SET tmarcierre = isnull(tasa_mercado,0) from tasa_mercado_diaria 
                                         where  cpfeccomp = fecha_proceso 
      and   id_sistema  = 'BTR'
                                          and   nominal    = tmnominal
                                          and   diinstser   = tminstser 
                                          and   digenemi    = tmgenemis
-- AND  tminstser      = 'BESCO-A4' 
-- AND  tmgenemis      = 'MENER'   
                                          
*/
if @sw_tasa = 'N'
 UPDATE #TEMPO SET tmarkciere = ISNULL((SELECT top 1 tasa_market FROM TASA_MERCADO WHERE @dFecha=fecha_proceso AND @cSistema=id_sistema AND diinstser=tminstser AND tmgenemis = digenemi ),0)
else 
 UPDATE #TEMPO SET tmarkciere = ISNULL((SELECT top 1  tasa_market FROM TASA_MERCADO_diaria WHERE @dFecha=fecha_proceso AND @cSistema=id_sistema AND diinstser=tminstser AND tmgenemis = digenemi ),0)

 UPDATE #TEMPO SET tmark1     = ISNULL((SELECT top 1  tasa_market1 FROM TASA_MERCADO WHERE @dFecha=fecha_proceso AND @cSistema=id_sistema AND diinstser=tminstser AND tmgenemis = digenemi ),0)
 UPDATE #TEMPO SET tmark2     = ISNULL((SELECT top 1  tasa_market2 FROM TASA_MERCADO WHERE @dFecha=fecha_proceso AND @cSistema=id_sistema AND diinstser=tminstser AND tmgenemis = digenemi ),0)

 SELECT  diinstser 
         ,digenemi 
         ,fecven  
         ,tmarcierre 
         ,tmarkciere 
         ,tmark1  
         ,tmark2  
         ,emrut  
         ,incodigo 
         ,mncodmon 
         ,nominal  
         ,dirutcart  ,cpfeccomp
  FROM #TEMPO
  ORDER BY diinstser


end 

-- SELECT  ditircomp,* FROM MDDI WHERE diinstser= 'BCO11J0194'
-- Sp_Sbif_LeerMdtm1_diaria 'BTR','20021007'




-- SELECT * FROM VIEW_SERIE WHERE semascara = 'BCO11M'
-- SELECT * FROM VIEW_TABLA_DESARROLLO

-- SELECT CPCODIGO,* FROM MDCP






GO
