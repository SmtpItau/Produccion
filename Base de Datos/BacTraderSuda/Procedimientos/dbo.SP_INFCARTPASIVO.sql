USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCARTPASIVO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFCARTPASIVO]( @cFechaProc  CHAR(8),
                              @cFechaProx  CHAR(8),
         @dolar  CHAR(1))
AS
BEGIN
   DECLARE @vtitulo VARCHAR(100)
DECLARE @NOMPROP CHAR(50)
DECLARE @RUTPROP NUMERIC(09)
DECLARE @DIGPROP CHAR(1)
DECLARE @FECPROC DATETIME
SELECT  @NOMPROP = acnomprop
       ,@RUTPROP = acrutprop
       ,@DIGPROP = acdigprop
  FROM  MDAC
   IF @dolar = 'S'
      SELECT @vtitulo = 'COLOCACIONES DE BONOS EN DOLARES'
   ELSE
      SELECT @vtitulo = 'COLOCACIONES DE BONOS'
 -- SELECT * FROM MDRS WHERE rsfecha = '20020102' and rscartera = '211'
   IF  EXISTS(SELECT * FROM MDRS WHERE rsfecha = @cFechaProx and rscartera = '211'
       AND CHARINDEX(STR(rsmonemi,3),CASE WHEN @Dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0) BEGIN
 
 
 SELECT  rsnumoper = rtrim(convert(char(9),rsnumoper)) + '-' + ltrim(convert(char(5),rscorrela))  ,
  rsinstser   ,
  'moneda' = (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = (select cpmonemi from mdpasivo where cpnumdocu =rsnumoper and cpcorrela =rscorrela)),
  rsnominal   ,
  rsnominal_resi   ,  
  rsflujo    ,
  'fecha_prox_c' = rsfecpcup ,
  'fecha_ult_c' = rsfecvcto ,
  'fecha_col' = rsfeccomp ,
  'fecha_emi' = rsfecemis ,
  'tasa_col' = rstir  ,
  'tasa_emis' = rstasemi ,
  'vc_col' = rsvpcomp ,
  'vc_emis' = 100  ,
  'valor_col' = rsvalcomp ,
  'valor_emis' = rsvalor_emis ,
  'valor_pro_col' = rsvppresen,
  'valor_pro_emis'= rsvpresen_emis,
  'interes_col' = rsinteres ,
  'interes_emis' = 0  ,
  'reajuste_col'  = rsreajuste ,
  'reajuste_emis'  = 0  ,
  'interes_acu_col' = rsinteres_acum ,
  'interes_acu_emi' = rsinteres_acum_emis ,
  'reajuste_acum_col' = rsreajuste_acum ,
  'reajuste_acum_emis' = rsreajuste_acum_emis ,
  'valor_prox_col'    = rsvppresenx ,
  'valor_prox_emi'    = rsvppresenx_emis ,
                'HORA' = CONVERT(varchar(10), GETDATE(), 108),
  'd' = @dolar,
                'titulo'=LTRIM(RTRIM(@vtitulo)) + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProc),103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProx),103),' '),
  'entidad' = @NOMPROP
 FROM MDRS
 WHERE rsfecha = @cFechaProx 
 AND   rscartera = '211'
 AND   CHARINDEX(STR(rsmonemi,3),CASE WHEN @Dolar='N' THEN '997-998-999' ELSE '988-994-995- 13' END)>0
    END  
    ELSE
    BEGIN 
 SELECT  rsnumoper = 0   ,
  rsinstser = ' '   ,
  'moneda'  = ' '   ,
  rsnominal = 0.0   ,
  rsnominal_resi = 0.0  ,
  rsflujo   = 0.0   ,
  'fecha_prox_c' = convert(char(10),' ') ,
  'fecha_ult_c' = convert(char(10),' ') ,
  'fecha_col' = convert(char(10),' '),
  'fecha_emi' = convert(char(10),' '),
  'tasa_col' = 0.0  ,
  'tasa_emis' = 0.0  ,
  'vc_col' = 0.0  ,
  'vc_emis' = 0  ,
  'valor_col' = 0.0  ,
  'valor_emis' = 0.0  ,
  'valor_pro_col' = 0.0  ,
  'valor_pro_emis'= 0.0  ,
  'interes_col' = 0.0  ,
  'interes_emis' = 0  ,
  'reajuste_col'  = 0.0  ,
  'reajuste_emis'  = 0  ,
  'interes_acu_col' = 0.0  ,
  'interes_acu_emi' = 0.0  ,
  'reajuste_acum_col' = 0.0 ,
  'reajuste_acum_emis' = 0.0 ,
  'valor_prox_col'    = 0.0 ,
  'valor_prox_emi'    = 0.0 ,
               'HORA' = CONVERT(varchar(10), GETDATE(), 108),
  'd' = @dolar,
                'titulo'=LTRIM(RTRIM(@vtitulo)) + SPACE(3)+'DEL'+SPACE(3)+ ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProc),103),' ') + SPACE(3)+ 'AL'+ SPACE(3)+ISNULL(CONVERT(CHAR(10),CONVERT(DATETIME,@cfechaProx),103),' '),
  'entidad' = @NOMPROP
 END    
END
-- sp_infcartpasivo '20011231','20020102','N'
 
-- alter table mdrs add rsvalorum_emis numeric(19,4) null default(0.0)
-- sp_autoriza_ejecutar 'bacuser'


GO
