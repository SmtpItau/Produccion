USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INS_VER_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INS_VER_DAT]
AS
BEGIN
IF (SELECT COUNT(*) FROM TEXT_SER)=0 BEGIN
    SELECT 0
END
ELSE BEGIN
    SELECT 1   
END
END 

GO
