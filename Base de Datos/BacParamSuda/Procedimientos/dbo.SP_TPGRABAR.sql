USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TPGRABAR]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TPGRABAR    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TPGRABAR    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_TPGRABAR](  @prcodigo1  NUMERIC(3,0)  ,
                                  @prserie1  CHAR(12)  ,
                                  @prcupon1    NUMERIC(3,0)  ,
                                  @prpremio1  NUMERIC(9,4)  )
AS
BEGIN
set nocount on
       IF EXISTS(SELECT prcupon FROM PREMIO WHERE prcodigo = @prcodigo1 AND prserie = @prserie1 AND prcupon = @prcupon1 )
          UPDATE PREMIO SET prcodigo = @prcodigo1  ,
                          prserie  = @prserie1 ,
                          prcupon  = @prcupon1 , 
                          prpremio = @prpremio1 
                          WHERE  prcodigo = @prcodigo1 
                          AND    prserie  = @prserie1
                          AND    prcupon  = @prcupon1 
       ELSE 
           INSERT INTO PREMIO   (   prcodigo,   prserie,   prcupon,   prpremio )
                       VALUES ( @prcodigo1, @prserie1, @prcupon1, @prpremio1 )
IF @@error <> 0 BEGIN
  SELECT 'NO'
  SET NOCOUNT OFF
  RETURN
END
SELECT 'SI'
set nocount off
END 
GO
