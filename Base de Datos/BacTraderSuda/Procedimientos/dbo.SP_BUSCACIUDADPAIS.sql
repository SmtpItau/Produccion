USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACIUDADPAIS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCACIUDADPAIS] (@pais  numeric(3))
as 
 begin
        set nocount on
 select tbcodigo1,tbglosa from VIEW_TABLA_GENERAL_DETALLE where convert(numeric(6),tbcodigo1)=@pais
end


GO
