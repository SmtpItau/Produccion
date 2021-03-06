USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_DTS_RENTA_GEN_CAP_5]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_GENERA_DTS_RENTA_GEN_CAP_5]  
AS   
 
BEGIN 
declare @fecha	datetime

select @fecha=DATEADD(month, -1, acfecproc) from mdac

	SELECT fecha_operacion
		,fecha_vencimiento
		,tipo_operacion
		,numero_operacion
		,correla_operacion
		,correla_corte
		,rut_cliente
		,codigo_rut
		,entidad
		,forma_pago
		,retiro
		,monto_inicio
		,monto_inicio_pesos
		,moneda
		,tasa
		,tasa_tran
		,plazo
		,monto_final
		,estado
		,fecha_origen
		,control_renov
		,custodia
		,valor_ant_presente
		,interes_diario
		,reajuste_diario
		,interes_acumulado
		,reajuste_acumulado
		,valor_presente
		,interes_extra
		,reajuste_extra
		,tipo_deposito
		,numero_original
		,ISNULL(Condicion_Captacion,'') 
		,ISNULL(Tipo_Emision,0) 
	FROM GEN_CAPTACION (NOLOCK)
	where fecha_operacion >= @fecha


END
GO
