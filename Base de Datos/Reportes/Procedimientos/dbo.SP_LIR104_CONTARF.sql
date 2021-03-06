USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIR104_CONTARF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LIR104_CONTARF]
AS 
BEGIN 
	DECLARE @Separador      VARCHAR(1)
	SET @Separador = ';'

	DECLARE @dFecha		DATETIME 
		SET @dFecha		= (SELECT acfecproc FROM bactradersuda.dbo.mdac); --'2019-12-30'
	

	SET NOCOUNT ON 

/*ACTUALIZACION POR FORMATO DECIMAL 20210630
 SELECT  
		convert(varchar,A.Numero_Voucher)		+ @Separador +
		convert(varchar, Fecha_Ingreso,112)		+ @Separador +-- as Fecha_Ingreso, -->>CVM.20200529_AAAAMMDD 	
		Glosa									+ @Separador +
		Tipo_Voucher							+ @Separador +
		Tipo_Operacion							+ @Separador +
		convert(varchar,Operacion)				+ @Separador +
		convert(varchar,a.Correlativo)			+ @Separador +
		instser									+ @Separador +
		convert(varchar,Documento)				+ @Separador +
		codigo_producto							+ @Separador +
		id_sistema								+ @Separador +
		convert(varchar,fpagoentre)				+ @Separador +
		convert(varchar,fpago)					+ @Separador +
		convert(varchar,plazo)					+ @Separador +
		condicion_pacto							+ @Separador +
		convert(varchar,clasificacion_cliente)	+ @Separador +	
		convert(varchar,a.Numero_Voucher)		+ @Separador +
		convert(varchar,b.Correlativo)			+ @Separador +--	as Correlativo_voucher,
		convert(varchar,Cuenta)					+ @Separador +
		convert(varchar,Tipo_Monto)				+ @Separador +
		convert(varchar,cast(Monto as decimal))	+ @Separador +
		convert(varchar,moneda)					+ @Separador	
		as REG_SALIDA
FROM bactradersuda.dbo.bac_cnt_voucher a with(nolock)
INNER  JOIN bactradersuda.dbo.bac_cnt_detalle_voucher b ON a.numero_voucher = b.numero_voucher
WHERE fecha_ingreso=@dFecha
*/


 SELECT  
		convert(varchar,A.Numero_Voucher)		+ @Separador +
		convert(varchar, Fecha_Ingreso,112)		+ @Separador +-- as Fecha_Ingreso, -->>CVM.20200529_AAAAMMDD 	
		Glosa									+ @Separador +
		Tipo_Voucher							+ @Separador +
		Tipo_Operacion							+ @Separador +
		convert(varchar,Operacion)				+ @Separador +
		convert(varchar,a.Correlativo)			+ @Separador +
		instser									+ @Separador +
		convert(varchar,Documento)				+ @Separador +
		codigo_producto							+ @Separador +
		id_sistema								+ @Separador +
		convert(varchar,fpagoentre)				+ @Separador +
		convert(varchar,fpago)					+ @Separador +
		convert(varchar,plazo)					+ @Separador +
		condicion_pacto							+ @Separador +
		convert(varchar,clasificacion_cliente)	+ @Separador +	
		convert(varchar,a.Numero_Voucher)		+ @Separador +
		convert(varchar,b.Correlativo)			+ @Separador +--	as Correlativo_voucher,
		convert(varchar,Cuenta)					+ @Separador +
		convert(varchar,Tipo_Monto)				+ @Separador +
		convert(varchar,cast(Monto as numeric(19,4)))	+ @Separador +
		convert(varchar,moneda)					+ @Separador	
		as REG_SALIDA
FROM bactradersuda.dbo.bac_cnt_voucher a with(nolock)
INNER  JOIN bactradersuda.dbo.bac_cnt_detalle_voucher b ON a.numero_voucher = b.numero_voucher
WHERE fecha_ingreso=@dFecha

END 
GO
