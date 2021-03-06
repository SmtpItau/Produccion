USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BUSCA_PRIVILEGIOS]( @Tipo_Privilegio CHAR(1)  ,  
                                  @Entidad         CHAR(3)  ,
                                  @Usuario         CHAR(15) )
AS
BEGIN

set nocount on
SELECT Opcion,
       Habilitado        
  FROM VIEW_GEN_PRIVILEGIOS 
 WHERE Tipo_Privilegio = @Tipo_Privilegio 
   AND Usuario         = @Usuario
   AND Entidad         = @Entidad

set nocount off

END   /* FIN PROCEDIMIENTO */

--SELECT * FROM VIEW_GEN_PRIVILEGIOS  dbo.sp_help
GO
