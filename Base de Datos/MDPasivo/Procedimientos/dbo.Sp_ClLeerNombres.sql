USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ClLeerNombres]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ClLeerNombres]
               (
                 @clnombre1 CHAR(40)      ,
                 @TipCli    NUMERIC(02)=0
               )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


       SELECT  	clrut     ,
                cldv      ,
                clcodigo  , 
                clnombre  ,
                clgeneric ,
                cldirecc  ,
                clcomuna  ,
                clregion  ,
                cltipcli  ,
                clfecingr ,
                clctacte  ,
                clfono    ,
                clfax 
           FROM CLIENTE
	   ,    DATOS_GENERALES
   	WHERE clrut <> Rut_Entidad
	  AND clnombre > ''
	  AND Clcodigo=1
	  AND (Cltipcli = @TipCli OR @TipCli = 0)

        ORDER BY clnombre





END



GO
