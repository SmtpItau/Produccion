USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD_INF_PACTOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RENTABILIDAD_INF_PACTOS](@nFecha CHAR(10),
         @Tip_Oper1 CHAR(2),
                                      @Tip_Oper2 CHAR(2) )
AS
BEGIN
 SET NOCOUNT ON
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
 
 SELECT  fecproc  ,
  tipoper  ,
  numoper  ,
  mnnemo  ,
  valinip  ,
  valvtop  ,
  fecini  ,
  fecven  ,
  'ptasa' =tasa ,
  'stasaefec' = tasaefec ,
  'ttasacam'  = tasacam ,
  basetasa ,
  resultado ,
  'FechaReport' = @pFecha ,
  'HoraReport'  = @Hora ,
  clnombre,
  'Forpagi'     = f1.glosa,
  'Forpagv'  = f2.glosa,
  'Estado'   = CASE WHEN tipoper = 'CI' OR tipoper = 'VI' THEN 'VIGENTES' ELSE 'VENCIMIENTOS' END ,
                'BANCO'    =@ACNOMPROP
 INTO #PASO
 FROM renta_ci,view_cliente,view_moneda,view_forma_de_pago f1,view_forma_de_pago f2
 WHERE @dFecha= fecproc 
 AND rutcli = clrut 
 AND codcli = clcodigo
 AND mncodmon =moneda
 AND (RTRIM(tipoper) = @Tip_Oper1
 OR RTRIM(tipoper) = @Tip_Oper2)
 AND forpagi = f1.codigo
 AND forpagv = f2.codigo
 
 IF (SELECT COUNT(*) FROM #PASO) = 0
 BEGIN
  INSERT INTO #PASO
  SELECT @dFecha ,
   @Tip_Oper1,
   0 ,
   '' ,
   0 ,
   0 ,
   '' ,
   '' ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   @pFecha ,
   @Hora ,
   '' ,
   '' ,
   '' ,
   ''      ,
          'BANCO'  =@ACNOMPROP
 END
 SET NOCOUNT OFF      
 SELECT * FROM #PASO
 SET NOCOUNT OFF  
 
END
/*
sp_rentabilidad_inf_pactos '20011123','VI','RC'
SELECT * FROM RENTA_ci
SELECT * FROM VIEW_MONEDA
SELECT * FROM VIEW_FORMA_DE_PAGO
SP_AUTORIZA_EJECUTAR 'BACUSER'
*/

GO
