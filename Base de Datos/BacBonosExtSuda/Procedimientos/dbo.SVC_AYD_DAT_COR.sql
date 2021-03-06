USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYD_DAT_COR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_AYD_DAT_COR]
(
       @nRut NUMERIC(09),
       @nCod NUMERIC(09),
       @nMon NUMERIC(03),
       @nBco CHAR(50)   
)
AS
BEGIN
	IF @nBco = ''
		SELECT	nombre, --Banco,
			codigo_pais, --Plaza,
			cuenta_corriente, --Cuenta,
			'', --Ctacorta,
			codigo_swift, --Swift,
			'', --Chips,
			0, --Aba,
			0, --Nacional,
			'PAIS' = ISNULL( (SELECT nombre FROM view_pais WHERE codigo_pais = VIEW_CORRESPONSAL.codigo_pais),' ')
		FROM	VIEW_CORRESPONSAL
		WHERE	rut_cliente    = @nRut
		AND	codigo_cliente = @nCod
		AND	codigo_moneda = @nMon
		ORDER
		BY nombre
	ELSE
		SELECT	Nombre,
			codigo_pais, --Plaza,
			cuenta_corriente, --Cuenta,
			'', --Ctacorta,
			codigo_swift, --Swift,
			'', --Chips,
			0, --Aba,
			0, --Nacional,									-- select * from view_pais
				'PAIS' = ISNULL( (SELECT nombre FROM view_pais WHERE codigo_pais =  view_corresponsal.codigo_pais),' ')
		FROM	VIEW_CORRESPONSAL
		WHERE	rut_cliente    = @nRut
		AND	codigo_cliente = @nCod
		AND	codigo_moneda = @nMon
		AND	nombre  = @nBco
		ORDER
		BY nombre
END
-- Svc_Ayd_dat_cor 97051000, 1, 13, 'BANCO CORRESPONSAL'

GO
