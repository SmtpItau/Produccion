USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INELIMINAR]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INELIMINAR] 
                  (@inserie1 char(10))
as
begin
        set nocount on
 delete VIEW_INSTRUMENTO where inserie = @inserie1
        set nocount off
        SELECT 'OK'
end


GO
