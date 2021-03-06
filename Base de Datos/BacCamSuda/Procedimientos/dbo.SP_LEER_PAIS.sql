USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PAIS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEER_PAIS] 
          ( @codigo  numeric( 3) =  0,
            @glosa   varchar(30) = '',
            @codbcch numeric( 3) =  0)
as
begin
     set nocount on
     select codigo_pais,
     nombre,
            '',
            0
       from view_pais
      where (@codigo  =  0 or codigo_pais = @codigo )
        and (@glosa   = '' or nombre like (@glosa + '%') )
      order by nombre
end
/*
SELECT *       from view_pais
CREATE PROCEDURE Sp_Leer_Pais 
          ( @codigo  numeric( 3) =  0,
            @glosa   varchar(30) = '',
            @codbcch numeric( 3) =  0)
as
begin
     set nocount on
     select codigo,
     glosa,
            nemo,
            codigobcch
       from TBPAISES
      where (@codigo  =  0 or codigo     = @codigo )
        and (@codbcch =  0 or codigobcch = @codbcch)
        and (@glosa   = '' or glosa  like (@glosa + '%') )
      order by glosa
end
*/



GO
