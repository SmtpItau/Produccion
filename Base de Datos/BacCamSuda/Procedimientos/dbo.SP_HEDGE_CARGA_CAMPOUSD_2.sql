USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_HEDGE_CARGA_CAMPOUSD_2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_HEDGE_CARGA_CAMPOUSD_2]   @sistema 	 CHAR(1)
					, @cacodpos1 	 CHAR(2) -- PRD12720
					, @catipoper 	 CHAR(1)
					, @cTipoValor	 CHAR(1) 
					, @mnnemo1 	 CHAR(3) = ''
					, @mnnemo2 	 CHAR(3) = ''
					, @fechaconsulta CHAR(8) = ''
					, @retorno	 FLOAT OUTPUT
					, @vCampoMda     CHAR(15) = ''

AS	
BEGIN
	DECLARE @ccampo 	CHAR(30)
	DECLARE @cfecha 	CHAR(8)
	DECLARE @cnemo  	VARCHAR(100)
	DECLARE @cmda   	VARCHAR(100)
	DECLARE @vsql   	VARCHAR(1000)
	DECLARE @vSistema  	CHAR(50)
	DECLARE @vProducto  	CHAR(50)
	DECLARE @SC_TIPO	CHAR(50)

	--CREATE TABLE #MONEDASMX (CODIGO CHAR(4),VALOR FLOAT,DESCRIPCION CHAR (15))
	CREATE TABLE #TMP (VALOR FLOAT)

	SET @cnemo = CASE WHEN @mnnemo1 <> '' THEN ' AND mnnemo1 = '''+@mnnemo1 +''''
		     			      ELSE ' AND mnnemo2 =''' + @mnnemo2 +'''' END 

	SET @cfecha = LTRIM(RTRIM(@fechaconsulta))

	SELECT @cmda = codigo_moneda FROM TBL_HEDGE_MONEDAS WITH(NOLOCK) WHERE nemo_moneda= (CASE WHEN @mnnemo1 <> '' THEN  @mnnemo1 ELSE @mnnemo2 END) 

	SELECT @ccampo = Variable FROM tbl_hedge_mant WITH(NOLOCK)	
		      	WHERE 	    Cod_Origen   = @sistema
				AND Tipo_Valor   = @cTipoValor
				AND tipo_ope     = @catipoper
				AND moneda       = CASE WHEN @mnnemo1 <> '' THEN  @mnnemo1 ELSE @mnnemo2 END 
				AND cod_producto = @cacodpos1
				AND Imputacion  <> 'A'

	IF @ccampo IS NULL AND @sistema <> 4 --> PRD12720
	BEGIN  
		SET @retorno = 0
		SELECT @vSistema = tbglosa FROM BacParamSuda.dbo.tabla_general_detalle WITH(NOLOCK) WHERE tbcateg = 8601 and tbcodigo1 = @sistema
		SELECT @vProducto = descripción FROM tbl_hedge_producto WITH(NOLOCK) WHERE Codigo_Origen = @sistema AND Codigo = @cacodpos1

		SELECT -1 , 'Error no se encuentra campo en mantenedor de criterios. '
			    +' Sistema:'      + LTRIM(RTRIM(convert(varchar,@vSistema)))
			    +',Producto:'     + LTRIM(RTRIM(convert(varchar,@vProducto)))
			    +',Tipo Valor:'   + CASE WHEN @ctipovalor = 'A' THEN 'ACTIVO' 
						     WHEN @ctipovalor = 'P' THEN 'PASIVO'
					        END
			    +',Tipo Operac.:' + CASE WHEN @catipoper = 'C' THEN 'COMPRA' 
						     WHEN @catipoper = 'V' THEN 'VENTA'
					         END
			    +',Moneda:'       + CASE WHEN @mnnemo1 <> '' THEN  @mnnemo1 ELSE @mnnemo2 END
 
			 
		RETURN
	END



	IF @sistema = 1
	BEGIN
		SET @SC_TIPO = @cacodpos1
		SET @vsql = ('(SELECT ISNULL(SUM('+ LTRIM(RTRIM(@ccampo)) + '),0) FROM TBL_HEDGE_FWD WITH(NOLOCK)	
			WHERE catipoper = ''' + @catipoper + ''' ' + @cNemo +'
			AND   cacodpos1 IN ('+ LTRIM(RTRIM(@SC_TIPO)) +') 
			AND ( cafecvcto = ''' + LTRIM(RTRIM(@cFecha)) + ''' OR ''' + LTRIM(RTRIM(@cFecha)) + ''' = ''''))')
	END
-- PRD12720

	IF @sistema = 2
	BEGIN
			SET @vsql = ('(SELECT ISNULL(SUM('+ LTRIM(RTRIM(@cCampo)) + '),0) FROM TBL_HEDGE_SWAP WITH(NOLOCK)	
			WHERE tipo_operacion = ''' + @catipoper + ''' 
			 AND '+ @vCampoMda +' = '+ @cMda +')')
		  
	END

	IF @sistema = 3
	BEGIN
		SET @vsql = ('(SELECT ' + (CASE WHEN @ctipovalor = 'A' THEN  + ' (CASE WHEN ISNULL(SUM('+ @ccampo + '),0) > 0 THEN  SUM('+ @ccampo + ')  ELSE 0 END)' 
				   		WHEN @ctipovalor = 'P' THEN  + ' (CASE WHEN ISNULL(SUM('+ @ccampo + '),0) < 0 THEN  SUM('+ @ccampo + ')  ELSE 0 END)' END) 
				   + ' FROM TBL_HEDGE_OPCION WITH(NOLOCK))')
		  SELECT @vsql
	END

	IF @sistema = 4	--> PRD12720, -- 14: Dolar Observado Starting
	BEGIN
		IF @vCampoMda = '' 
		BEGIn
			SET @ccampo = 'fVal_Obtenido' -- en este campo esta el 'caDelta'
			SET @vsql = ('(SELECT ISNULL(SUM('+ LTRIM(RTRIM(@ccampo)) + '),0) FROM TBL_HEDGE_FWD WITH(NOLOCK)	
			WHERE cacodpos1 IN ('+ LTRIM(RTRIM(@cacodpos1)) +') 
			' + @cNemo + '
			AND ( cafecvcto = ''' + LTRIM(RTRIM(@cFecha)) + ''' OR ''' + LTRIM(RTRIM(@cFecha)) + ''' = ''''))')
		End
		Else
		Begin
			IF @vCampoMda = 'activo' 
			BEGIn
				SET @ccampo = 'fVal_Obtenido' -- en este campo esta el 'caDelta'
				SET @vsql = ('(SELECT ISNULL(SUM('+ LTRIM(RTRIM(@ccampo)) + '),0) FROM TBL_HEDGE_FWD WITH(NOLOCK)	
				WHERE cacodpos1 IN ('+ LTRIM(RTRIM(@cacodpos1)) +') 
				' + @cNemo + '
				AND fVal_Obtenido >=0 
				AND ( cafecvcto = ''' + LTRIM(RTRIM(@cFecha)) + ''' OR ''' + LTRIM(RTRIM(@cFecha)) + ''' = ''''))')
			End
			Else
			Begin
				IF @vCampoMda = 'pasivo' 
				BEGIn
					SET @ccampo = 'fVal_Obtenido' -- en este campo esta el 'caDelta'
					SET @vsql = ('(SELECT ISNULL(SUM('+ LTRIM(RTRIM(@ccampo)) + '),0) FROM TBL_HEDGE_FWD WITH(NOLOCK)	
					WHERE cacodpos1 IN ('+ LTRIM(RTRIM(@cacodpos1)) +') 
					' + @cNemo + '
					AND fVal_Obtenido < 0 
					AND ( cafecvcto = ''' + LTRIM(RTRIM(@cFecha)) + ''' OR ''' + LTRIM(RTRIM(@cFecha)) + ''' = ''''))')
				End
			End
		End
	END -- PRD12720


	INSERT #TMP
	EXECUTE (@vsql)
	--print @vsql

	SELECT @retorno = valor FROM #TMP

END
GO
