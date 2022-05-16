USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEPLAZA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEEPLAZA]
as
begin   
 select  a.glosa
          from VIEW_AYUDA_PLANILLA a  
      
         where (a.codigo_tabla = 13 or a.codigo_tabla = 17) and  a.codigo_numerico <> 0
      order by a.glosa
end  


GO
