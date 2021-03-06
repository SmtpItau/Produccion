USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_INF_VENTAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_INF_VENTAS] (@nFecha CHAR(10))
AS
BEGIN
 DECLARE @dFecha DATETIME
 DECLARE @pFecha CHAR(10)
 DECLARE @Hora CHAR(10)
DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)
SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop
  FROM MDAC               
 SELECT @dFecha = CONVERT (DATETIME,@nFecha,121)
 SELECT @pFecha = CONVERT (CHAR(10),@dFecha,103)
 SELECT @Hora = CONVERT (CHAR(10),GETDATE(),108)
 SET NOCOUNT ON      
 SELECT 
   numdocu
  ,numoper
  ,correla
         ,instser
  ,fecven 
         ,mnnemo
  ,nominal
         ,vpresen
         ,vventa
                ,tasa
         ,tasacam
         ,basetasa
  ,resultado
         ,restxventa            
  ,glosa
  ,'FechaReport'= @pFecha 
  ,'HoraReport' = @Hora 
  ,clnombre
  ,inserie 
  
 INTO #PASO  
 -- SELECT resultado FROM renta_vp 
 FROM renta_vp r  , view_cliente , view_moneda , view_forma_de_pago f , view_instrumento I
 WHERE   r.fecproc  = @dFecha 
 AND     r.rutcli   = clrut 
 AND     r.codcli   = clcodigo
 AND  r.moneda   = mncodmon 
 AND  r.forpago  = f.codigo 
 AND  r.codigo   = I.incodigo
 AND r.instser <> 'FMUTUO' 
 IF (SELECT COUNT(*) FROM #PASO) = 0
           INSERT INTO #PASO (FechaReport,HoraReport,clnombre,glosa,inserie)VALUES(@pFecha, @Hora,'','','')
 
 SELECT *,'BANCO' = @ACNOMPROP FROM #PASO
 SET NOCOUNT OFF      
   
END
/*
SELECT * FROM RENTA_VP
 -- sp_rentabilidad_inf_ventas '20020102'
select * from view_forma_de_pago
select * from view_instrumento
SELECT 
   numdocu
  ,numoper
  ,correla
         ,instser
  ,fecven 
         ,mnnemo
  ,nominal
         ,vpresen
         ,vventa
                ,tasa
         ,tasacam
         ,basetasa resultado
         ,restxventa            
  ,glosa
  ,'FechaReport'= @pFecha 
  ,'HoraReport' = @Hora 
  ,clnombre
  ,inserie  
 
 FROM renta_vp r  ,view_cliente,view_moneda ,view_forma_de_pago f,view_instrumento I
 WHERE   r.fecproc  = @dFecha 
 AND     r.rutcli   = clrut 
 AND     r.codcli   = clcodigo
 AND  r.moneda   = mncodmon 
 AND  r.forpago  = f.codigo 
 AND  r.codigo   = I.incodigo
 AND r.instser <> 'FMUTUO' 
*/
 
GO
