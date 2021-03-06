USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CTAPORCLIENTE_BUSCAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CTAPORCLIENTE_BUSCAR]( 	@rutcliente 	NUMERIC(9)	,
						@codigocliente 	NUMERIC(9)
					  )
AS   
BEGIN

	SET NOCOUNT ON
	SELECT	codigo_moneda		,	--1
		codigo_pais		,	--2
		codigo_plaza		,	--3
		codigo_swift		,	--4
		nombre			,	--5
		cuenta_corriente	,	--6
		swift_santiago		,	--7
		banco_central		,	--8
		fecha_vencimiento	,	--9
		'DESCRIMONEDA'=(SELECT MONEDA.mnnemo FROM MONEDA WHERE MONEDA.mncodmon= CUENTAS_POR_MONEDA.codigo_moneda)	,
		'DESCRIPAIS'=(SELECT PAIS.nombre FROM PAIS WHERE PAIS.codigo_pais = CUENTAS_POR_MONEDA.codigo_pais)		,
		'DESCRIPLAZA'=(SELECT PLAZA.glosa FROM PLAZA WHERE PLAZA.codigo_plaza = CUENTAS_POR_MONEDA.codigo_plaza)	,
		'NOMBRE'=(SELECT CLIENTE.clnombre FROM CLIENTE WHERE CLIENTE.clrut=@RUTCLIENTE AND CLIENTE.clcodigo = @codigocliente)	,
		codigo_corres		,	--14
		codigo_contable		,	--15
		cod_Corresponsal	,	--16
		Rut_Corresponsal		--17
	FROM 	CUENTAS_POR_MONEDA 
	WHERE  	rut_cliente = @rutcliente  AND 
		codigo_cliente = @codigocliente  
   
	SET NOCOUNT OFF       

END        

GO
