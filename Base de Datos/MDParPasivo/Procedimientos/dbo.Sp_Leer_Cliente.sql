USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Cliente]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Leer_Cliente]
		(
		@clasecliente CHAR(20) = ' '
		)
AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT OFF

   SELECT clrut
      ,   cldv
      ,   clcodigo
      ,   clnombre
      ,   cldirecc
      ,   clcomuna
      ,   clciudad
      ,   clregion
      ,   clpais
      ,   clfono
      ,   clfax
      ,   clchips
      ,   claba
      ,   clswift
      ,   clctacte
      ,   clctausd
      ,   cltipcli
      ,   clmercado
     FROM CLIENTE
     WHERE (@clasecliente IN('APODERADOS', 'OPERADORES') AND cltipcli <> 4) OR (@clasecliente = ' ')
     ORDER BY clnombre
END

GO
