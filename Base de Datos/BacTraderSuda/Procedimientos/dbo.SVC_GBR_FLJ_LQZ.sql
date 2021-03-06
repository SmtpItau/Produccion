USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GBR_FLJ_LQZ]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SVC_GBR_FLJ_LQZ]
	(
	@Marca		CHAR(01),
	@Instrumento    CHAR(20),
	@Moneda		CHAR(03),
	@Emisor		CHAR(05),
	@Nominal	NUMERIC(21,8),
	@Tir		NUMERIC(19,4),
	@Vpar		NUMERIC(19,4),
	@Mt		NUMERIC(19,4),
	@Custodia	CHAR(15),
	@ClaveDcv	CHAR(15),
	@TirCmp		NUMERIC(19,4),
	@VparCmp	NUMERIC(19,4),
	@MTCmp		NUMERIC(19,4),
	@Utilidad	NUMERIC(19,4),
	@Clasificacion	CHAR(15),
	@NumeroOP	NUMERIC(10),
	@Correlativo	NUMERIC(03),
	@Sw             INTEGER    ,
  @Usuario        CHAR(15)     ,
  @p_Margen       float=0        ,
  @p_ValorInicial numeric(19,4)=0
	)
-- Autor		: 
-- Objetivo		: Grabar en tabla de paso
-- Fecha de Creacion	: 16-03-2004
-- Modificaciones	: 
-- Primera Modificacion	: 16-03-2004
-- Segunda Modificacion	: 16-03-2004
-- Antecedentes Generales : 
AS BEGIN

SET NOCOUNT ON

IF @Instrumento ='T'
BEGIN
   IF EXISTS(SELECT name FROM sysobjects WHERE name = 'FLJ_LQZ_IMD' AND type = 'U')
      BEGIN
          DELETE FLJ_LQZ_IMD WHERE Usuario = @Usuario 
   END

   IF EXISTS(SELECT name FROM sysobjects WHERE name = 'FLJ_LQZ_MOD' AND type = 'U')
      BEGIN
         DELETE FLJ_LQZ_MOD WHERE Usuario = @Usuario 
      END

   RETURN
END


IF @Sw = 1 
BEGIN
   DELETE MDBL FROM FLJ_LQZ_IMD WHERE Instrumento = @Instrumento AND  BLNUMDOCU = NumeroOP AND  BLCORRELA = Correlativo AND BLUSUARIO = Usuario
   DELETE FLJ_LQZ_IMD WHERE Instrumento = @Instrumento and Usuario = @Usuario
   RETURN
END

	INSERT INTO  FLJ_LQZ_IMD
		(
			Marca		,
			Instrumento     ,
			Moneda		,
			Emisor		,
			Nominal		,	
			Tir		,
			Vpar		,
			Mt		,
			Custodia	,
			ClaveDcv	,
			TirCmp		,
			VparCmp		,
			MTCmp		,
			Utilidad	,
			Clasificacion	,
			NumeroOP	,
			Correlativo	,
     Usuario      ,
     Margen       ,
     ValorInicial
		)
 
	VALUES
		(
			@Marca		,
			@Instrumento    ,
			@Moneda		,
			@Emisor		,
			@Nominal	,
			@Tir		,
			@Vpar		,
			@Mt		,
			@Custodia	,
			@ClaveDcv	,
			@TirCmp		,
			@VparCmp	,
			@MTCmp		,
			@Utilidad	,
			@Clasificacion	,
			@NumeroOP	,
			@Correlativo	,
     @Usuario      ,
     @p_Margen     ,
     @p_ValorInicial
		)
END


GO
