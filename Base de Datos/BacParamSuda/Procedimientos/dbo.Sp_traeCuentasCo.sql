USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_traeCuentasCo]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_traeCuentasCo] ( @nCodTr INT , @nCodCampo CHAR(12) )
AS
/***********************************************************************
NOMBRE         : Sp_traeCuentasGl
DESCRIPCION    : Obtiene datos para CBX en Mantenedor Cuentas GL (BacMntGL)
**********************************************************************/
BEGIN
  DECLARE @ctabla VARCHAR(250),
	  @cCondic VARCHAR(250),
	  @cCampos VARCHAR(250),
	  @cExecute VARCHAR(300)

  SELECT DISTINCT @ctabla = tabla_campo,
		  @cCondic = campo_tabla,
		  @cCampos = campos_tablas 
  FROM campo_cnt 
  WHERE id_sistema = 'BTR' And tipo_administracion_campo = 'V' AND CODIGO_CAMPO = @nCodCampo
  --order by codigo_campo -- ++ UDD Migraci¾n SQL 2008

  SELECT @cExecute = 'SELECT ' + ltrim(rtrim(@cCampos)) + ',CuentaGl=0,CuentaSup=0,CtaAlt=0,CTaAltPer=0,CtaCosif=0,CtaCosig_G=0,CtaIntGl=0,CtaReaGl=0 FROM ' + ltrim(rtrim(@ctabla)) + ' ' +ltrim(rtrim(@cCondic))

  EXECUTE (@cExecute)


END

GO
