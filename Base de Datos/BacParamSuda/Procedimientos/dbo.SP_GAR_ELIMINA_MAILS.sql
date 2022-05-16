USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_ELIMINA_MAILS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GAR_ELIMINA_MAILS]( 
			@DireccionEmail  	varchar(50)  
		)
AS
BEGIN

	IF EXISTS( SELECT * FROM dbo.tbl_Gar_DireccionEmail WHERE DireccionEmail=@DireccionEmail )
		DELETE dbo.tbl_Gar_DireccionEmail 
		 WHERE DireccionEmail=@DireccionEmail ;
END 
GO
