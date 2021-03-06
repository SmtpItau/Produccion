USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_TABLA_ART84BEX]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CARGA_TABLA_ART84BEX]
AS  
BEGIN
 SET NOCOUNT ON

   DECLARE  @fecpro              DATETIME       
           ,@vDolar_obs_FMes     NUMERIC(19,4)

    SELECT @fecpro           = acfecproc 
          ,@vDolar_obs_FMes  = isnull (dolarObsFinMes ,0)      
    FROM text_arc_ctl_dri

 CREATE TABLE #Art84
    (
    Numdocu       NUMERIC (10,0)    ,                        -- 1
    Numoper       NUMERIC (10,0)    ,                        -- 2
    Correla       NUMERIC (03,0)    ,                        -- 3
    Modulo        CHAR    (03)      ,                        -- 4 
    Fec_Proc      datetime          ,                        -- 5 
    RutDeudor     NUMERIC (9)       ,                        -- 6
    Instrumento   CHAR (20)         ,                        -- 8
    Mascara       CHAR (20)         ,                        -- 9
    Nominal       NUMERIC (19,4)    ,                        -- 10
    Fecha_compra  datetime          ,                        -- 11    
    Fecha_emi     datetime          ,                        -- 12
    Seriado       CHAR (1)          ,                        -- 13
    Codigo        NUMERIC (5)       ,                        -- 14
    Tir           NUMERIC (19,4)    ,                        -- 15
    Moneda        NUMERIC (5)       ,                        -- 16
    Tipoper       CHAR (3)          ,                        -- 17
    Monto         NUMERIC (19,4) NULL DEFAULT (0)            -- 18

   )

 INSERT #Art84
 SELECT cpnumdocu    ,
        cpnumdocu    ,
        cpcorrelativo,
        'BEX'        , 
        @fecpro      ,  
        cprutemi     ,
        id_instrum   ,
        cod_nemo     ,   
        cpnominal    ,
        cpfeccomp    ,    
        cpfecemi     ,
        ''           ,
        cod_familia  ,
        cptircomp    ,
        cpmonemi     ,
        'CP'       ,
        cpvptirc --ROUND(cpvptirc  * @vDolar_obs_FMes,0)

 FROM TEXT_CTR_INV,VIEW_EMISOR
 WHERE cpnominal   > 0 
   AND cprutcart > 0 
   AND cprutemi = emrut
   AND cpcodemi = emcodigo
   AND emtipo   <> 3
   AND cpfecven > @fecpro  -- MAP 2016-07-01 Para no mandar instrumentos vencidos

 INSERT BacTraderSuda..Margen_Articulo84  select  *  from #Art84



END
GO
