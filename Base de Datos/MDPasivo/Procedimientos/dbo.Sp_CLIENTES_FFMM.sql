USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_CLIENTES_FFMM]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_CLIENTES_FFMM]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

      SELECT    
                	clgeneric ,
                	clcodigo  , 
			clnombre  ,
			clrut     ,
            		cldv      ,   
	               	cldirecc  ,
                	clcomuna  ,
                	clregion  ,
                	cltipcli  ,
                	clfecingr ,
                	clctacte  ,
                	clfono    ,
                	clfax 
           FROM CLIENTE  ,    DATOS_GENERALES
   	  WHERE clrut <> Rut_entidad
	    AND (cltipcli = 5)
	 --   AND clcodigo  = 1
        ORDER BY clnombre

END








GO
