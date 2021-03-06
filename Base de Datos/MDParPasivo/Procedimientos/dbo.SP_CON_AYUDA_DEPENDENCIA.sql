USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_AYUDA_DEPENDENCIA]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_AYUDA_DEPENDENCIA]
		(
			@cTipoBusqueda    CHAR   (05) = ''
		,	@cRutCliente      NUMERIC(09) = 0
		)
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   IF @cTipoBusqueda = 'CBUS'
      BEGIN

          SELECT  COUNT(*)
             FROM CLIENTE
 	    ,     DATOS_GENERALES
       	    WHERE clrut   <> Rut_entidad 
   	     AND clrut    <> 97029000
   	     AND clrut     = @cRutCliente
   	     AND Bloqueado = 'N'
   	     AND clcodigo <> 1
       RETURN
      END

   IF @cTipoBusqueda = 'BDEPE'
      BEGIN

          SELECT  clrut     ,
                  cldv      ,
                  clcodigo  , 
                  clnombre  ,
                  clgeneric ,
                  cldirecc  ,
                  clcomuna  ,
                  clregion  ,
                  0	    ,
                  cltipcli  ,
                  clfecingr ,
                  clctacte  ,
                  clfono    ,
                  clfax 
             FROM CLIENTE
 	    ,     DATOS_GENERALES
       	    WHERE clrut    <> Rut_entidad 
   	      AND clrut    <> 97029000
   	      AND clrut     = @cRutCliente
   	      AND Bloqueado = 'N'
         ORDER BY clnombre
      
       RETURN
      END 

  SET NOCOUNT OFF

END





-- SP_CON_AYUDA_DEPENDENCIA 
GO
