USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDAPLEERRUT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDAPLEERRUT]  
       (
        @nrutcli     NUMERIC(9,0)  ,   -- RUT Cliente
        @ncodcli     NUMERIC(9,0)      -- Codigo Cliente 
       )
AS
BEGIN
SET NOCOUNT ON
    SELECT      aprutapo          ,
                apdvapo           ,
                apnombre	  ,
		apcargo		  ,
		apfono		  ,
		fecha_escritura
    FROM  View_Cliente_Apoderado
    WHERE aprutcli = @nrutcli and apcodcli= @ncodcli
SET NOCOUNT OFF
END

GO
