USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMONEDAS2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEMONEDAS2]
AS 
BEGIN
set nocount on
     SELECT mnglosa
           ,mnnemo
           ,mnrrda FROM VIEW_MONEDA WHERE mnmx = 'C' 
    SELECT 0
set nocount off
END

GO
