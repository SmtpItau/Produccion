USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SBIF_TRASCARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_SBIF_TRASCARTERA]
    (
    @cSistema CHAR (03) ,
    @dFecha  DATETIME ,
    @dFeultvalo DATETIME
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @nRutcart NUMERIC (09)
 SELECT @nRutcart = acrutprop
 FROM MDAC
 SELECT diinstser     ,
  digenemi     ,
  'fecven' = CONVERT(CHAR(10),cpfecven,103),
  'tmarcierre' = CONVERT(NUMERIC (08,4),0) ,
  'tmarkciere' = CONVERT(NUMERIC (08,4),0) ,
  'tmark1' = CONVERT(NUMERIC (08,4),0) ,
  'tmark2' = CONVERT(NUMERIC (08,4),0) ,
  emrut      ,
  incodigo     ,
  mncodmon     ,
  'nominal' = ISNULL(SUM(cpnominal),0) ,
  dirutcart
 INTO #TEMPO
 FROM MDDI, MDCP, VIEW_INSTRUMENTO, VIEW_EMISOR, VIEW_MONEDA
 WHERE ditipoper='CP' AND (cpnumdocu=dinumdocu AND cpcorrela=dicorrela) AND incodigo=cpcodigo AND
  emgeneric=digenemi AND dirutcart=@nRutcart AND dinemmon=mnnemo AND incodigo<>98
 GROUP BY diinstser,digenemi,cpfecven,emrut,incodigo,mncodmon,dirutcart
 UPDATE #TEMPO
 SET nominal = nominal+ISNULL((SELECT SUM(vinominal) FROM MDVI WHERE viinstser=diinstser),0)
 DELETE #TEMPO WHERE nominal<=0
 SET ROWCOUNT 1
 UPDATE #TEMPO SET tmarcierre = ISNULL((SELECT tasa_mercado_cierre FROM TASA_MERCADO WHERE fecha_proceso=@dFeultvalo AND @cSistema=id_sistema AND tminstser=diinstser),0)
 SET ROWCOUNT 0
 UPDATE MDAC SET acfecsbif2=@dFecha
 SELECT diinstser ,
  digenemi ,
  fecven  ,
  tmarcierre ,
  tmarkciere ,
  tmark1  ,
  tmark2  ,
  emrut  ,
  incodigo ,
  mncodmon ,
  nominal  ,
  dirutcart
 FROM #TEMPO
 ORDER BY diinstser
 SET NOCOUNT OFF
END

GO
