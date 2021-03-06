USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FRMMANTENEDORSERIES_GRABA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FRMMANTENEDORSERIES_GRABA](
       @letra_serie char(15),
       @nemotecnico char(10) )
AS
BEGIN
 SET NOCOUNT ON
 IF NOT EXISTS(SELECT 1 FROM LETRA_HIPOTECARIA_SERIE WHERE  letra_serie = @letra_serie ) BEGIN
  
  INSERT INTO LETRA_HIPOTECARIA_SERIE VALUES(
        @letra_serie,
        @nemotecnico )
  SELECT 'INSERTA'
 
 END
 ELSE BEGIN
  
  UPDATE LETRA_HIPOTECARIA_SERIE SET 
       letra_serie = @letra_serie,
       nemotecnico = @nemotecnico
     FROM   letra_hipotecaria_serie
     WHERE  letra_serie = @letra_serie 
 
  SELECT 'MODIFICA'
 END
 SET NOCOUNT OFF
END


GO
