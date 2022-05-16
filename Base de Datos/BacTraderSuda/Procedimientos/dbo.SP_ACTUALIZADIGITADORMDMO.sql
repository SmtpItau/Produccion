USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZADIGITADORMDMO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZADIGITADORMDMO]
@digitador CHAR(15),
@numdocu NUMERIC(10,0)
AS
UPDATE mdmo
SET moDigitador = @digitador
WHERE monumoper = @numdocu
AND mostatreg <> 'A'


GO
