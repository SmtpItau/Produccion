USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_VALUTAS_CV_MX]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INF_VALUTAS_CV_MX]
		(
		@fechaDesde CHAR(10)
		,@fechaHasta CHAR(10)
		,@tipoFecha CHAR(1) = 'O'	/* O: Fecha de la Operación, V: Fecha de Valutas */
		,@codMoneda	VARCHAR(3) = 'TOD'	/*	'TOD'/1 en particular	*/
		,@rutCliente	VARCHAR(9) = 'T'	/* 'T'/un rut especifico */
		,@codCliente	VARCHAR(9) = 'T'	/*	''/codigo clte. especifico	*/
		,@tipoOper	CHAR(1) = 'T'	/*	'T'/'C'/'V'	*/
		,@tipoMercado CHAR(4) = 'TODO'	/*	'TODO'/'PTAS'/'EMPR'/'ARBI'	*/
		,@usuario VARCHAR(15) = ''
		)
    
AS
BEGIN		
   DECLARE  @acfecproc     CHAR(10)
           ,@acfecprox     CHAR(10)
           ,@uf_hoy        FLOAT
           ,@uf_man        FLOAT
           ,@ivp_hoy       FLOAT
           ,@ivp_man       FLOAT
           ,@do_hoy        FLOAT
           ,@do_man        FLOAT
           ,@da_hoy        FLOAT
           ,@da_man        FLOAT
           ,@acnomprop     CHAR(40)
           ,@rut_empresa   CHAR(12)
           ,@hora          CHAR(8)
           ,@OMA           CHAR(3)
           ,@Fecha_Proceso DATETIME           
   EXECUTE SP_BASE_DEL_INFORME   @acfecproc   OUTPUT
			,@acfecprox   OUTPUT
			,@uf_hoy      OUTPUT
			,@uf_man      OUTPUT
			,@ivp_hoy     OUTPUT
			,@ivp_man     OUTPUT
			,@do_hoy      OUTPUT
			,@do_man      OUTPUT
			,@da_hoy      OUTPUT
			,@da_man      OUTPUT
			,@acnomprop   OUTPUT
			,@rut_empresa OUTPUT
			,@hora        OUTPUT
			,@OMA         OUTPUT
   SET NOCOUNT ON
   SELECT @Fecha_Proceso = acfecpro FROM meac

   CREATE TABLE #MEMOX
   (
		parFechaDesde		DATETIME,
		parFechaHasta		DATETIME,
		parTipoFecha		CHAR(1),
		parCodMoneda		VARCHAR(3),
		parRutCliente		VARCHAR(9),
		parTipoOper			CHAR(1),
		parTipoMercado		CHAR(4),
		parUsuario			VARCHAR(15),
		Nombre_Cliente    	VARCHAR(70),
		Rut_Cliente			NUMERIC(9,0),
		Cod_Cliente			NUMERIC(9,0),
		Moneda          	CHAR(3),
		Moneda_Cnv			CHAR(3),
		Monto_Mx			NUMERIC(19,4),
		Monto_USD			NUMERIC(19,4),
		Tipo_Cambio			NUMERIC(19,4),
		Paridad				NUMERIC(19,8),
		Monto_Pesos			NUMERIC(19,4),
		Recibimos			CHAR(30),
		Entregamos			CHAR(30),
		Fecha_Valor			DATETIME,
		Tipo_Operacion		CHAR(1),
		Tipo_Mercado		CHAR(4),
		fecha_SERV			CHAR(10),
		acfecproc			CHAR(10),
		acfecprox			CHAR(10),
		uf_hoy				FLOAT,
		uf_man				FLOAT,
		ivp_hoy				FLOAT,
		ivp_man				FLOAT,
		do_hoy				FLOAT,
		do_man				FLOAT,
		da_hoy				FLOAT,
		da_man				FLOAT,
		pmnomprop			CHAR(40),
		rut_empresa			CHAR(12),
		hora				CHAR(10),
		operador			CHAR(15),
		numope				NUMERIC(7,0),
		movaluta1			DATETIME,
		movaluta2			DATETIME
    )
   
   INSERT INTO #MEMOX
   SELECT  	@fechaDesde,
			@fechaHasta,
			@tipoFecha,
			@codMoneda,
			@rutCliente,
			@tipoOper,
			@tipoMercado,
			@usuario,
			ISNULL(clnombre,'CLIENTE NO EXISTE')
			,morutcli
			,mocodcli	
			,mocodmon  
			,mocodcnv 
			,momonmo 
			,moussme 
			,moticam 
			,moparme 
			,momonpe 
			,ISNULL(a.glosa,'FORMA PAGO NO EXISTE')
			,ISNULL(b.glosa,'FORMA PAGO NO EXISTE')
			,mofech	
			,motipope
			,motipmer
			,CONVERT( CHAR(10) , GETDATE(), 103)
			,CONVERT(CHAR(10),@acfecproc,103)
			,CONVERT(CHAR(10),@acfecprox,103)
			,@uf_hoy
			,@uf_man
			,@ivp_hoy
			,@ivp_man
			,@do_hoy
			,@do_man
			,@da_hoy
			,@da_man
			,@acnomprop
			,@rut_empresa
			,CONVERT( CHAR(10) , GETDATE(), 108)
			,mooper
			,monumope    
			,movaluta1
			,movaluta2
	FROM memoh 
	LEFT OUTER JOIN view_forma_de_pago a 
	ON 	morecib = a.codigo      
    LEFT OUTER JOIN view_forma_de_pago b 
	ON 	moentre = b.codigo
        ,view_cliente
	WHERE  	morutcli  = clrut            AND
			cltipcli IN (1,2,3,4)        AND
			moestatus <> 'A'             AND
			(motipmer = @tipoMercado OR @tipoMercado = 'TODO') AND
			(motipope = @tipoOper OR @tipoOper = 'T') AND
			(mocodmon = @codMoneda OR @codMoneda = 'TOD') 

	IF @rutCliente <> 'T'
		DELETE FROM #MEMOX
		WHERE ( Rut_Cliente <> CONVERT(NUMERIC(9,0), @rutCliente) )


	IF @tipoFecha = 'O'		--- Operación
		DELETE FROM #MEMOX
		WHERE ( Fecha_Valor > @fechaHasta OR Fecha_Valor < @fechaDesde )
	ELSE					--- Valuta
		DELETE FROM #MEMOX
		WHERE (movaluta1 > @fechaHasta OR movaluta1 < @fechaDesde ) OR
			  (movaluta2 > @fechaHasta OR movaluta2 < @fechaDesde )


	SELECT  * FROM #MEMOX
	ORDER BY Tipo_Operacion, Nombre_Cliente, Fecha_Valor

 
	DROP TABLE #MEMOX

	
   SET NOCOUNT OFF
END
GO
