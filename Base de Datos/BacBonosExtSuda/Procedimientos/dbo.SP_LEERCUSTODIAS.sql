USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCUSTODIAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_LEERCUSTODIAS]
as
begin
       SET NOCOUNT ON
		
       select codigo,
	      glosa 	
        from  
              VIEW_CUSTODIA


        return
	
	SET NOCOUNT OFF
end

GO
