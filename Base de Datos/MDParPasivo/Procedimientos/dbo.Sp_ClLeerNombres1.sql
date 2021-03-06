USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClLeerNombres1]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_ClLeerNombres1] (@clnombre1 CHAR(40))
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


---       SET ROWCOUNT 50
       SELECT  	clrut     ,
                cldv      ,
                clcodigo  , 
                clnombre  ,
                clgeneric ,
                cldirecc  ,
                clcomuna  ,
                clregion  ,
--                clcompint ,
                cltipcli  ,
                clfecingr ,
                clctacte  ,
                clfono    ,
                clfax 
        FROM
                 CLIENTE, DATOS_GENERALES
   	WHERE clrut <> Rut_Entidad and
              clnombre > @clnombre1 
        ORDER BY
              clnombre

--	seT ROWCOUNT 0
END



GO
