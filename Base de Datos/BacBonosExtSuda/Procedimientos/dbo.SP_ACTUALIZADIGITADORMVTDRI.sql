USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZADIGITADORMVTDRI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTUALIZADIGITADORMVTDRI]
(
@digitador CHAR(15),
@numdocu NUMERIC(10,0)
)
AS
UPDATE text_mvt_dri
SET moDigitador = @digitador
WHERE monumoper = @numdocu
AND mostatreg <> 'A'

GO
