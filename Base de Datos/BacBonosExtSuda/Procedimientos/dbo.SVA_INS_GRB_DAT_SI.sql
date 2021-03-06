USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_INS_GRB_DAT_SI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVA_INS_GRB_DAT_SI]
		(@cod_nemo		CHAR(20),
		 @sIsin			CHAR(15),
		 @sCursip		CHAR(15),
		 @sBBnums		CHAR(15),
		 @sSerie		CHAR(15),
		 @sMercado		CHAR(15),
		 @Codigo		INT)
AS 
Begin  
 declare @aux int
  
  IF (@Codigo = 0)
      BEGIN
	SELECT @aux=isnull(MAX(cod_id),0)+1 FROM text_ident
	  INSERT INTO text_ident(cod_id ,cod_Nemo ,sIsin ,sCusip  ,sBBNumber,sSerie ,sMercado)
	         VALUES (@aux,@cod_nemo,@sIsin,@sCursip,@sBBnums ,@sSerie,@sMercado)	
	  RETURN @aux 
      END
  ELSE
     UPDATE text_ident
	SET	sIsin		= @sIsin,
		sCusip		= @sCursip,
		sBBNumber	= @sBBnums,
		sSerie		= @sSerie,
		sMercado	= @sMercado	  
	WHERE cod_id=@Codigo
	AND cod_nemo=@cod_nemo  

     RETURN @Codigo 
end


GO
