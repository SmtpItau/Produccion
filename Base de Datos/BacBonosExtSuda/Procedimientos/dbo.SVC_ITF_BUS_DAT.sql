USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_ITF_BUS_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_ITF_BUS_DAT]
AS
BEGIN

	IF EXISTS(SELECT * FROM TEXT_CTR_INV ) BEGIN
		SELECT 	a.CPNUMDOCU	,	--1
			B.NOM_FAMILIA  	,	--2
			a.ID_INSTRUM	,	--3
			a.CPFECVEN	,	--4
			'cuentas_bech' = isnull((select cuenta_bech from text_itf_bct where numdocu = a.cpnumdocu),' ')	,	--5
			'cuentas_sbif' =isnull((select cuenta_sbif from text_itf_bct where numdocu = a.cpnumdocu), 0 )	,	--6

/* Falta crear campo COD_INSTRUM en la tabla text_itf_bct */

			123456789 'COD_INSTRUM' -- = isnull((select cod_instrum from text_itf_bct where numdocu = a.cpnumdocu), 0 ),	-- 7

		FROM 	TEXT_CTR_INV A, text_fml_inm B
		WHERE 	A.COD_FAMILIA = B.COD_FAMILIA
		ORDER BY a.COD_FAMILIA,a.ID_INSTRUM
	END
	ELSE BEGIN
		SELECT '0', 'No Existen Datos En cartera'
	END 
END

GO
