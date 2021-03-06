USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLELIMINAR1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLELIMINAR1] ( @clrut1   NUMERIC(9,0) 
                                     ,@CLCODIGO numeric(9,0)
                                    )
AS
  BEGIN
       IF EXISTS(SELECT * FROM linea_general WHERE rut_cliente = @clrut1 and codigo_cliente = @CLCODIGO)
          BEGIN
             SELECT 'ERROR : CLIENTE POSEE LINEA, DEBE ELIMINAR LA LINEA ANTES QUE ELIMINE EL CLIENTE'
          END
       ELSE
          BEGIN
             DELETE  FROM CLIENTE WHERE clrut = @clrut1 and clcodigo = @clcodigo
             SELECT 'Eliminación se realizó correctamente' 
          END
  END
GO
