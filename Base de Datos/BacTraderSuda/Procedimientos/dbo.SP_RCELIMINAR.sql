USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RCELIMINAR]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RCELIMINAR]
            (@rcrut1 NUMERIC(9,0))
AS
BEGIN
   set nocount on
       DELETE FROM VIEW_ENTIDAD WHERE rcrut = @rcrut1
   select 'OK'
   set nocount off
       RETURN
END

GO
