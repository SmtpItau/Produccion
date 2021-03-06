USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALBASE_MONEDA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALBASE_MONEDA]
      (   @CODMONEDA   FLOAT   ,
          @FECHA       CHAR(12),
          @CODMONEDA1  FLOAT   )
AS 
BEGIN

SELECT 'vmvalor' = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA VM WHERE VM.vmcodigo = @CODMONEDA AND VM.vmfecha = @FECHA),1),
       mnbase, 
       (CASE WHEN mnmx = 'C' THEN 'S' ELSE 'N' END),
       mndecimal
  FROM VIEW_MONEDA MN
 WHERE MN.mncodmon  = @CODMONEDA1

END

GO
