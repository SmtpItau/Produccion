USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_RELACION_CLIENTE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Relacion_Cliente    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Elimina_Relacion_Cliente    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINA_RELACION_CLIENTE]  
                                              (@rut1      NUMERIC(10),
                                 @codigo1   NUMERIC( 3),
                                 @rut2      NUMERIC(10),
            @codigo2   NUMERIC( 3) )
AS
BEGIN
      SET NOCOUNT ON
       DELETE  
         FROM CLIENTE_RELACIONADO
         WHERE @rut1 = clrut_padre AND
               @codigo1 = clcodigo_padre  AND 
               @rut2 = clrut_hijo  AND 
               @codigo2 = clcodigo_hijo
SET NOCOUNT OFF
SELECT 'OK'
END
--
GO
