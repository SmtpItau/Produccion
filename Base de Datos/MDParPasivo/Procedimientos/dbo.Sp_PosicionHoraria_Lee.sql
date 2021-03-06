USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PosicionHoraria_Lee]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_PosicionHoraria_Lee]

AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

	IF EXISTS(SELECT CODIGO_GRUPO FROM POSICION_GRUPO)
	   BEGIN
		SELECT  
			b.capital_reserva, --capitalyreserva
			b.invext_ocupado, --invextocupado
			a.codigo_grupo,
			c.descripcion, --descripcion
			a.porcentaje,
			a.totalposicion,
			a.totalocupado,
			a.totalcompra,
			a.totalventa,
			a.totaldisponible,
			a.totalexcedido
	
			FROM POSICION_GRUPO a, DATOS_GENERALES b, GRUPO_POSICION c
				WHERE c.codigo_grupo=a.codigo_grupo
	    END
 	ELSE
	    BEGIN
		SELECT  
			capital_reserva, --capitalyreserva
			invext_ocupado, --invextocupado
			codigo_grupo = '',
			descripcion = '',
			porcentaje = 0.0000,
			totalposicion = 0.0000,
			totalocupado = 0.0000,
			totalcompra = 0.0000,
			totalventa = 0.0000,
			totaldisponible = 0.0000,
			totalexcedido = 0.0000
	
			FROM DATOS_GENERALES
            END

END




GO
