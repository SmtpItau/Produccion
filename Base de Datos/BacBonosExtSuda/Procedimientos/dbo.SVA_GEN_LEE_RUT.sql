USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_GEN_LEE_RUT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVA_GEN_LEE_RUT] 
(  	
    @clrut1 	numeric(9,0) ,
    @clcodigo 	numeric(9,0) 
)
as
begin
   set nocount on

        select  clrut     ,
                cldv      ,
                clcodigo  , 
                clnombre  ,
                clgeneric ,                
                cldirecc  ,
		clcomuna  ,
                clregion  ,
                clcompint ,
                cltipcli  ,
                clfecingr ,
                clctacte  ,
                clfono    ,
                clfax	  ,
		clvigente
	from
		BacParamSuda..Cliente
       
	where
		clrut 	 = @clrut1
	and	clcodigo = @clcodigo

set nocount off
       return
end

GO
