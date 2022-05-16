USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCom]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCom    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/


/****** Objeto:  procedimiento  almacenado dbo.Sp_LeerCom    fecha de la secuencia de comandos: 14/02/2001 09:58:29 ******/



CREATE PROCEDURE [dbo].[Sp_LeerCom] (@cod_pai      NUMERIC(6),
                             @cod_ciu      NUMERIC(6))
AS
BEGIN 



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

  
	SELECT  cod_com,
        	nom_ciu
                
	
        FROM
        	CIUDAD_COMUNA
     	WHERE
        	cod_pai = @cod_pai
        AND     cod_ciu = @cod_ciu
        AND     cod_com <> 0

	/*SELECT  cod_com,
        	nom_ciu
        FROM
        	Ciudad_Comuna
     	WHERE
	     cod_com <> 0*/
     	    	
	ORDER BY nom_ciu
  	RETURN
END  
--execute Sp_LeerCom 997,1
--execute GraBacomuna 997,1,1,'SANTIAGO'

--select * from Ciudad_Comuna
/*LECT  cod_com,
        	nom_ciu
                
	
        FROM
        	Ciudad_Comuna
     	WHERE
	     cod_com = 0*/
     	















GO
