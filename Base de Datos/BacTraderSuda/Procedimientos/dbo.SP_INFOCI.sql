USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOCI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFOCI] --'112','CI',0,'20010510','20010511','CARTERA DE COMPRAS CON PACTO TRANSABLES'
       (
 @tipo_cartera      CHAR(3)   = 0  ,
 @entidad      NUMERIC(9)  = 0  ,
 @FechaProc      CHAR(8)  = '' ,
 @FechaProx      CHAR(8)  = '' ,
 @Titulo       VARCHAR(200)  
       )
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS(SELECT * FROM MDRS WHERE rsfecha=@fechaprox)
    BEGIN
  SELECT 'NumDoc'   = CONVERT(VARCHAR(9),rsnumoper) + '-' + CONVERT(VARCHAR(10),rscorrela), --1
   'rscorrela'    = rscorrela   , --2
         'rsinstser'   = rsinstser   , --3
   'Emisor'   = (SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = rsrutcli)  , --4
   'FechaCompra'   = ISNULL(CONVERT(CHAR(10),rsfeccomp,103) ,' ')   , --5
   'FechaVctoP'   = ISNULL(CONVERT(CHAR(10),rsfecvtop,103),' ' )   , --6
   'FechaIniP'   = ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )   , --7
   'FechaEmision'   = ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )   , --8
   'Dias'    = ISNULL(DATEDIFF(dd,@FechaProc,rsfecvtop),0 )   , --9
   'rsvalcomu'   = rsvalcomu   , --10
   'moneda'   = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = rsmonemi)  , --11
   'UM'    = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = rsmonemi)  , --12
   'rsnominal'   = rsnominal   , --13
   'Cupon'    = (rsflujo - rscupint ), --14
   'rscupint'   = rscupint   , --15
   'rstir'    = rstir   , --16
   'rsvpcomp'   = rsvpcomp   , --17
   'rsvppresen'   = rsvppresen   , --18
   'rsinteres'   = rsinteres   , --19
   'rsreajuste'   = rsreajuste   , --20
   'rsintermes'   = rsintermes   , --21
   'rsreajumes'   = rsreajumes   , --22
   'rsvppresenx'   = rsvppresenx   , --23
   'rsinteres_acum'  = rsinteres_acum  , --24
   'rsreajuste_acum' = rsreajuste_acum  , --25
   'ValorIniPeso'   = rsvalinip   , --26
   'ValorVctoUM'   = rsvalvtop   , --27
   'TasaPacto'   = rstaspact   , --28
   'TasaEmision'   = rstasemi   , --29
   'rutCliente'   = (CONVERT(VARCHAR(10) , rsrutcli )) + '-' + (SELECT CLDV FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli) , --30
   'Cliente'   = (SELECT CLNOMBRE FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli )           , --31
   'sw'    = '0'    , --32
   'suma1'    = 0      --33
  INTO #TEMPORAL1
  FROM MDRS
    WHERE (rsrutcart = @Entidad  OR @Entidad  =0)
   AND rsinstser  <> 'ICAP' 
   AND rsinstser  <> 'ICOL' 
   AND rscartera   = @Tipo_cartera
   AND rsfecha     = @fechaproc
  SELECT moneda, 
   'ValorIniPeso'   = SUM(ValorIniPeso) ,
   'ValorVctoUM'   = SUM(ValorVctoUM) ,
   'rsintermes'   = SUM(rsintermes) ,
   'rsreajumes'   = SUM(rsreajumes) ,
   'rsinteres'   = SUM(rsinteres) ,
   'rsinteres_acum'  = SUM(rsinteres_acum) ,
   'rsreajuste'   = SUM(rsreajuste) ,
   'rsreajuste_acum' = SUM(rsreajuste_acum)
  INTO #TOTAL1
  FROM #TEMPORAL1
  GROUP BY moneda
  INSERT INTO #TEMPORAL1
  SELECT  0  , --1
   0  , --2
         ''  , --3
   ''  , --4
   ''  , --5
   ''  , --6
   ''  , --7
   ''  , --8
   0  , --9
   0  , --10
   'ZTOTAL' , --11
   'z'+MONEDA , --12
   0  , --13
   0  , --14
   0  , --15
   0  , --16
   0  , --17
   0  , --18
   rsinteres , --19
   rsreajuste , --20
   rsintermes , --21
   rsreajumes , --22
   0  , --23
   rsinteres_acum , --24
   rsreajuste_acum , --25
   ValorIniPeso , --26
   ValorVctoUM , --27
   0  , --28
   0  , --29
   0  , --30
   ''  , --31
   'sw'='1' , --32
   0    --33
  FROM #TOTAL1
  ----<< resultado para Crystal Report
  SELECT NumDoc     , --1
   rscorrela    , --2
   rsinstser    , --3
   Emisor     , --4
   FechaCompra    , --5
   FechaVctoP    , --6
   FechaIniP    , --7
   FechaEmision    , --8
   Dias     , --9
   rsvalcomu    , --10
   moneda     , --11
   UM     , --12
   rsnominal    , --13
   Cupon     , --14
   rscupint    , --15
   rstir     , --16
   rsvpcomp    , --17
   rsvppresen    , --18
   rsinteres    , --19
   rsreajuste    , --20
   rsintermes    , --21
   rsreajumes    , --22
   rsvppresenx    , --23
   rsinteres_acum    , --24
   rsreajuste_acum    , --25
   ValorIniPeso    , --26
   ValorVctoUM    , --27
   tasaPacto    , --28
   TasaEmision    , --29
   rutCliente    , --30
   Cliente     , --31
   'FechProc' = SUBSTRING(@fechaProc ,7,2) + '/' +SUBSTRING(@fechaProc ,5,2) + '/' +SUBSTRING(@fechaProc ,1,4) , --32
   'FechProx' = SUBSTRING(@fechaProx ,7,2) + '/' +SUBSTRING(@fechaProx ,5,2) + '/' +SUBSTRING(@fechaProx ,1,4) , --33
   'titulo1' = @titulo , --34 
 
   CASE sw WHEN '1' THEN  'RESUMEN '+@titulo ELSE @titulo END  AS 'titulo ', --35
   'UF_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
        AND VIEW_VALOR_MONEDA.vmcodigo = 998)  , --36
   'UF_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 998)  , --37
   'IVP_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
        AND VIEW_VALOR_MONEDA.vmcodigo = 997)  , --38
   'IVP_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
        AND VIEW_VALOR_MONEDA.vmcodigo = 997)  , --39
   'DO_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
                      AND VIEW_VALOR_MONEDA.vmcodigo = 994)  , --40
   'DO_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 994)  , --41
   'DA_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
                      AND VIEW_VALOR_MONEDA.vmcodigo = 995)  , --42
   'DA_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 995)  , --43
   'NombreEntidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') FROM MDAC ) , --44
   'Hora'  = CONVERT(varchar(10), GETDATE(), 108)   , --45
   sw         , --46
   'suma1'  = SUM(rsvppresenx)     , --47
   'hora'  = convert(varchar(10), getdate(), 108)
  FROM #temporal1
  ORDER BY um
    END
 ELSE
    BEGIN
  SELECT 'NumDoc'   = CONVERT(VARCHAR(9),vinumdocu) + '-' + CONVERT(VARCHAR(10),vicorrela),--1
   'rscorrela'    = vicorrela , --2
   'rsinstser'   = viinstser , --3
   'Emisor'   = (SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = virutcli) , --4
   'FechaCompra'   = ISNULL(CONVERT(CHAR(10),vifeccomp,103) ,' ') , --5
   'FechaVctoP'   = ISNULL(CONVERT(CHAR(10),vifecvenp,103),' ' ) , --6
   'FechaIniP'   = ISNULL(CONVERT(CHAR(10),vifecinip,103),' ' ) , --7
   'FechaEmision'   = ISNULL(CONVERT(CHAR(10),vifecinip,103),' ' ) , --8
   'Dias'    = ISNULL(DATEDIFF(dd,@FechaProc,vifecvenp),0 ) , --9
   'rsvalcomu'   = vivalcomu  , --10
   'moneda'   = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = vimonemi) , --11
   'UM'    = (SELECT mnnemo FROM VIEW_MONEDA WHERE MNCODMON = vimonemi) , --12
   'rsnominal'   = vinominal , --13
   'Cupon'    = 0  , --14
   'rscupint'   = 0   , --15
   'rstir'    = vitircomp , --16
   'rsvpcomp'   = vivpcomp , --17
   'rsvppresen'   = vivptirc , --18
   'rsinteres'   = viinteresvi , --19
   'rsreajuste'   = vireajustvi , --20
   'rsintermes'   = viintermesvi, --21
   'rsreajumes'   = vireajumesvi, --22
   'rsvppresenx'   = 0  , --23
   'rsinteres_acum'  = 0  , --24
   'rsreajuste_acum' = 0  , --25
   'ValorIniPeso'   = vivalinip , --26
   'ValorVctoUM'   = vivalvenp , --27
   'TasaPacto'   = vitaspact , --28
   'TasaEmision'   = 0  , --29
   'rutCliente'   = (CONVERT(VARCHAR(10) , virutcli )) + '-' + (SELECT CLDV FROM VIEW_CLIENTE WHERE CLRUT  = virutcli and CLCODIGO = vicodcli) , --30
   'Cliente'   = (SELECT CLNOMBRE FROM VIEW_CLIENTE WHERE CLRUT  = virutcli and CLCODIGO = vicodcli ) , --31
   'sw'    = '0'  , --32
   'suma1'    = 0    --33
  INTO #TEMPORAL2
  FROM MDVI 
    WHERE (virutcart = @Entidad  OR @Entidad  =0)
           AND viinstser <> 'ICAP' 
           AND viinstser <> 'ICOL' 
  SELECT moneda, 
   'ValorIniPeso'   = SUM(ValorIniPeso) ,
   'ValorVctoUM'   = SUM(ValorVctoUM) ,
   'rsintermes'   = SUM(rsintermes) ,
   'rsreajumes'   = SUM(rsreajumes) ,
   'rsinteres'   = SUM(rsinteres) ,
   'rsinteres_acum'  = SUM(rsinteres_acum) ,
   'rsreajuste'   = SUM(rsreajuste) ,
   'rsreajuste_acum' = SUM(rsreajuste_acum)
              
  INTO #TOTAL2  
  FROM #TEMPORAL2  
  GROUP BY moneda
  INSERT INTO #TEMPORAL2
  SELECT 0  , --1
   0  , --2
         ''  , --3
   ''  , --4
   ''  , --5
   ''  , --6
   ''  , --7
   ''  , --8
   0  , --9
   0  , --10
   'ZTOTAL' , --11
   'z'+MONEDA , --12
   0  , --13
   0  , --14
   0  , --15
   0  , --16
   0  , --17
   0  , --18
   rsinteres , --19
   rsreajuste , --20
   rsintermes , --21
   rsreajumes , --22
   0  , --23
   rsinteres_acum , --24
   rsreajuste_acum , --25
   ValorIniPeso , --26
   ValorVctoUM , --27
   0  , --28
   0  , --29
   0  , --30
   ''  , --31
   'sw'='1' , --32
   0    --33
  FROM #TOTAL2
  ----<< resultado para Crystal Report
  SELECT NumDoc  , --1
   rscorrela , --2
   rsinstser , --3
   Emisor  , --4
   FechaCompra , --5
   FechaVctoP , --6
   FechaIniP , --7
   FechaEmision , --8
   Dias  , --9
   rsvalcomu , --10
   moneda  , --11
   UM  , --11
   rsnominal , --12
   Cupon  , --13
   rscupint , --14
   rstir  , --15
   rsvpcomp , --16
   rsvppresen , --17
   rsinteres , --18
   rsreajuste , --19
   rsintermes , --20
   rsreajumes , --21
   rsvppresenx , --22
   rsinteres_acum , --23
   rsreajuste_acum , --24
   ValorIniPeso , --25
   ValorVctoUM , --26
   tasaPacto , --27
   TasaEmision , --28
   rutCliente , --29
   Cliente  , --30
   'FechProc' = SUBSTRING(@fechaProc ,7,2) + '/' +SUBSTRING(@fechaProc ,5,2) + '/' +SUBSTRING(@fechaProc ,1,4) , --31
   'FechProx' = SUBSTRING(@fechaProx ,7,2) + '/' +SUBSTRING(@fechaProx ,5,2) + '/' +SUBSTRING(@fechaProx ,1,4) , --32
   'titulo1' = @titulo, --33
   CASE sw WHEN '1' THEN  'RESUMEN '+@titulo ELSE @titulo END  AS 'titulo ', --34
   
   'UF_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
                          AND VIEW_VALOR_MONEDA.vmcodigo = 998) , --35
   'UF_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 998) , --36
   'IVP_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
        AND VIEW_VALOR_MONEDA.vmcodigo = 997) , --37
   'IVP_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 997) , --38
   'DO_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
                      AND VIEW_VALOR_MONEDA.vmcodigo = 994) , --39
   'DO_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 994) , --40
   'DA_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProc
                      AND VIEW_VALOR_MONEDA.vmcodigo = 995) , --41
   'DA_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha  = @FechaProx
                      AND VIEW_VALOR_MONEDA.vmcodigo = 995) , --42
   'NombreEntidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') FROM MDAC ) , --43
   'Hora'  = CONVERT(VARCHAR(10), GETDATE(), 108)   , --44
   sw         , --45
   suma1         , --46
   'hora'  = convert(varchar(10), getdate(), 108)
  FROM #TEMPORAL2
  ORDER BY UM
    END 
 SET NOCOUNT OFF
END

GO
