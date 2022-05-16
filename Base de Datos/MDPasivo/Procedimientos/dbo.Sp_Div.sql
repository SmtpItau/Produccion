USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Div]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







/****** Objeto:  procedimiento  almacenado dbo.Sp_Div    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/


/****** Objeto:  procedimiento  almacenado dbo.Sp_Div    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/

CREATE PROCEDURE [dbo].[Sp_Div]( @num FLOAT, @den FLOAT , @div FLOAT OUTPUT )
WITH RECOMPILE
AS
BEGIN

     SET DATEFORMAT dmy

     IF @den <> 0
        SELECT @div = @num / @den * 1.0

     ELSE
        SELECT @div = 0.0


END  -- Procedure












GO
