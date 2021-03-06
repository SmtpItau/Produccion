USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ARTICULO_84_CLIENTE_IMPUTABLE]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ARTICULO_84_CLIENTE_IMPUTABLE]
    @RUT_CLIENTE        DECIMAL(10,0)



AS
BEGIN

SET NOCOUNT ON



   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : VERIFICA SI CLIENTE ES IMPUTABLE                            */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 10/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     
	 DECLARE @IMPUTABLE CHAR(01)

   /*-----------------------------------------------------------------------------*/
   /* VERIFICAR SI EL CLIENTE ES IMPUTABLE AL ARTICULO 84                         */
   /*-----------------------------------------------------------------------------*/
     IF EXISTS(SELECT 1 
	             FROM BacParamSuda.dbo.TABLA_GENERAL_DETALLE
				WHERE tbcateg  = 9911
				  AND tbvalor  = @RUT_CLIENTE) BEGIN
        SET @IMPUTABLE    ='N'
     END
	 ELSE BEGIN
	    SET @IMPUTABLE    ='S'
	 END

   
     SELECT @IMPUTABLE AS IMPUTABLE


END

GO
