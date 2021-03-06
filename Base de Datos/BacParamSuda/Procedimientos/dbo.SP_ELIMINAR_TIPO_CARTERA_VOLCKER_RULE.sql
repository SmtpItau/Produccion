USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAR_TIPO_CARTERA_VOLCKER_RULE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINAR_TIPO_CARTERA_VOLCKER_RULE] (
			@Id_Sistema  CHAR(3)        ,
			@ncodpro     CHAR(5))               
AS 
BEGIN
SET NOCOUNT On

/* LD1-COR-035 FUSION CORPBANCA - ITAU --> MANTENEDOR CARTERA VOLCKE RULE**/
/***********************************************************************/
/*SISTEMA: BACPARAMETROS */



 IF EXISTS(SELECT * FROM [TBL_CARTERA_PRODUCTO_VOLCKER_RULE] with(nolock) WHERE Id_Sistema = @Id_Sistema AND Id_Producto  = @ncodpro )  
    BEGIN
    DELETE [TBL_CARTERA_PRODUCTO_VOLCKER_RULE] WHERE Id_Sistema = @Id_Sistema AND Id_Producto = @ncodpro 
       IF @@ERROR <> 0 
          BEGIN
          SELECT 'ERROR'
       END ELSE
          BEGIN
          SELECT 'OK'
       END 
   END 
ELSE BEGIN
   SELECT 'NO EXISTE'
END
 
   SET NOCOUNT Off
  
END

GO
