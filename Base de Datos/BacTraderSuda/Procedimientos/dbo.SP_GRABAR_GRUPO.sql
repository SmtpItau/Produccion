USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_GRUPO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABAR_GRUPO]
    (
    @lrut  numeric  (19,0) ,
    @lnombre char  (  40) ,
    @grupo          char            (   1) 
          )
as
begin
 if exists(select rut_grupo from LGRUPO where rut_grupo=@lrut) begin
  update LGRUPO
  set  rut_grupo  = @lrut ,
    glosa    = @lnombre   ,
                                grupo      = @grupo     
                where rut_grupo=@lrut
 
        end 
        else 
        begin
  insert LGRUPO
    (
    rut_grupo    ,
                                glosa                   ,
                                grupo 
       )                   
  values  (
    @lrut          ,
    @lnombre         ,
                                @grupo        
                                                        )
       end
end

GO
