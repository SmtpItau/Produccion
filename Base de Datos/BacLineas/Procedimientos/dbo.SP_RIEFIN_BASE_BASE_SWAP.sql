USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_BASE_BASE_SWAP]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_BASE_BASE_SWAP]
( @Codigo numeric(5)
 ) 
As 
Begin 
    SET NOCOUNT ON    
	select Base  from bacSwapsuda..base where Codigo = @Codigo
End
GO
