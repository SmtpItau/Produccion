USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMPIA_EVAL]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMPIA_EVAL](  @Rut_Cliente       NUMERIC (9,0)
                                         ,@Codigo_Cliente    NUMERIC (9,0)
)

AS
BEGIN 

 DELETE FROM BacSwapSuda..CARTERA__EVAL WHERE rut_cliente =@Rut_Cliente
                                         AND  codigo_cliente=@Codigo_Cliente
END
GO
