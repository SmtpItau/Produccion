USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TC]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_TC    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_TC    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEER_TC]( @codtab integer  = 0 ,
                             @codigo integer  = 0 ,
                             @glosa  char(25) = '')
AS   
BEGIN
        
     SELECT tbcateg, tbcodigo1, tbglosa
       FROM TABLA_GENERAL_DETALLE
      WHERE (tbcateg = @codtab or @codtab =  0)
        AND (tbcodigo1 = @codigo or @codigo =  0)
        AND (tbglosa LIKE '%' + @glosa + '%' or @glosa = '')
     ORDER BY tbcateg,tbcodigo1
END

GO
