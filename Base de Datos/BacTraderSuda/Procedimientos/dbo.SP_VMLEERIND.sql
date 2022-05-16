USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VMLEERIND]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VMLEERIND] 
                             ( @NCODMON NUMERIC(03,00),
                               @DFECHA  DATETIME   )
AS
BEGIN
 DECLARE @NVALMON NUMERIC(19,04)
SET NOCOUNT ON
 IF @NCODMON = 999 
            SELECT @NVALMON = 1
   ELSE    
          SELECT  @NVALMON= VMVALOR
  FROM 
   VIEW_VALOR_MONEDA with(nolock)
  WHERE 
   VMCODIGO=@NCODMON 
  AND  VMFECHA=@DFECHA
 IF @NVALMON IS NULL  SELECT @NVALMON= 0
 SELECT @NVALMON
SET NOCOUNT OFF
END

GO
