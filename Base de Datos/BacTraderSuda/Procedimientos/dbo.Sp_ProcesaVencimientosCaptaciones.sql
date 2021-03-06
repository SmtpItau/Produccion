USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ProcesaVencimientosCaptaciones]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_ProcesaVencimientosCaptaciones]  
AS  
/***********************************************************************  
NOMBRE         : Sp_ProcesaVencimientosCaptaciones.StoredProcedure  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 11/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
jcamposd 20130118 se suma control para las operaciones realizadas en EURO  
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
BEGIN  
set nocount on  
  
DECLARE @dfecvcto  DATETIME ,  
		@dfecsist DATETIME ,  
		@dfecorig DATETIME ,  
		@ndifdia INTEGER  ,  
		@nnumoper NUMERIC(10,0) ,  
		@ctipoper  CHAR(10) ,  
		@nrutcli   NUMERIC(10,0) ,  
		@ncodcli   NUMERIC(10,0) ,  
		@nentidad  NUMERIC(10,0) ,  
		@iforpago  INTEGER  ,  
		@cretiro   CHAR(01) ,  
		@nmontoini   NUMERIC(19,4) ,  
		@imoneda   INTEGER  ,  
		@ftasa    FLOAT  ,  
		@ftasatran FLOAT  ,  
		@iplazo    INTEGER  ,  
		@ccustodia  CHAR(01) ,  
		@nvalpres  NUMERIC(19,0) ,  
		@nnumoriginal NUMERIC(10,0) ,  
		@nmontofin NUMERIC(19,4) ,  
		@nvalmoneda NUMERIC(19,4) ,   
		@nnewoper NUMERIC(10,0) ,  
		@ncantrenov INTEGER  ,  
		@ibase  INTEGER  ,  
		@iredondeo INTEGER  ,  
		@CTIPO   char(1)  ,  
		@cEstado CHAR(1)  ,  
		@nCorrCorte Numeric(05) ,  
		@nCOrrela Numeric(05) ,  
		@nvalmon FLOAT  ,  
		@ntotalreg NUMERIC(10,0)  
  
 SELECT @ntotalreg = 0  
  
 SELECT @dfecsist = acfecproc FROM MDAC   
  
	SELECT  'numoper'       = numero_operacion ,  
			'dfecvcto'      = fecha_vencimiento,  
			'ctipoper'      = tipo_operacion  ,  
			'nrutcli'       = rut_cliente ,  
			'ncodcli'       = codigo_rut ,  
			'nentidad'      = entidad   ,  
			'iforpago'      = CONVERT(INTEGER,forma_pago),  
			'cretiro'       = retiro  ,  
			'imoneda'       = moneda   ,  
			'ftasa'         = tasa    ,  
			'ftasatran'		= tasa_tran   ,  
			'iplazo'		= plazo   ,  
			'ccustodia'		= custodia  ,  
			'nvalpres'		= valor_presente ,  
			'ibase'			= mnbase ,  
			'dfecorig'		= fecha_origen  ,  
			'dfecvctold'	= fecha_vencimiento ,  
			'ncantrenov'	= control_renov  ,  
			'iredondeo'		= mnredondeo  ,  
			'nnumoriginal'  = numero_original  ,  
			'CTIPO'			= tipo_deposito ,  
			'Correla_Corte' = Correla_Corte,  
			'correla_operacion'=correla_operacion,  
			'Flag'			= 0   
	INTO #tmpcapta   
	FROM GEN_CAPTACION , VIEW_MONEDA  
	WHERE fecha_vencimiento <= @dfecsist 
		AND mncodmon		= moneda              
		AND tipo_operacion	<> 'RIC'        
		AND estado			<> 'V'                  
		AND monto_inicio	> 0   
	ORDER BY correla_corte,correla_operacion  

	WHILE (1=1)  
	BEGIN  
	SELECT @cEstado = '*'  
  
          SET ROWCOUNT 1  
		Select @nnumoper   = numoper ,  
			@dfecvcto      = dfecvcto,  
			@ctipoper      = ctipoper  ,  
			@nrutcli       = nrutcli ,  
			@ncodcli       = ncodcli ,  
			@nentidad      = nentidad   ,  
			@iforpago      = iforpago      ,  
			@cretiro       = cretiro       ,  
			@imoneda       = imoneda       ,  
			@ftasa         = ftasa     ,  
			@ftasatran     = ftasatran     ,  
			@iplazo        = iplazo   ,  
			@ccustodia     = ccustodia ,  
			@nvalpres      = nvalpres ,  
			@ibase         = ibase    ,  
			@dfecorig      = dfecorig  ,  
			@ncantrenov    = ncantrenov,  
			@iredondeo     = iredondeo ,  
			@nnumoriginal  = nnumoriginal ,  
			@CTIPO         = CTIPO,  
			@nCorrCorte    = correla_corte,  
			@nCOrrela      = correla_operacion,  
			@cEstado = ' '  
		FROM #tmpcapta WHERE flag = 0   

	    SET ROWCOUNT 0   
  
         IF @cEstado = '*' BEGIN  
            BREAK  
         END  
  
  
  
	SELECT @ndifdia = DATEDIFF( day,@dfecsist,@dfecvcto)   
         SELECT @nvalmon = CASE WHEN @imoneda in(999,13,142) THEN 1 --jcamposd se suma euro producto de desarrollo DAP en euro  
    ELSE   
		(SELECT vmvalor from VIEW_VALOR_MONEDA where vmfecha=@dfecvcto and vmcodigo=@imoneda)   
    END  
  
  -- Actualizo las operaciones que vencen     
	IF  @ndifdia <=0  
	BEGIN  
		UPDATE GEN_CAPTACION   
             SET estado = 'V',  
				interes_acumulado = (monto_final - monto_inicio), -- Interes total del corte  
				valor_presente = monto_final * @nvalmon -- Monto final en pesos  
             WHERE numero_operacion		= @nnumoper  
					AND  correla_corte	= @nCorrCorte   
					AND  correla_operacion = @nCorrela 
					AND (estado = ' ' Or estado = 'A')  
    END  
  
         UPDATE #tmpcapta SET flag = 1 
		WHERE numoper			= @nnumoper    
			AND correla_corte	= @nCorrCorte  
			AND correla_operacion = @nCorrela   
  
  
 END  
  
	--SELECT @ntotalreg = COUNT(*) FROM #tmpcapta   
	--SELECT 'OK', 'TOTAL ' + RTRIM( CONVERT( VARCHAR(7), @ntotalreg ) )  
  
SET NOCOUNT OFF  
  
END 

GO
