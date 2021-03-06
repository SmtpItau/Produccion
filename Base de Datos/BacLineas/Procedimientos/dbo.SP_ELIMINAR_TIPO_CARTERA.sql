USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINAR_TIPO_CARTERA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ELIMINAR_TIPO_CARTERA] (@Id_Sistema  CHAR(3)        ,
          @ncodpro     CHAR(5))               
AS 
BEGIN
SET NOCOUNT On
 IF EXISTS(SELECT * FROM TIPO_CARTERA WHERE rcsistema = @Id_Sistema AND rccodpro  = @ncodpro )  
    BEGIN
    DELETE TIPO_CARTERA WHERE rcsistema = @Id_Sistema AND rccodpro = @ncodpro 
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
---SP_HELPTEXT Sp_eliminar_tipo_cartera
  -- dbo.Sp_eliminar_tipo_cartera 'BFW','2'
--- SELECT * FROM TIPO_CARTERA
GO
