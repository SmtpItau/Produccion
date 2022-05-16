USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZADIGITADORMOVDIARIO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZADIGITADORMOVDIARIO]  
@digitador CHAR(15),
@numdocu NUMERIC(10,0)
AS
UPDATE MovDiario
SET moDigitador = @digitador
WHERE numero_operacion = @numdocu
AND Estado <> 'A'
GO
