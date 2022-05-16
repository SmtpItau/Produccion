USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_CORRESPONSAL]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_CORRESPONSAL](
                                  @Rut_Cliente    NUMERIC(9,0) ,
      @Codigo_Cliente char (1)
                                 )
AS
  BEGIN
       DELETE  FROM cliente_corresponsal WHERE Rut_Cliente = @Rut_Cliente and Codigo_Cliente = @Codigo_Cliente 
  END

GO
