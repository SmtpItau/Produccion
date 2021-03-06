USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXCEL_CARGASOMA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_EXCEL_CARGASOMA]
		(  
			@Fecha_Proceso		DATETIME		    = '',  
			@Hora_Ingreso		DATETIME		    = '',
			@Numdocu		    NUMERIC(5,0)		= 0	,
			@Numoper		    NUMERIC(5,0)		= 0	,
			@Correlativo		NUMERIC(5,0)		= 0	,
			@Instserie		    CHAR(12)		    = '',
			@Tipo_Operacion		CHAR(3)			    = '',
			@Nominal		    NUMERIC(19,4)		= 0	,
			@Plazo_residual		NUMERIC(6,0)		= 0	,
			@Tasa_referencial	NUMERIC(19,4)		= 0	,
			@Valor_referencial	NUMERIC(19,4)		= 0	,
			@Margen			    FLOAT			    = 0	,
			@Valor_Inicial		NUMERIC(19,4)		= 0	,
			@Valor_Final		NUMERIC(19,4)		= 0	,
			@Cta_destino		NUMERIC(11,0)		= 0	,
			@Cta_Lbtr           NUMERIC(11,0)		= 0	,
			@Cta_Dcv		    NUMERIC(7,0)		= 0	,
			@Estado_Dcv		    CHAR(20)		    = '',
			@Correlativo_SOMA	NUMERIC(3,0)		= 0	,
			@Observacion		CHAR(70)		    = '',
			@Diferencia		    NUMERIC(19,4)		= 0	,	
			@CorrelOpera		NUMERIC(10,0)		= 0
		)  
AS  
BEGIN 
		INSERT INTO CARGASOMA(	Fecha_Proceso	, -- se modifico el insert ya que se agregaron campos a la tabla CARGASOMA y en SQL2005 hay que decir que campos se van a insertar CVG
								Hora_Ingreso	,
								Numdocu			,
								Numoper			,
								Correlativo		,
								Instserie		,
								Tipo_operacion	,
								Nominal			,
								Plazo_residual	,
								Tasa_referencial,
								Valor_referencial,
								Margen			,
								Valor_Inicial	,
								Valor_Final		,
								Cta_destino		,
								Cta_Lbtr		,
								Cta_Dcv			,
								Estado_Dcv		,
								Correlativo_SOMA,
								Observacion		,
								diferencia		,
								CorrelOpe)
							VALUES (
								@Fecha_Proceso		,  
								@Hora_Ingreso		,
								@Numdocu			,
								@Numoper			,
								@Correlativo		,
								@Instserie			,
								@Tipo_Operacion		,
								@Nominal			,
								@Plazo_residual		,
								@Tasa_referencial	,
								@Valor_referencial	,
								@Margen				,
								@Valor_Inicial		,
								@Valor_Final		,
								@Cta_destino		,
								@Cta_Lbtr			,
								@Cta_Dcv			,
								@Estado_Dcv			,
								@Correlativo_SOMA	,
								@Observacion		,
								@Diferencia			,
								@CorrelOpera
							)	
		IF @@ERROR <> 0  
		BEGIN  
			SELECT 0,'ERROR_PROC FALLA GRABADO TABLA CARGASOMA'  
			RETURN
		END  
END

GO
