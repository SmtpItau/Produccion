USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZADIGITADORMEMO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ACTUALIZADIGITADORMEMO]
@digitador CHAR(15),
@numdocu NUMERIC(10,0)
AS
UPDATE memo
SET moDigitador = @digitador
WHERE monumope = @numdocu
AND moestatus <> 'A'




GO
