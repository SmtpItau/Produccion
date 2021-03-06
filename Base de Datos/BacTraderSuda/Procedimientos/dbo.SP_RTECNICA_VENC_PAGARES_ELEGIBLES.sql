USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_VENC_PAGARES_ELEGIBLES]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RTECNICA_VENC_PAGARES_ELEGIBLES]
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @institucion CHAR(100),
  @responsable  CHAR(80),
  @fono_respon  CHAR(30),
  @seccion CHAR(50),
  @fecproc  DATETIME,
  @uf  NUMERIC( 19, 4 ),
  @dolar  NUMERIC( 19, 4 )
 SELECT  @fecproc     = acfecproc,
  @responsable = RTRIM( acnom_resoma ),
  @fono_respon = RTRIM( acfon_resoma ),
  --@seccion     = RTRIM( acseccion ),
  @institucion = RTRIM( acnomprop )
 FROM  mdac
 
 --recupero el valor de la uf
 SELECT  @uf = ISNULL( a.VMVALOR, 0 )
 FROM  view_valor_moneda a,
  mdac  b
 WHERE  a.vmcodigo = 998 AND a.vmfecha = b.acfecproc
 --recupero el valor de dolar
 SELECT  @dolar = VMVALOR
 FROM  view_valor_moneda ,mdac
 WHERE  vmcodigo = 994 AND vmfecha = acfecproc
 SELECT 'indice' = case  when a.cpcodigo = 6
     then 1
     when a.cpcodigo = 4
     then 2
     when a.cpcodigo = 31
     then 3
     when a.cpcodigo = 300
     then 4
      end   ,
  'Inm'  = b.inserie  ,
  'NemoMoneda' = c.mnnemo  ,
  'instrumento'  = case  when a.cpcodigo = 6
     then 'PAGARES DESCONTABLES DEL B.C.CH. ( P.D.B.C )'
     when a.cpcodigo = 4
     then 'PAGARES REAJ. DEL BCCH. c/PAGO EN CUPONES'
     when a.cpcodigo = 31
     then 'PAGARE REAJUSTABLE DOLAR BCCH.'
     when a.cpcodigo = 300
     then 'PAGARE REAJ. DEL BCCH. CERO'
      end   ,
  'codigo'  = a.cpcodigo  ,
  'vencimiento' = a.cpfecpcup  ,
  'nominal' = sum(a.cpnominal) ,
  'monto_clp' = CONVERT( NUMERIC ( 19 ), ISNULL(  SUM(CASE  WHEN a.cpcodigo = 6   THEN ROUND(a.cpvalvenc/1000,0)
          WHEN a.cpcodigo = 400 THEN ROUND(a.cpvptirc/1000,0)
          WHEN a.cpcodigo = 31  THEN ROUND(a.CPVALVENC*@dolar/1000,0)
          ELSE ROUND(a.cpvalvenc*@uf/1000,0)
             END), 0 ) ),
  'rtecnica' = CASE WHEN a.cpreserva_tecnica = 'M' THEN '*' ELSE ' ' END
 INTO  #temporal
 FROM  mdcp a ,
  mdin b , --bmdd_pra..tpra_inm ,
  view_moneda  c --bmdd_pra..tpra_mon
 WHERE ( cpcodigo = 4
 OR a.cpcodigo = 6
 OR a.cpcodigo = 7
 OR a.cpcodigo = 31
 OR a.cpcodigo = 300 
 OR a.cpcodigo = 400 )
 --and a.cpmonemi = c.mncodmon
 AND     a.cpnominal > 0
 AND     a.cpvalvenc > 0
 AND  DATEDIFF( DAY, @fecproc, a.cpfecpcup ) < 91
 AND  a.cpcodigo = b.incodigo
 GROUP 
 BY  a.cpcodigo  ,
  b.inserie   ,
  b.inglosa   ,
  a.cpfecpcup  ,
  a.cpreserva_tecnica ,
  c.mnnemo   
 SELECT  *, 
  @institucion as institucion,
  @responsable as responsable,
  @fono_respon as telefono,
  @seccion     as seccion,
  @fecproc     as fecproc,
  @uf      as uf
 FROM  #temporal 
 ORDER 
 BY  indice  ,
  instrumento ,
  codigo  ,
  vencimiento
END
 


GO
