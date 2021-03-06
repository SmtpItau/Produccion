USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SERIES]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CON_SERIES]
		( 
			@ininstrumento	NUMERIC	(05) = 0
		,	@icnombre_inst	CHAR	(12) = ''
		,	@icproducto	CHAR	(05) = ''
		)
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON



	SELECT 
		S.codigo_instrumento			--1
		,S.nombre_serie				--2
		,S.rut_emisor				--3
		,S.tasa_emision				--4
		,S.codigo_base				--5
		,S.um_serie				--6
		,S.tasa_tera				--7
		,S.periodo_amortizacion			--8
		,S.numero_amortizacion			--9
		,S.plazo				--10
		,S.codigo_periodo			--11
		,S.cupones				--12
		,S.fecha_vencimiento			--13
		,S.fecha_emision			--14
		,S.bono_subordinado			--15
		,S.tasa_variable			--16
		,S.fecha_primer_corte			--17
		,S.numero_decimales			--18
		,emgeneric				--19
		,mnnemo					--20
		,emnombre				--21
		,emdv					--22
		,I.codigo_producto			--23
	FROM	VIEW_SERIE_PASIVO S, EMISOR , MONEDA, VIEW_INSTRUMENTO_PASIVO I
	WHERE ( S.codigo_instrumento = @ininstrumento OR @ininstrumento = 0 )
	AND   ( S.nombre_serie	   = @icnombre_inst OR @icnombre_inst = '')
	AND	S.rut_emisor = emrut
	AND	mncodmon = um_serie
	AND     S.codigo_instrumento = I.codigo_instrumento
	AND	(I.codigo_producto = @icproducto
        OR      @icproducto = '' )

END



GO
