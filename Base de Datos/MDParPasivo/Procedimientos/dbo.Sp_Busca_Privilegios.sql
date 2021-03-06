USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Privilegios]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[Sp_Busca_Privilegios]( @tipo_privilegio CHAR(1)  ,
                                  @entidad         CHAR(3)  ,
                                  @usuario         CHAR(15) )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


SELECT opcion,
       habilitado        
  FROM PRIVILEGIO
 WHERE tipo_privilegio = @tipo_privilegio 
   AND usuario         = @usuario
   AND entidad         = @entidad

END   /* FIN PROCEDIMIENTO */


GO
