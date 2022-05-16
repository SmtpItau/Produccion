USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABACIU]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABACIU](@cod_pai numeric(6),
                    @cod_ciu numeric(6),
                   @nom_ciu char(40))
as
begin
      set nocount on
   
    if exists(select * from VIEW_CIUDAD_COMUNA where cod_pai = @cod_pai and cod_ciu = @cod_ciu and cod_com = 0) begin  
       update VIEW_CIUDAD_COMUNA set nom_ciu = @nom_ciu where cod_pai=@cod_pai and cod_ciu=@cod_ciu and cod_com = 0        
    end else begin
       insert into VIEW_CIUDAD_COMUNA(cod_pai,cod_ciu,cod_com,nom_ciu) values (@cod_pai,@cod_ciu,0,@nom_ciu)
    end
   
 set nocount off
 SELECT 'OK'
 return
end


GO
