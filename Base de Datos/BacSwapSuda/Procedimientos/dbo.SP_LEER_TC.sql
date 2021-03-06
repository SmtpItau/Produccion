USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_TC]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_TC]( 
                             @CodTab INTEGER  = 0 ,
                             @Codigo INTEGER  = 0 ,
                             @Glosa  CHAR(25) = '')
AS   
BEGIN
        
     SELECT Tbcateg, tbcodigo1, tbglosa
       FROM View_Tabla_General_Detalle
      WHERE (Tbcateg = @CodTab OR @CodTab =  0)
        AND (tbcodigo1 = @Codigo OR @Codigo =  0)
        AND (tbglosa LIKE '%' + @Glosa + '%' OR @Glosa = '')
     ORDER BY Tbcateg,tbcodigo1
END
GO
