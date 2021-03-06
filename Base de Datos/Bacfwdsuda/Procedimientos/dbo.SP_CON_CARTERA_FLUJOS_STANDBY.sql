USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CARTERA_FLUJOS_STANDBY]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_CARTERA_FLUJOS_STANDBY]	(	@Nro_Credito	INT		= 0
						,	@Usuario_Lock	CHAR(15)	= ''
						)
AS 
BEGIN

	DECLARE	@Usuario	CHAR(15)

	SET NOCOUNT ON 
	
	IF @Nro_Credito > 0 BEGIN
		SELECT	@Usuario	= (SELECT DISTINCT Cfs_Usuario_Lock FROM TBL_CARTERA_FLUJOS_STANDBY WHERE Cfs_Numero_Credito = @Nro_Credito)

		IF @Usuario IS NULL BEGIN
			IF EXISTS(SELECT 1 FROM TBL_CARTERA_FLUJOS WHERE Ctf_Numero_Credito = @Nro_Credito) BEGIN
				SELECT @Usuario = 'YA GRABADA'
			END
			ELSE BEGIN
				SELECT @Usuario = 'NO EXISTE'
			END
		END

		IF @Usuario <> '' BEGIN
			SELECT	0
			,	0					AS CANT_DIVIDENDOS
			,	CONVERT(CHAR(08),'01011900',112)	AS ULTIMO_VCTO
			,	0					AS TOT_UF
			,	0					AS PRECIO_UF_CONTRATO
			,	0					AS RUT_CLI
			,	''					AS DIG_VER
			,	0					AS CODIGO_CLI
			,	@Usuario				AS USUARIO_LOCK
			,	''					AS NOMBRE
			,	''					AS NOMBRE2
			,	''					AS APELLIDO_PATERNO
			,	''					AS APELLIDO_MATERNO
			,	''					AS EXISTE

			RETURN
		END
	END

	SELECT	Cfs_Numero_Credito
	,	Cfs_Numero_Dividendo				AS CANT_DIVIDENDOS
	,	CONVERT(CHAR(08),Cfs_Fecha_Vencimiento,112)	AS ULTIMO_VCTO
	,	Cfs_Monto_UF					AS TOT_UF
	,	Cfs_Precio_Contrato				AS PRECIO_UF_CONTRATO
	,	Cf_Rut_Cli					AS RUT_CLI
	,	Cf_Dv						AS DIG_VER
	,	1						AS CODIGO_CLI
	,	Cfs_Usuario_Lock				AS USUARIO_LOCK
	,	Cf_Nombre					AS NOMBRE
	,	Cf_Nombre2					AS NOMBRE2
	,	Cf_ApePtn					AS APELLIDO_PATERNO
	,	Cf_ApeMtn					AS APELLIDO_MATERNO
	,	CASE WHEN (SELECT 1 FROM BACPARAMSUDA..CLIENTE
				WHERE	clrut		= TBL_CABECERA_FLUJOS_STANDBY.Cf_Rut_Cli
				AND	Clcodigo	= 1) = 1 THEN 'S'
								 ELSE 'N' END AS EXISTE
	FROM	TBL_CARTERA_FLUJOS_STANDBY	
	,	TBL_CABECERA_FLUJOS_STANDBY
	WHERE	(Cfs_Numero_Credito	= @Nro_Credito	OR @Nro_Credito = 0)
	AND	Cf_Credito		= Cfs_Numero_Credito
	ORDER
	BY	Cfs_Numero_Credito
	,	Cfs_Fecha_Vencimiento
	,	Cfs_Numero_Dividendo

	EXEC SP_ACT_ESTADO_CARTERA_FLUJO_STANDBY	@Nro_Credito
						,	@Usuario_Lock

	SET NOCOUNT OFF
END

GO
