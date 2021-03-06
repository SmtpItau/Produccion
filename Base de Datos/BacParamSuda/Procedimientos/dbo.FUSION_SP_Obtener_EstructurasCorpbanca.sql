USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_Obtener_EstructurasCorpbanca]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FUSION_SP_Obtener_EstructurasCorpbanca](@numsolicitud INT)
AS
BEGIN

 IF (@numsolicitud = 1) --'COMUNA'
  BEGIN

	SELECT 'codigoComuna' =  codigo_comuna
	      ,'codigoCiudad' =  codigo_ciudad
		  ,'nombreComuna' = nombre 
	FROM dbo.Comuna

  END

   IF (@numsolicitud = 2) --'METOODOLOGIA'
  BEGIN

	SELECT  'codigoMetodologia' = RecMtdCod
	       ,'descMetodologia'   = RecMtdDsc
 	FROM  BacLineas.dbo.TBL_METODOLOGIAREC

  END

  IF (@numsolicitud = 3) --'INSTITUCIÖN FINANCIERA'
  BEGIN

    SELECT  'codigoInstitucionFin' =  tbcodigo1
	       ,'DescInstitucionFin'   =  tbglosa
		   ,'NemoInstitucionFin'   =  nemo 
	FROM     dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE    tbcateg = 72 

  END

  IF (@numsolicitud = 4)  -- Calidad Juridica
  BEGIN
	
	SELECT  'codigoCalJur' = tbcodigo1
		   ,'DescCalJur'   = tbglosa
		   ,'NemoCalJur'   = nemo 
	FROM    dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE   tbcateg = 39 

  END

  IF (@numsolicitud = 5) -- ACTIVIDAD ECONÓMICA
  BEGIN
	 
	SELECT 'codigoActEconomica' = tbcodigo1
	      ,'DescActEconomica'   = tbglosa
		  ,'NemoActEconomica'   = nemo 
	FROM   dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
	WHERE  tbcateg = 13 

  END

  IF (@numsolicitud = 6)  -- MERCADO
  BEGIN

	SELECT 'codigoMercado' = codMercado
		  ,'descMercado'   = merc.tbglosa 
		  ,'nemoMercado'   = ''
	FROM  ( SELECT 'codMercado' = CASE WHEN tbcodigo1 = 1  THEN '1'
							  ELSE (CASE WHEN tbcodigo1 >= 7 AND tbcodigo1 <= 12 THEN '' ELSE ('2') END) END
			FROM     dbo.TABLA_GENERAL_DETALLE WITH (NOLOCK)
			WHERE    tbcateg = 72  
		 )  codMer   LEFT OUTER JOIN   dbo.TABLA_GENERAL_DETALLE  merc ON  merc.tbcodigo1 = codMer.codMercado
    WHERE merc.tbcateg = 202
	GROUP BY codMercado, merc.tbglosa 

  END

  IF (@numsolicitud = 7)  -- SEGMENTO
  BEGIN
	 
	 SELECT 'codigoSegmento' = SgmCod
	       ,'descSegmento'   = SgmDesc 
		   ,'nemoSegmento'   = SgmNem 
	 FROM   dbo.TBL_SEGMENTOSCOMERCIALES WITH (NOLOCK)

  END
  
  IF (@numsolicitud = 8)  -- Condiciones Generales
  BEGIN
	 
	 SELECT  'codCondicionesGenerales'  = clCondicionesGenerales 
			,'descCondicionesGenerales' = CASE WHEN  clCondicionesGenerales = 'S' THEN 'NO APLICA' ELSE 'CONDICIONES GENERALES' END
	 FROM   dbo.CLIENTE WITH (NOLOCK)
	 GROUP BY clCondicionesGenerales

  END

  
  IF (@numsolicitud = 9)  -- Nombre SINACOFI
   BEGIN	 
	 SELECT 'codSINACOFI'  = clcodigo 
		   ,'DescSINACOFI' = nombredata
		   ,'rutRelacion'  = clrut
	 FROM   BacParamSuda.dbo.SINACOFI AS sinac  WITH (NOLOCK)
	 GROUP BY clcodigo, nombredata, clrut, nombredata

   END

  IF(@numsolicitud = 10)  -- Comp. Bilateral
  BEGIN
	SELECT  'codCompBilateral'  = 0
		   ,'DescCompBilateral' = 'NO'
	UNION 
	SELECT 'codCompBilateral'   = 1
		  ,'DescCompBilateral'  = 'SI'
  END 

END



GO
