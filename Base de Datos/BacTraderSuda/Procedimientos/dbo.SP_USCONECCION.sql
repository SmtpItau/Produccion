USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USCONECCION]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USCONECCION]
               (@usuario1 CHAR(15), @cConeccion CHAR(01) )
AS 
BEGIN 
    IF EXISTS( SELECT idconect FROM BACUSER WHERE usuario  = @usuario1
                                 AND   idconect = @cConeccion )
       SELECT 'SI_CONECCION'
    ELSE
       UPDATE BACUSER SET idconect = @cConeccion WHERE usuario = @Usuario1
    RETURN 
END


GO
